import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'FirebaseApi.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

fetchdata(String url) async{
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

upload_file(String file_path, String file_name) async{
  final file = File(file_path);
  final destination = '$file_name';

  UploadTask? task =  FirebaseApi.uploadFile(destination, file);
  if (task == null) return;

  final snapshot = await task.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();

  print('Download-Link: $urlDownload');

  String url = "http://10.0.2.2:5000/api-video?query=" + file_name;
  var data = await fetchdata(url.toString());
  var decoded = jsonDecode(data);
  print("Done");
  return decoded;
}

