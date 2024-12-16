import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maidin_kenya/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [colorPrimary1,colorPrimary,colorPrimary2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset('asset/images/madini_kenya_logo2.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAuthentication() async {
    var sharedPref = await SharedPreferences.getInstance();
   var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(const Duration(seconds: 3), () {

      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(),));
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
    );
  }
}



