import 'dart:io';

String readJson(String filePath) {
  File file = File(filePath);
  return file.readAsStringSync();
}
