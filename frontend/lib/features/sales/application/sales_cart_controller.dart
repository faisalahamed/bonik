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

class SalesCartController extends Notifier<List<SalesCartLine>> {
  @override
  List<SalesCartLine> build() => const [];

  int get itemCount => state.fold(0, (total, line) => total + line.quantity);

  double get total => state.fold(
    0,
    (total, line) => total + (line.product.sellingPrice * line.quantity),
  );

  int quantityFor(String productId) {
    for (final line in state) {
      if (line.product.id == productId) {
        return line.quantity;
      }
    }
    return 0;
  }

  bool addProduct(LocalSalesProduct product) {
    final currentQuantity = quantityFor(product.id);
    if (currentQuantity >= product.stockQuantity) {
      return false;
    }

    final nextQuantity = currentQuantity + 1;
    final updated = <SalesCartLine>[];
    var found = false;

    for (final line in state) {
      if (line.product.id == product.id) {
        updated.add(line.copyWith(quantity: nextQuantity));
        found = true;
      } else {
        updated.add(line);
      }
    }

    if (!found) {
      updated.add(SalesCartLine(product: product, quantity: nextQuantity));
    }

    state = updated;
    return true;
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

  void remove(String productId) {
    state = [
      for (final line in state)
        if (line.product.id != productId) line,
    ];
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

  void clear() {
    state = const SalesCheckoutState();
  }
}

class SalesCheckoutState {
  const SalesCheckoutState({
    this.discountPercent = 15,
    this.discountAmount = 0,
    this.vatPercent = 15,
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
  const SalesCartLine({required this.product, required this.quantity});

  final LocalSalesProduct product;
  final int quantity;

  double get lineTotal => product.sellingPrice * quantity;

  SalesCartLine copyWith({int? quantity}) {
    return SalesCartLine(product: product, quantity: quantity ?? this.quantity);
  }
}
