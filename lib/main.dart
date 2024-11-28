import 'package:flutter/material.dart';
import 'package:mycalender/screens/timetable_screen.dart';
import 'screens/login_screen.dart';
import 'shared_preferences_helper.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), 
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication(); 
  }

  Future<void> _checkAuthentication() async {
    
    final token = await SharedPreferencesHelper.getToken();

    if (token != null && !_isTokenExpired(token)) {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TimetableScreen()),
      );
    } else {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  bool _isTokenExpired(String token) {
    return false; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), 
    );
  }
}
