import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:demodio/MyApplication.dart';
import 'package:demodio/api/ApiCalls.dart';
import 'package:demodio/api/RequestModel/RequestLoginUser.dart';
import 'package:demodio/api/ResponseModel/ResponseLoginUser.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  String TAG = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AutomaticKeepAliveClientMixin<LoginScreen>, AfterLayoutMixin<LoginScreen> {

  ValueNotifier<bool> vnIsDataAvailable = ValueNotifier(false);
  ValueNotifier<bool> vnIsApiComplete = ValueNotifier(false);
  ValueNotifier<bool> vnIsInternetConnection = ValueNotifier(true);

  @override
  void initState() {
      super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> callLoginUser() async{
    MyApplication.checkConnectivity(context).then((internet) async {
      if (internet != null && internet) {
        try {
          ResponseLoginUser? response =
          await ApiCalls.callLoginUser(RequestLoginUser(id: "1",name: "raj"));
          if (response != null) {
            if (response.result != null && response.result!.length != 0 && response.result!.toLowerCase() == "success") {
              // add here some data on list
              vnIsDataAvailable.value = true;
            } else {

              vnIsDataAvailable.value = false;
            }
          }
        } on Exception catch (exception) {
          log("response = $exception",name: "Exception", error: widget.TAG);
          vnIsDataAvailable.value = false;
        } catch (error) {
          log("response = $error", name: "Error", error: widget.TAG);
          vnIsDataAvailable.value = false;
        } finally{
          vnIsApiComplete.value = true;
          vnIsInternetConnection.value = true;
        }
      }
      else{
        vnIsInternetConnection.value = false;
        vnIsDataAvailable.value = false;
        vnIsApiComplete.value = false;
      }
    });
  }
}
