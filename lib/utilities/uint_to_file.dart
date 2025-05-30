import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

Future<String> getFilePath(Uint8List uint8list) async {
  // Get the temporary directory
  // get the unique id for storing the unique file name

  final uuid = const Uuid().v4();

  // get the temporary directory of application
  final directory = await getTemporaryDirectory();

  // create file path like tempdirectory/name_of_file
  final filePath = '${directory.path}/scanned_qr_$uuid.png';

  // Create a file object
  final file = File(filePath);

  // write to the file as Bytes to return file
  await file.writeAsBytes(uint8list);

// get application directory
  final appDir = await syspaths.getApplicationDocumentsDirectory();
  //  get the filename i.e temp/file_name=file_name
  final fileName = path.basename(file.path);
  //  copy the temporary file into the copied image
  final copiedImage = await file.copy('${appDir.path}/$fileName');

  return copiedImage.path;
}
