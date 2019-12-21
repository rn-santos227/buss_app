import 'dart:io';

import 'package:path_provider/path_provider.dart';
//Interacting with local cache file inside the mobile phone.
class LocalStorage {

  //fetch the relative path of the Data Cache file.
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  //fetch/create the local cache file.
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

//write contents inside the local cache file.
  static Future<File> writeContent(content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  //read the contents from the local cache file.
  static Future<String> readContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    }

    catch(e) {
      return e.toString();
    }
  }
}
