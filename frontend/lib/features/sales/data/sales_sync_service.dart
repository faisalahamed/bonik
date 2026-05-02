import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final salesSyncServiceProvider = Provider<SalesSyncService>((ref) {
  return SalesSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class SalesSyncService {
  const SalesSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncSales() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPendingCustomers();
    await _pushPendingSales();
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPendingCustomers() async {
    final pendingCustomers = await database.getPendingCustomers();

    for (final customer in pendingCustomers) {
      final response = await apiClient.postJson(
        '/customers',
        body: _customerToJson(customer),
      );
      final syncedCustomer = response['customer'];
      final syncedId = syncedCustomer is Map<String, dynamic>
          ? syncedCustomer['id']?.toString()
          : null;
      if (syncedId == null) {
        throw StateError('Customer sync did not return a customer id.');
      }
      if (syncedId != customer.id) {
        if (syncedCustomer is! Map<String, dynamic>) {
          throw StateError('Customer sync returned an invalid customer.');
        }
        await database.mergeCustomerId(
          localId: customer.id,
          syncedId: syncedId,
          syncedCustomer: _customerFromJson(syncedCustomer),
        );
        continue;
      }
      await database.markCustomerSynced(customer.id);
    }
  }

  Future<void> _pushPendingSales() async {
    final bundles = await database.getPendingSaleBundles();

    for (final bundle in bundles) {
      final response = await apiClient.postJson(
        '/sales',
        body: _bundleToJson(bundle),
      );
      final syncedSale = response['sale'];
      final syncedId = syncedSale is Map<String, dynamic>
          ? syncedSale['id']?.toString()
          : null;
      if (syncedId != bundle.sale.id) {
        throw StateError('Sale sync returned a different sale id.');
      }
      await database.markSaleBundleSynced(bundle.sale.id);
    }
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final customerResponse = await apiClient.getJson(
      '/customers',
      queryParameters: {'shop_id': shopId},
    );
    final rawCustomers = customerResponse['customers'];
    if (rawCustomers is List) {
      await database.upsertSyncedCustomers(
        rawCustomers
            .whereType<Map<String, dynamic>>()
            .map(_customerFromJson)
            .toList(),
      );
    }

    final saleResponse = await apiClient.getJson(
      '/sales',
      queryParameters: {'shop_id': shopId},
    );
    final rawSales = saleResponse['sales'];
    if (rawSales is List) {
      final saleRows = rawSales
          .whereType<Map<String, dynamic>>()
          .map(_bundleFromJson)
          .toList();
      await database.upsertSyncedSaleBundles(saleRows);
    }
  }

  Map<String, dynamic> _customerToJson(LocalCustomer customer) {
    return {
      'id': customer.id,
      'shop_id': customer.shopId,
      'name': customer.name,
      'email': customer.email,
      'phone': customer.phone,
      'address': customer.address,
      'notes': customer.notes,
      'created_at': customer.createdAt.toIso8601String(),
      'updated_at': customer.updatedAt.toIso8601String(),
      'deleted_at': customer.deletedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> _bundleToJson(LocalSaleBundle bundle) {
    return {
      'sale': {
        'id': bundle.sale.id,
        'shop_id': bundle.sale.shopId,
        'customer_id': bundle.sale.customerId,
        'subtotal': bundle.sale.subtotal,
        'discount': bundle.sale.discount,
        'vat': bundle.sale.vat,
        'total': bundle.sale.total,
        'status': bundle.sale.status,
        'payment_method': bundle.sale.paymentMethod,
        'created_at': bundle.sale.createdAt.toIso8601String(),
        'updated_at': bundle.sale.updatedAt.toIso8601String(),
      },
      'items': [
        for (final item in bundle.items)
          {
            'id': item.id,
            'shop_id': item.shopId,
            'order_id': item.orderId,
            'product_id': item.productId,
            'buy_price': item.buyPrice,
            'sale_price': item.salePrice,
            'quantity': item.quantity,
            'price': item.price,
            'created_at': item.createdAt.toIso8601String(),
            'updated_at': item.updatedAt.toIso8601String(),
          },
      ],
      'payments': [
        for (final payment in bundle.payments)
          {
            'id': payment.id,
            'shop_id': payment.shopId,
            'customer_id': payment.customerId,
            'order_id': payment.orderId,
            'payments': payment.payments,
            'description': payment.description,
            'created_at': payment.createdAt.toIso8601String(),
            'updated_at': payment.updatedAt.toIso8601String(),
          },
      ],
      'cash_transactions': [
        for (final transaction in bundle.cashTransactions)
          {
            'id': transaction.id,
            'shop_id': transaction.shopId,
            'type': transaction.type,
            'direction': transaction.direction,
            'amount': transaction.amount,
            'reference_id': transaction.referenceId,
            'reference_type': transaction.referenceType,
            'method': transaction.method,
            'note': transaction.note,
            'created_at': transaction.createdAt.toIso8601String(),
            'updated_at': transaction.updatedAt.toIso8601String(),
          },
      ],
    };
  }

  LocalCustomersCompanion _customerFromJson(Map<String, dynamic> json) {
    return LocalCustomersCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      name: Value(json['name']?.toString() ?? 'Walk-in Customer'),
      email: Value(_nullableString(json['email'])),
      phone: Value(_nullableString(json['phone'])),
      address: Value(_nullableString(json['address'])),
      notes: Value(_nullableString(json['notes'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      deletedAt: Value(_nullableDateTime(json['deleted_at'])),
      syncStatus: const Value('synced'),
    );
  }

  LocalSaleBundleCompanion _bundleFromJson(Map<String, dynamic> json) {
    final saleId = json['id'].toString();
    final rawItems = json['items'];
    final rawPayments = json['payments'];
    final rawCashTransactions =
        json['cash_transactions'] ?? json['cashTransactions'];

    return LocalSaleBundleCompanion(
      sale: LocalSalesCompanion(
        id: Value(saleId),
        shopId: Value(json['shop_id'].toString()),
        customerId: Value(json['customer_id'].toString()),
        subtotal: Value(_double(json['subtotal'])),
        discount: Value(_double(json['discount'])),
        vat: Value(_double(json['vat'])),
        total: Value(_double(json['total'])),
        status: Value(json['status']?.toString() ?? 'completed'),
        paymentMethod: Value(_nullableString(json['payment_method'])),
        createdAt: Value(_dateTime(json['created_at'])),
        updatedAt: Value(_dateTime(json['updated_at'])),
        syncStatus: const Value('synced'),
      ),
      items: [
        if (rawItems is List)
          for (final item in rawItems.whereType<Map<String, dynamic>>())
            LocalSaleItemsCompanion(
              id: Value(item['id'].toString()),
              shopId: Value(item['shop_id'].toString()),
              orderId: Value(item['order_id']?.toString() ?? saleId),
              productId: Value(item['product_id'].toString()),
              buyPrice: Value(_double(item['buy_price'])),
              salePrice: Value(_double(item['sale_price'])),
              quantity: Value(_int(item['quantity'])),
              price: Value(_double(item['price'])),
              createdAt: Value(_dateTime(item['created_at'])),
              updatedAt: Value(_dateTime(item['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
      payments: [
        if (rawPayments is List)
          for (final payment in rawPayments.whereType<Map<String, dynamic>>())
            LocalCustomerPaymentsCompanion(
              id: Value(payment['id'].toString()),
              shopId: Value(payment['shop_id'].toString()),
              customerId: Value(payment['customer_id'].toString()),
              orderId: Value(payment['order_id']?.toString() ?? saleId),
              payments: Value(_double(payment['payments'])),
              description: Value(_nullableString(payment['description'])),
              createdAt: Value(_dateTime(payment['created_at'])),
              updatedAt: Value(_dateTime(payment['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
      cashTransactions: [
        if (rawCashTransactions is List)
          for (final transaction
              in rawCashTransactions.whereType<Map<String, dynamic>>())
            LocalCashTransactionsCompanion(
              id: Value(transaction['id'].toString()),
              shopId: Value(transaction['shop_id'].toString()),
              type: Value(transaction['type']?.toString() ?? 'sale'),
              direction: Value(transaction['direction']?.toString() ?? 'in'),
              amount: Value(_double(transaction['amount'])),
              referenceId: Value(
                _nullableString(transaction['reference_id']) ?? saleId,
              ),
              referenceType: Value(
                _nullableString(transaction['reference_type']) ?? 'sale',
              ),
              method: Value(_nullableString(transaction['method'])),
              note: Value(_nullableString(transaction['note'])),
              createdAt: Value(_dateTime(transaction['created_at'])),
              updatedAt: Value(_dateTime(transaction['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
    );
  }

  String? _nullableString(Object? value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  double _double(Object? value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int _int(Object? value) {
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  DateTime _dateTime(Object? value) {
    return _nullableDateTime(value) ?? DateTime.now();
  }

  DateTime? _nullableDateTime(Object? value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
