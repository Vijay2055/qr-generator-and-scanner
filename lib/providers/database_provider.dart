import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/services/database_service.dart';

final databaseProvider=Provider((ref)=>DatabaseService());
