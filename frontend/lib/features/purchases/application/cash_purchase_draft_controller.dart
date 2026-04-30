import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

class CashPurchaseDraftState {
  const CashPurchaseDraftState({
    required this.purchaseDate,
    this.lines = const {},
    this.comment = '',
  });

  final DateTime purchaseDate;
  final Map<String, CashPurchaseDraftLine> lines;
  final String comment;

  List<CashPurchaseDraftLine> get selectedLines => lines.values.toList();

  CashPurchaseDraftState copyWith({
    DateTime? purchaseDate,
    Map<String, CashPurchaseDraftLine>? lines,
    String? comment,
  }) {
    return CashPurchaseDraftState(
      purchaseDate: purchaseDate ?? this.purchaseDate,
      lines: lines ?? this.lines,
      comment: comment ?? this.comment,
    );
  }
}

class CashPurchaseDraftLine {
  const CashPurchaseDraftLine({
    required this.category,
    this.quantity = '',
    this.buyingPrice = '',
    this.sellingPrice = '',
  });

  final LocalCategory category;
  final String quantity;
  final String buyingPrice;
  final String sellingPrice;

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
  }) {
    return CashPurchaseDraftLine(
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
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

  void clear() {
    state = CashPurchaseDraftState(purchaseDate: DateTime.now());
  }
}

final cashPurchaseDraftProvider =
    NotifierProvider<CashPurchaseDraftController, CashPurchaseDraftState>(
      CashPurchaseDraftController.new,
    );
