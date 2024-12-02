import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geoportail/views/auth/login_page.dart';
import 'package:geoportail/views/splash/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX Navigation',
      initialRoute: '/', 
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()), 
        GetPage(name: '/login', page: () => LoginPage()),  
      ],
    );
  }
}
