class DateUtil {
  DateUtil._();

  static String timeAgo(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    final date = DateTime.tryParse(dateStr.replaceAll(' ', 'T'));
    if (date == null) return dateStr;
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m minute${m == 1 ? '' : 's'} ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h hour${h == 1 ? '' : 's'} ago';
    }
    if (diff.inDays < 30) {
      final d = diff.inDays;
      return '$d day${d == 1 ? '' : 's'} ago';
    }
    if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return '$mo month${mo == 1 ? '' : 's'} ago';
    }
    final yr = (diff.inDays / 365).floor();
    return '$yr year${yr == 1 ? '' : 's'} ago';
  }
}
