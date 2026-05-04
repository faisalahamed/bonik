import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

class CashPurchaseDraftState {
  const CashPurchaseDraftState({
    required this.purchaseDate,
    this.lines = const {},
    this.comment = '',
    this.supplierId,
    this.paymentMethod = 'due',
    this.paidAmount = '',
  });

  final DateTime purchaseDate;
  final Map<String, CashPurchaseDraftLine> lines;
  final String comment;
  final String? supplierId;
  final String paymentMethod;
  final String paidAmount;

  List<CashPurchaseDraftLine> get selectedLines => lines.values.toList();
  double get purchaseTotal {
    return lines.values.fold(0, (total, line) => total + line.purchaseTotal);
  }

  double get profitTotal {
    return lines.values.fold(0, (total, line) => total + line.profitTotal);
  }

  CashPurchaseDraftState copyWith({
    DateTime? purchaseDate,
    Map<String, CashPurchaseDraftLine>? lines,
    String? comment,
    String? supplierId,
    String? paymentMethod,
    String? paidAmount,
  }) {
    return CashPurchaseDraftState(
      purchaseDate: purchaseDate ?? this.purchaseDate,
      lines: lines ?? this.lines,
      comment: comment ?? this.comment,
      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }
}

class CashPurchaseDraftLine {
  const CashPurchaseDraftLine({
    required this.category,
    this.quantity = '',
    this.buyingPrice = '',
    this.sellingPrice = '',
    this.barcode = '',
  });

  final LocalCategory category;
  final String quantity;
  final String buyingPrice;
  final String sellingPrice;
  final String barcode;

  double get quantityValue => _parse(quantity);
  double get buyingPriceValue => _parse(buyingPrice);
  double get sellingPriceValue => _parse(sellingPrice);
  double get purchaseTotal => quantityValue * buyingPriceValue;
  double get profitTotal =>
      quantityValue * (sellingPriceValue - buyingPriceValue);
  double get profitPercent {
    if (buyingPriceValue <= 0 || sellingPriceValue <= 0) {
      return 0;
    }

    return ((sellingPriceValue - buyingPriceValue) / buyingPriceValue) * 100;
  }

  bool get hasLowerSellingPrice =>
      buyingPriceValue > 0 &&
      sellingPriceValue > 0 &&
      sellingPriceValue < buyingPriceValue;

  CashPurchaseDraftLine copyWith({
    LocalCategory? category,
    String? quantity,
    String? buyingPrice,
    String? sellingPrice,
    String? barcode,
  }) {
    return CashPurchaseDraftLine(
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      barcode: barcode ?? this.barcode,
    );
  }

  static double _parse(String text) {
    return double.tryParse(text.trim()) ?? 0;
  }
}

class CashPurchaseDraftController extends Notifier<CashPurchaseDraftState> {
  @override
  CashPurchaseDraftState build() {
    return CashPurchaseDraftState(purchaseDate: DateTime.now());
  }

  void addCategory(LocalCategory category) {
    if (state.lines.containsKey(category.id)) {
      return;
    }

    final lines = Map<String, CashPurchaseDraftLine>.from(state.lines);
    lines[category.id] = CashPurchaseDraftLine(category: category);
    state = state.copyWith(lines: lines);
  }

  void addCategories(List<LocalCategory> categories) {
    if (categories.isEmpty) {
      return;
    }

    final lines = Map<String, CashPurchaseDraftLine>.from(state.lines);
    var changed = false;
    for (final category in categories) {
      if (lines.containsKey(category.id)) {
        continue;
      }

      lines[category.id] = CashPurchaseDraftLine(category: category);
      changed = true;
    }

    if (!changed) {
      return;
    }

    state = state.copyWith(lines: lines);
  }

  void removeCategory(String categoryId) {
    final lines = Map<String, CashPurchaseDraftLine>.from(state.lines)
      ..remove(categoryId);
    state = state.copyWith(lines: lines);
  }

  void updateLine({
    required String categoryId,
    String? quantity,
    String? buyingPrice,
    String? sellingPrice,
    String? barcode,
  }) {
    final line = state.lines[categoryId];
    if (line == null) {
      return;
    }

    final lines = Map<String, CashPurchaseDraftLine>.from(state.lines);
    lines[categoryId] = line.copyWith(
      quantity: quantity,
      buyingPrice: buyingPrice,
      sellingPrice: sellingPrice,
      barcode: barcode,
    );
    state = state.copyWith(lines: lines);
  }

  void clearLineFields(String categoryId) {
    final line = state.lines[categoryId];
    if (line == null) {
      return;
    }

    final lines = Map<String, CashPurchaseDraftLine>.from(state.lines);
    lines[categoryId] = line.copyWith(
      quantity: '',
      buyingPrice: '',
      sellingPrice: '',
    );
    state = state.copyWith(lines: lines);
  }

  void setPurchaseDate(DateTime purchaseDate) {
    state = state.copyWith(purchaseDate: purchaseDate);
  }

  void setComment(String comment) {
    state = state.copyWith(comment: comment);
  }

  void setSupplier(String? supplierId) {
    state = CashPurchaseDraftState(
      purchaseDate: state.purchaseDate,
      lines: state.lines,
      comment: state.comment,
      supplierId: supplierId,
      paymentMethod: state.paymentMethod,
      paidAmount: state.paidAmount,
    );
  }

  void setPaymentMethod(String paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  void setPaidAmount(String paidAmount) {
    state = state.copyWith(paidAmount: paidAmount);
  }

  void clear() {
    state = CashPurchaseDraftState(purchaseDate: DateTime.now());
  }
}

final cashPurchaseDraftProvider =
    NotifierProvider<CashPurchaseDraftController, CashPurchaseDraftState>(
      CashPurchaseDraftController.new,
    );
