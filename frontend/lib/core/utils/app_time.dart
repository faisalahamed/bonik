class AppTime {
  const AppTime._();

  static DateTime nowUtc() => DateTime.now().toUtc();

  static DateTime toUtc(DateTime value) => value.isUtc ? value : value.toUtc();

  static DateTime toLocal(DateTime value) =>
      value.isUtc ? value.toLocal() : value;

  static String isoUtc(DateTime value) => toUtc(value).toIso8601String();

  static String? nullableIsoUtc(DateTime? value) =>
      value == null ? null : isoUtc(value);

  static DateTime startOfLocalDayUtc([DateTime? value]) {
    final local = (value ?? DateTime.now()).toLocal();
    return DateTime(local.year, local.month, local.day).toUtc();
  }

  static DateTime endOfLocalDayUtc([DateTime? value]) {
    return startOfLocalDayUtc(value).add(const Duration(days: 1));
  }

  static DateTime parseUtc(Object? value, {DateTime? fallback}) {
    return tryParseUtc(value) ?? fallback ?? nowUtc();
  }

  static DateTime? tryParseUtc(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return toUtc(value);
    }

    final text = value.toString().trim();
    if (text.isEmpty) {
      return null;
    }

    final normalized = _hasTimezone(text)
        ? text
        : '${text.replaceFirst(' ', 'T')}Z';
    return DateTime.tryParse(normalized)?.toUtc();
  }

  static bool _hasTimezone(String value) {
    return value.endsWith('Z') || RegExp(r'[+-]\d\d:?\d\d$').hasMatch(value);
  }
}
