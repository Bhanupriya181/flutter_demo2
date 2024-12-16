import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maidin_kenya/common/colors.dart';
import 'package:maidin_kenya/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

bool isValidEmail(String value) {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value);
}

bool isValidPassword(String value) {
  RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');
  return passwordRegex.hasMatch(value);
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  FocusNode userFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    userFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formfield,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Center(
                      child: Image.asset(
                        'asset/images/madini_kenya_ministry_logo.png',
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome to RMS",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: userController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: userFocusNode.hasFocus ? colorPrimary : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    focusNode: userFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: passwordFocusNode.hasFocus ? colorPrimary : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    focusNode: passwordFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!isValidPassword(value)) {
                        return 'Password must be at least 8 characters long, include an uppercase letter, lowercase letter, number, and special character';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () async {
                      if (_formfield.currentState!.validate()) {
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 8,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
