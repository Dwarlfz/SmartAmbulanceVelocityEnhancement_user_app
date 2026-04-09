import 'package:flutter/material.dart';
import '../screens/emergency/emergency_form.dart';
import '../screens/auth/login_page.dart';
import '../screens/home/home_page.dart';
import '../screens/common/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String emergency = '/emergency';
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    home: (context) => HomePage(),
    emergency: (context) => EmergencyForm(),
  };
}