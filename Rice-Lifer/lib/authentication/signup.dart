import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ricelife/Agro/agroshop.dart';
import 'package:ricelife/Home/home.dart';
import 'package:ricelife/authentication/signin.dart';
import 'package:ricelife/splasher/splash.dart';
import 'dart:io';
import '../api/Firebaseapi.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name = "";
  String email = "";
  String password = "";
  String repassword = "";
  bool onpressed = true;
  bool onpressed1 = true;

  bool x1 = true;
  bool x2 = true;
  XFile? _image;
  var url =
      "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_960_720.png";

  Future getProfile(bool cameraon) async {
    XFile image;
    final imgpicker = ImagePicker();
    if (cameraon) {
      image = (await imgpicker.pickImage(source: ImageSource.camera))!;
    } else {
      image = (await imgpicker.pickImage(source: ImageSource.gallery))!;
    }
    setState(() {
      _image = image;
    });
  }

  Future upload(var image) async {
    File s = File(image.path);
    final filename = Timestamp.now();
    final destination = '/profile/$email/$filename';
    var task = FirebaseApi.uploadFile(destination, s);
    if (task == null) {
      return;
    } else {
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        this.url = urlDownload;
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .get()
          .then((DocumentSnapshot dc) async {
        if (dc.exists) {
          dis1(context, "User Exists Already!");
        } else {
          try {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((_) {
              FirebaseFirestore.instance.collection("users").doc(email).set({
                "name": name,
                "email": email,
                "password": password,
                "repassword": repassword,
                'profile': urlDownload,
              }).then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgroShop()));
              });
            });
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              dis1(context, 'The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              dis1(context, 'The account already exists for this $email.');
            }
          }
        }
      });
    }
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign-Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Set up your account Here!!",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.lightGreen),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          hintText: 'Name',
                          focusColor: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          name = value.trim();
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.lightGreen),
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
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.lightGreen),
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
                    height: 15,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        obscureText: onpressed1,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.lightGreen),
                          ),
                          prefixIcon: IconButton(
                            icon: onpressed1
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
                                onpressed1 = !onpressed1;
                              });
                            },
                          ),
                          hintText: 'Re-Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            repassword = value.trim();
                          });
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: (_image == null)
                          ? Image(
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_960_720.png"),
                            )
                          : Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text('Choose Profile Picture:'),
                      Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                getProfile(false);
                              },
                              icon: Icon(Icons.insert_drive_file_outlined)),
                          IconButton(
                              onPressed: () {
                                getProfile(true);
                              },
                              icon: Icon(Icons.camera_alt_outlined)),
                        ],
                      )
                    ],
                  )
                ],
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
                          "SIGN-UP",
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
                          if (password == repassword) {
                            if (_image != null) {
                              upload(_image);
                            } else {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(email)
                                  .get()
                                  .then((DocumentSnapshot dc) async {
                                if (dc.exists) {
                                  dis1(context, "User Exists Already!");
                                } else {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((_) {
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(email)
                                          .set({
                                        "name": name,
                                        "email": email,
                                        "password": password,
                                        "repassword": repassword,
                                        'profile': url,
                                      }).then((value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SplashScreen()));
                                      });
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      dis1(context,
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      dis1(context,
                                          'The account already exists for this $email.');
                                    }
                                  }
                                }
                              });
                            }
                          } else {
                            dis1(context,
                                'Password And RePassword are not same!');
                          }
                        }),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  MaterialButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      'Log In',
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
