import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/api_service.dart';

abstract class SecureStorage{
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const String tokenKey='token';
  static const String userStateKey='userStateKey';
  static String? token;
  static bool hasToken = false,userState = true;

  static Future deleteToken()async{
    await storage.delete(key: tokenKey);
    hasToken=false;

  }
  static Future setToken(String x)async{
    ApiService.updateHeader({'Authorization': 'Bearer $x'});
    await storage.write(key: tokenKey, value: x);
    hasToken = true;
    token = x;

  }

  static Future getToken()async{
    var res = await storage.read(key: tokenKey);
    if(res != null) {
      hasToken = true;
      token = res;
    }
    return res;
  }

  static Future setUserState(bool x)async{
    await storage.write(key: userStateKey, value: x.toString());
    userState = x;
  }

  static Future getUserState()async{
    String? x = await storage.read(key: userStateKey);
    userState = bool.tryParse(x.toString())??true;
    // print(userState);
  }
}