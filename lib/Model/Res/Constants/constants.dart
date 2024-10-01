import '../../../global_provider.dart';

// String? getCurrentUid(){
//   final provider = GlobalProviderAccess.profilePro;
//   String email = provider!.doctorEmail;
//   return email;
// }

String convertTimestamp(String timestampString) {
  DateTime parsedTimestamp = parseTimestamp(timestampString);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}d';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '${months}mm';
  } else {
    final years = difference.inDays ~/ 365;
    return '${years}y';
  }
}DateTime parseTimestamp(String timestampString) {
  return DateTime.parse(timestampString);
}