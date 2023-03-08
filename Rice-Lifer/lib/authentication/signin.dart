import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricelife/Agro/agroshop.dart';
import 'package:ricelife/Home/home.dart';
import 'package:ricelife/authentication/signup.dart';
import 'package:ricelife/splasher/splash.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
  bool onpressed = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  List array = [
    'https://img.freepik.com/free-vector/support-local-farmers-concept_52683-41846.jpg?w=996&t=st=1657952740~exp=1657953340~hmac=6a22fec44b26e0fc81821494daa41928c88e48c760ea4ec36c6c61dd6afaa1f9',
    'https://img.freepik.com/free-vector/farmer-set_23-2148528259.jpg?w=996&t=st=1657952778~exp=1657953378~hmac=b3e52b7ebf6840f02f22dc17310a348e5d5b2e8387b02562417ced1e78b513e0',
  ];
  int counter1 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email = '';
      password = '';
    });
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (counter1 < 100) {
          counter1 += 1;
        } else {
          counter1 = 0;
        }
      });
    });
  }

  Widget Mywidget() {
    return (counter1 % 2 == 0)
        ? Image.network(
            array[1],
            fit: BoxFit.cover,
            height: 250,
            width: 300,
          )
        : Image.network(
            array[0],
            fit: BoxFit.cover,
            height: 250,
            width: 300,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'RICE-LIFER',
                    style: GoogleFonts.oleoScript(
                      textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                child: Mywidget(),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.lightGreen),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      hintText: 'Email',
                      focusColor: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      email = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    obscureText: onpressed,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.lightGreen),
                      ),
                      prefixIcon: IconButton(
                        icon: onpressed
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.green,
                              ),
                        onPressed: () {
                          setState(() {
                            onpressed = !onpressed;
                          });
                        },
                      ),
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                  )),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: MaterialButton(
                        height: 60,
                        minWidth: 200,
                        child: Text(
                          "SIGN-IN",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xFF27C87A),
                        splashColor: Color(0xFF27C87A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((_) => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SplashScreen(),
                                    )));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              dis1(context, 'No user found for $email.');
                            } else if (e.code == 'wrong-password') {
                              dis1(context,
                                  'Wrong password provided for the $email.');
                            }
                          }
                        }),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  MaterialButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dis1(
    BuildContext context,
    String error,
  ) {
    var alertDialog = AlertDialog(
        title: Text(
          'ERROR!',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(error),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        ]);
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
