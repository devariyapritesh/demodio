import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class MyApplication {
  static Future<bool?> checkConnectivity(BuildContext context,{bool showMsg = true}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      if (showMsg) {
        log("network problem");
      }
      return false;
    }
  }
}