import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<File> uint8ListToFile(Uint8List uint8list, String filename) async {
  // Get the temporary directory
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/$filename';
  
  // Create and write to the file
  final file = File(filePath);
  await file.writeAsBytes(uint8list);
  
  return file;
}
