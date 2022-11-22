import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:demodio/api/ApiList.dart';
import 'package:demodio/api/ApiUtils.dart';
import 'package:demodio/api/RequestModel/RequestAddFeedback.dart';
import 'package:demodio/api/RequestModel/RequestAddImage.dart';
import 'package:demodio/api/RequestModel/RequestLoginUser.dart';
import 'package:demodio/api/ResponseModel/ResponseAddFeedback.dart';
import 'package:demodio/api/ResponseModel/ResponseLoginUser.dart';
import 'package:dio/dio.dart';
import 'package:stack_trace/stack_trace.dart';

class ApiCalls{

  static bool _showLocationLogs = true;

  static Dio _getDio() {
    final dio = Dio();
    return dio;
  }

  //TODO : CALL LOGIN USER
  static Future<ResponseLoginUser?> callLoginUser(RequestLoginUser? model) async {
    //TODO: STEP 1 : HERE CHANGES REQUEST AND RESPONSE MODEL NAME
    String TAG = (_showLocationLogs == true ? Trace.current().frames[0].location + " " : "") + Trace.current().frames[0].member!;

    FormData formData = FormData.fromMap(ApiUtils.getRequestMapForDio(requestString : jsonEncode(model)));
    try {
      //TODO: STEP 2 : HERE CHANGES REQUEST URL
      log("Request URL = ${ApiList.urlUserLogin}", name: TAG);
      log("Request Data= ${formData.fields}", name: TAG);
      Response response = await _getDio().post(ApiList.urlUserLogin, data: formData);
      log("Response status or statusCode  = ${response.statusCode}", name: TAG);
      if(response.statusCode == HttpStatus.ok){
        if(response.data != null){
          log("Response data = ${response.data}", name: TAG);
          //TODO: Change Response Model
          return ResponseLoginUser.fromJson(jsonDecode(response.data));
        } else{
          log("Response data = null", name: TAG);
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("Error = $e", name: TAG);
    }
    return null;
  }

  //TODO : ADD FEEDBACK DATA
  static Future<ResponseAddFeedback?> callAddFeedbackData(RequestAddFeedback? model,RequestAddImage newsImageModel) async {

    //TODO: STEP 1 : HERE CHANGES REQUEST AND RESPONSE MODEL NAME
    String TAG = (_showLocationLogs == true ? Trace.current().frames[0].location + " " : "") + Trace.current().frames[0].member!;

    FormData formData = FormData.fromMap(ApiUtils.getRequestMapForDio(requestString : jsonEncode(model)));
    formData.files.add(MapEntry(ApiUtils.IMAGE_KEY, await MultipartFile.fromFile(newsImageModel.image!,filename: newsImageModel.image?.split("/").last))); // here data passed into MapEntry as a key and value format.

    try {
      //TODO: STEP 2 : HERE CHANGES REQUEST URL
      log("Request URL = ${ApiList.urlAddFeedback}", name: TAG);
      log("Request Data= ${formData.fields}", name: TAG);
      Response response = await _getDio().post(ApiList.urlAddFeedback, data: formData);
      log("Response status or statusCode  = ${response.statusCode}", name: TAG);
      if(response.statusCode == HttpStatus.ok){
        if(response.data != null){
          log("Response data = ${response.data}", name: TAG);
          //TODO: Change Response Model
          return ResponseAddFeedback.fromJson(jsonDecode(response.data));
        } else{
          log("Response data = null", name: TAG);
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("Error = $e", name: TAG);
    }
    return null;
  }

}