import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../screens/SettingsPage.dart';

class FileManager{
  
  //Recupero posizione della cartella documents
  static Future<String> get _localPath async{
      final Directory directory = await getApplicationDocumentsDirectory();
      return directory.path;
  }

  Future<void> salvaPercorsi() async {
    final Directory directory = await getApplicationDocumentsDirectory();

    File file = await File(join(directory.path, "mieiFile.txt"));
    String percorsi = "";
    List content = Directory(directory.path).listSync();
    for (var fileOrDir in content) {
      if (fileOrDir is File) {
        String test = fileOrDir.path.substring(fileOrDir.parent.path.length+1);
        if((test.substring(test.length-3)) == "txt" && !(test == "mieiFile.txt" || test == "tema.txt")){
          percorsi += fileOrDir.path.substring(fileOrDir.parent.path.length+1) + ",\n";
        }
      }
    }
    file.writeAsString(percorsi);
  }

  //Riferimento al file fisico in documents
  static Future<File> get _localFile async{
      final path = await _localPath;
      return File(join(path, "tema.txt"));
  }

  //Riferimento al file fisico in documents
  static Future<File> get _localFileConfigurazione async{
    final path = await _localPath;
    return File(join(path, "mieiFile.txt"));
  }

  //Salva il file
  static Future<bool> save(String data) async{
     File file = await _localFile;
     //aggiungi sostituendo
     file.writeAsString(data);
     //file.writeAsString(data, mode: FileMode.append)
     return true;
  }

  //Salva il file quando è stato già scelto il tema
  static Future<bool> saveAppend(String data) async{
    File file = await _localFile;
    //aggiungi sostituendo
    file.writeAsString(data, mode: FileMode.append);
    //file.writeAsString(data, mode: FileMode.append)
    return true;
  }

  //Salva il file
  static Future<bool> saveConfigurazione(String data,String nomeFile) async{
    //File file = await _localFile;
    final path = await _localPath;
    File mioFile = File(join(path, nomeFile+".txt"));
    //aggiungi sostituendo
    mioFile.writeAsString(data);
    //file.writeAsString(data, mode: FileMode.append)
    return true;
  }

  static Future<String> load() async{
      File file = await _localFile;
      return file.readAsString();
  }

  static Future<String> loadConfigurazione() async{
    File file = await _localFileConfigurazione;
    return file.readAsString();
  }

}