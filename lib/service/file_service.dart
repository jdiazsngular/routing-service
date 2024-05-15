import 'dart:io';

class FileService {
  static Future<String> loadFile(String strFile) async {
    try {
      String contenido = await File(strFile).readAsString();
      return contenido;
    } catch (e) {
      print('Error al leer el archivo: $e');
      return '';
    }
  }
}
