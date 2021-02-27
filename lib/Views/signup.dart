import 'package:expiry_date_alarm/Views/signin.dart';
import 'package:expiry_date_alarm/functions/constants.dart';
import 'package:expiry_date_alarm/services/auth.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';
import 'animations/FadeAnimation.dart';
import 'home.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  SignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signUpWithEmailAndPassword(email, password).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          Constants.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: MediaQuery.of(context).size.height - 50,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                              1,
                              Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.2,
                              Text(
                                "Create an account, It's free",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[700]),
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.2,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return val.isEmpty
                                          ? "Enter valid Name"
                                          : null;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                    ),
                                    onChanged: (val) {
                                      name = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                          FadeAnimation(
                              1.3,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return val.isEmpty
                                          ? "Enter valid email"
                                          : null;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                    ),
                                    onChanged: (val) {
                                      email = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                          FadeAnimation(
                              1.4,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return val.length < 8
                                          ? "Enter valid Password (must be atleast 8 characters)"
                                          : null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400])),
                                    ),
                                    onChanged: (val) {
                                      password = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      FadeAnimation(
                          1.5,
                          button(
                            "Sign Up",
                            SignUp,
                          )),
                      FadeAnimation(
                          1.6,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  " Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
