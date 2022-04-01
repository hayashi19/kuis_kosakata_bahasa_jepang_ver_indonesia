// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Import Files
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/home.dart';

void main() async {
  await GetStorage.init(); 
  runApp(  
    GetMaterialApp(
      home: const Home(),
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeService().theme,
    )
  );
}

// Home class contain two pages class that for web desktop platform or for mobile android platform
class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(context) {
    return GetPlatform.isWeb ? const WebDesktopHome() : const MobileHome();
  }
}