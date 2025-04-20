import 'package:intl/intl.dart';
  
  String get currentDateTime {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    print(formatter.format(now));
    return formatter.format(now);
  }