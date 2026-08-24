/// Search helpers. Display values are never mutated; these produce index/query forms.
class SearchNormalizer {
  const SearchNormalizer();

  /// Lowercase, collapse whitespace. Used for [customers.name_search].
  String normalizeName(String raw) {
    return raw.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Digits only. Used for [customers.phone_search]. Leading zeros are kept.
  String? normalizePhone(String? raw) {
    if (raw == null) return null;
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    return digits;
  }

  /// Escape `\`, `%`, and `_` so user input cannot broaden a SQL LIKE.
  String escapeLike(String raw) {
    return raw
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }

  /// Pattern for `LIKE ? ESCAPE '\'` against a normalized name or phone index.
  String likeContains(String raw, {required bool phone}) {
    final normalized = phone ? (normalizePhone(raw) ?? '') : normalizeName(raw);
    return '%${escapeLike(normalized)}%';
  }
}
