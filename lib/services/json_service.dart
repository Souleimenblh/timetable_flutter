import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class JsonService {
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/db.json');
  }

  static Future<Map<String, dynamic>> readJson() async {
    final file = await _getFile();

    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    } else {
      return {'sessions': [], 'rooms': [], 'teachers': []};
    }
  }

  static Future<void> writeJson(Map<String, dynamic> data) async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(data));
  }
}
