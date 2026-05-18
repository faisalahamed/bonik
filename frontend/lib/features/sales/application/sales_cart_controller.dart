import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

final salesCartProvider =
    NotifierProvider<SalesCartController, List<SalesCartLine>>(
      SalesCartController.new,
    );

final salesCheckoutProvider =
    NotifierProvider<SalesCheckoutController, SalesCheckoutState>(
      SalesCheckoutController.new,
    );

final salesEditSessionProvider =
    NotifierProvider<SalesEditSessionController, SalesEditSessionState>(
      SalesEditSessionController.new,
    );

class SalesCartController extends Notifier<List<SalesCartLine>> {
  @override
  List<SalesCartLine> build() => const [];

  int get itemCount => state.fold(0, (total, line) => total + line.quantity);

  double get total =>
      state.fold(0, (total, line) => total + (line.unitPrice * line.quantity));

  int quantityFor(String productId) {
    for (final line in state) {
      if (line.product.id == productId) {
        return line.quantity;
      }
    }
    return 0;
  }

  int quantityForProduct(LocalSalesProduct product) {
    for (final line in state) {
      if (_sameSalesProduct(line.product, product)) {
        return line.quantity;
      }
    }
    return 0;
  }

  bool addProduct(LocalSalesProduct product) {
    final updated = <SalesCartLine>[];
    var found = false;
    var added = false;

    for (final line in state) {
      if (_sameSalesProduct(line.product, product)) {
        final stockLimit = line.product.stockQuantity > product.stockQuantity
            ? line.product.stockQuantity
            : product.stockQuantity;
        if (line.quantity >= stockLimit) {
          updated.add(line);
          found = true;
          continue;
        }
        updated.add(line.copyWith(quantity: line.quantity + 1));
        found = true;
        added = true;
      } else {
        updated.add(line);
      }
    }

    if (!found) {
      if (product.stockQuantity < 1) {
        return false;
      }
      updated.add(SalesCartLine(product: product, quantity: 1));
      added = true;
    }

    state = updated;
    return added;
  }

  void increase(String productId) {
    state = [
      for (final line in state)
        if (line.product.id == productId &&
            line.quantity < line.product.stockQuantity)
          line.copyWith(quantity: line.quantity + 1)
        else
          line,
    ];
  }

  void decrease(String productId) {
    state = [
      for (final line in state)
        if (line.product.id == productId && line.quantity > 1)
          line.copyWith(quantity: line.quantity - 1)
        else
          line,
    ];
  }

  void decreaseProduct(LocalSalesProduct product) {
    state = [
      for (final line in state)
        if (_sameSalesProduct(line.product, product) && line.quantity > 1)
          line.copyWith(quantity: line.quantity - 1)
        else
          line,
    ];
  }

  void remove(String productId) {
    state = [
      for (final line in state)
        if (line.product.id != productId) line,
    ];
  }

  void removeProduct(LocalSalesProduct product) {
    state = [
      for (final line in state)
        if (!_sameSalesProduct(line.product, product)) line,
    ];
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity < 1) {
      remove(productId);
      return;
    }
    state = [
      for (final line in state)
        if (line.product.id == productId)
          line.copyWith(
            quantity: quantity > line.product.stockQuantity
                ? line.product.stockQuantity
                : quantity,
          )
        else
          line,
    ];
  }

  void updateUnitPrice(String productId, double unitPrice) {
    final normalizedPrice = unitPrice < 0 ? 0.0 : unitPrice;
    state = [
      for (final line in state)
        if (line.product.id == productId)
          line.copyWith(unitPrice: normalizedPrice)
        else
          line,
    ];
  }

  void replaceWith(List<SalesCartLine> lines) {
    state = List.unmodifiable(lines);
  }

  void clear() {
    state = const [];
  }
}

class SalesCheckoutController extends Notifier<SalesCheckoutState> {
  @override
  SalesCheckoutState build() => const SalesCheckoutState();

  void updateDiscount({required double percent, required double amount}) {
    state = state.copyWith(discountPercent: percent, discountAmount: amount);
  }

  void updateVat({required double percent, required double amount}) {
    state = state.copyWith(vatPercent: percent, vatAmount: amount);
  }

  void replaceWith(SalesCheckoutState checkout) {
    state = checkout;
  }

  void clear() {
    state = const SalesCheckoutState();
  }
}

class SalesEditSessionController extends Notifier<SalesEditSessionState> {
  @override
  SalesEditSessionState build() => const SalesEditSessionState();

  bool get isEditing => state.saleId != null;

  void start(LocalSaleEditDraft draft) {
    final subtotal = draft.lines.fold<double>(
      0,
      (total, line) => total + (line.unitPrice * line.quantity),
    );
    final discountPercent = subtotal <= 0
        ? 0.0
        : (draft.sale.discount / subtotal) * 100;
    final vatPercent = subtotal <= 0 ? 0.0 : (draft.sale.vat / subtotal) * 100;

    ref.read(salesCartProvider.notifier).replaceWith([
      for (final line in draft.lines)
        SalesCartLine(
          product: line.product,
          quantity: line.quantity,
          unitPrice: line.unitPrice,
        ),
    ]);
    ref
        .read(salesCheckoutProvider.notifier)
        .replaceWith(
          SalesCheckoutState(
            discountPercent: discountPercent,
            discountAmount: draft.sale.discount,
            vatPercent: vatPercent,
            vatAmount: draft.sale.vat,
          ),
        );

    state = SalesEditSessionState(
      saleId: draft.sale.id,
      customerName: draft.customer?.name ?? '',
      customerMobile: draft.customer?.phone ?? '',
      saleDate: draft.sale.createdAt.toLocal(),
      paymentMethod: draft.sale.paymentMethod ?? 'cash',
      paidAmount: draft.paidAmount,
    );
  }

  void clear() {
    state = const SalesEditSessionState();
  }
}

class SalesEditSessionState {
  const SalesEditSessionState({
    this.saleId,
    this.customerName = '',
    this.customerMobile = '',
    this.saleDate,
    this.paymentMethod = 'cash',
    this.paidAmount = 0,
  });

  final String? saleId;
  final String customerName;
  final String customerMobile;
  final DateTime? saleDate;
  final String paymentMethod;
  final double paidAmount;

  bool get isEditing => saleId != null;
}

class SalesCheckoutState {
  const SalesCheckoutState({
    this.discountPercent = 0,
    this.discountAmount = 0,
    this.vatPercent = 0,
    this.vatAmount = 0,
  });

  final double discountPercent;
  final double discountAmount;
  final double vatPercent;
  final double vatAmount;

  double grandTotal(double subtotal) {
    return (subtotal - discountAmount + vatAmount)
        .clamp(0, double.infinity)
        .toDouble();
  }

  SalesCheckoutState copyWith({
    double? discountPercent,
    double? discountAmount,
    double? vatPercent,
    double? vatAmount,
  }) {
    return SalesCheckoutState(
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      vatPercent: vatPercent ?? this.vatPercent,
      vatAmount: vatAmount ?? this.vatAmount,
    );
  }
}

class SalesCartLine {
  SalesCartLine({
    required this.product,
    required this.quantity,
    double? unitPrice,
  }) : unitPrice = unitPrice ?? product.sellingPrice;

  final LocalSalesProduct product;
  final int quantity;
  final double unitPrice;

  double get lineTotal => unitPrice * quantity;

  SalesCartLine copyWith({int? quantity, double? unitPrice}) {
    return SalesCartLine(
      product: product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}

bool _sameSalesProduct(LocalSalesProduct left, LocalSalesProduct right) {
  return _salesProductKey(left) == _salesProductKey(right);
}

String _salesProductKey(LocalSalesProduct product) {
  return '${product.categoryId ?? ''}\u001F${product.name.trim().toLowerCase()}';
}
