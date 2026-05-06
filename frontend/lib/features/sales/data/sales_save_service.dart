import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/app_time.dart';
import '../application/sales_cart_controller.dart';

final salesSaveServiceProvider = Provider<SalesSaveService>((ref) {
  return SalesSaveService(database: ref.watch(appDatabaseProvider));
});

class SalesSaveService {
  const SalesSaveService({required this.database});

  final AppDatabase database;

  Future<String> saveSaleLocally({
    required List<SalesCartLine> cartLines,
    required SalesCheckoutState checkout,
    required double cashReceived,
    required String paymentMethod,
    required String customerName,
    required String customerMobile,
  }) async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (cartLines.isEmpty) {
      throw StateError('কার্টে কোনো পণ্য নেই।');
    }

    final now = AppTime.nowUtc();
    final customer = await database.getOrCreateCustomer(
      shopId: currentUser.shopId,
      name: customerName.trim().isEmpty ? 'Walk-in Customer' : customerName,
      phone: customerMobile,
    );
    final subtotal = cartLines.fold<double>(
      0,
      (total, line) => total + line.lineTotal,
    );
    final total = checkout.grandTotal(subtotal);
    final paidAmount = cashReceived.clamp(0, total).toDouble();
    final saleId = const Uuid().v4();
    final saleItems = <LocalSaleItemsCompanion>[];

    for (final line in cartLines) {
      var remainingQuantity = line.quantity;
      final batches = await database.getAvailablePurchaseBatches(
        shopId: currentUser.shopId,
        productName: line.product.name,
        categoryId: line.product.categoryId,
      );

      for (final batch in batches) {
        if (remainingQuantity <= 0) {
          break;
        }

        final quantity = remainingQuantity > batch.availableQuantity
            ? batch.availableQuantity
            : remainingQuantity;
        saleItems.add(
          LocalSaleItemsCompanion(
            id: Value(const Uuid().v4()),
            shopId: Value(currentUser.shopId),
            orderId: Value(saleId),
            productId: Value(batch.id),
            buyPrice: Value(batch.buyingPrice),
            salePrice: Value(line.product.sellingPrice),
            quantity: Value(quantity),
            price: Value(line.product.sellingPrice * quantity),
            createdAt: Value(now),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
        remainingQuantity -= quantity;
      }

      if (remainingQuantity > 0) {
        throw StateError('${line.product.name} পণ্যের পর্যাপ্ত স্টক নেই।');
      }
    }

    final status = paidAmount >= total ? 'completed' : 'pending';
    await database.insertSaleBundle(
      customer: customer.toCompanion(true),
      sale: LocalSalesCompanion(
        id: Value(saleId),
        shopId: Value(currentUser.shopId),
        customerId: Value(customer.id),
        subtotal: Value(subtotal),
        discount: Value(checkout.discountAmount),
        vat: Value(checkout.vatAmount),
        total: Value(total),
        status: Value(status),
        paymentMethod: Value(paymentMethod),
        createdAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
      items: saleItems,
      payment: paidAmount > 0
          ? LocalCustomerPaymentsCompanion(
              id: Value(const Uuid().v4()),
              shopId: Value(currentUser.shopId),
              customerId: Value(customer.id),
              orderId: Value(saleId),
              payments: Value(paidAmount),
              description: Value(_paymentDescription(paymentMethod)),
              createdAt: Value(now),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            )
          : null,
      cashTransaction: paidAmount > 0
          ? LocalCashTransactionsCompanion(
              id: Value(const Uuid().v4()),
              shopId: Value(currentUser.shopId),
              type: const Value('sale'),
              direction: const Value('in'),
              amount: Value(paidAmount),
              referenceId: Value(saleId),
              referenceType: const Value('sale'),
              method: Value(paymentMethod),
              note: Value(_paymentDescription(paymentMethod)),
              createdAt: Value(now),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            )
          : null,
    );

    return saleId;
  }

  String _paymentDescription(String paymentMethod) {
    return switch (paymentMethod) {
      'cash' => 'নগদ টাকা',
      'due' => 'বাকি',
      'mobile_banking' => 'বিকাশ/নগদ',
      _ => paymentMethod,
    };
  }
}
