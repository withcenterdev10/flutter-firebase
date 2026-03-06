class StringUtil {
  StringUtil._();

  static String initials(String? name) {
    final n = name ?? '';
    return n.length >= 2 ? n.substring(0, 2).toUpperCase() : n.toUpperCase();
  }

  static String displayName(String? name) {
    final n = name ?? '';
    if (n.isEmpty) return n;
    return n[0].toUpperCase() + n.substring(1);
  }
}
