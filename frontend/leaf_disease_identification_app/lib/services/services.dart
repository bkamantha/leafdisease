import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_disease_identification_app/Models/information.dart';
import 'package:leaf_disease_identification_app/Models/results_class.dart';
import 'package:leaf_disease_identification_app/api_constant.dart';

class Services {
  Dio dio = Dio();
  //String url = "http://10.0.2.2:8000/detection/";
  String url = ApiConstants.bASEURL;
  late XFile imageFile;
  late List<Information> informationList;

  imageUploadService(image) async {
    try {
      imageFile = image;
      String fileName = imageFile.path.split('/').last;
      String filePath = imageFile.path;
      // pass data to backend
      FormData data = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            filePath,
            filename: fileName,
          ),
        },
      );
      final response = await dio.post(
        url,
        data: data,
      );
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16.0,
      );
      debugPrint(e.toString());
    }
  }

  getInfoServices() async {
    try {
      final response = await dio.get("${url}info");

      List<dynamic> data = response.data;
      List<Information> informationList =
          data.map((json) => Information.fromJson(json)).toList();
      return informationList;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16.0,
      );
      debugPrint(e.toString());
    }
  }

  getResultsServices() async {
    try {
      final response = await dio.get(url);
      Result result = Result.fromJson(response.data);
      debugPrint(result.toString());
      return result;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16.0,
      );
      debugPrint(e.toString());
    }
  }
}
