import 'package:expiry_date_alarm/Views/signup.dart';
import 'package:expiry_date_alarm/functions/constants.dart';
import 'package:expiry_date_alarm/services/auth.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';
import 'animations/FadeAnimation.dart';
import 'package:toast/toast.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  AuthService authService = new AuthService();

  bool isLoading = false;

  SignIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((val) {
        if (val != null) {
          setState(() {
            isLoading = false;
          });
          Constants.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            isLoading = false;
          });
          Toast.show("User does not exist", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1,
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Login to your account",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700]),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: <Widget>[
                                FadeAnimation(
                                    1.2,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                ? "Enter correct email"
                                                : null;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
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
                                    1.3,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            return val.isEmpty
                                                ? "Enter correct Password"
                                                : null;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
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
                          ),
                          FadeAnimation(
                              1.4,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: button("Login", SignIn),
                              )),
                          FadeAnimation(
                              1.5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    FadeAnimation(
                        1.2,
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/reminder2.png'),
                                  fit: BoxFit.fill)),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
