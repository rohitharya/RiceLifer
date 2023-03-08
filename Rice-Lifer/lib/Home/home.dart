import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricelife/Agro/agroshop.dart';
import 'package:ricelife/History/history1.dart';
import 'package:ricelife/Profile/profile1.dart';
import 'package:ricelife/authentication/signin.dart';

import '../classifier/classifier1.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardStyle = GoogleFonts.rakkas(textStyle: TextStyle(fontSize: 15));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              });
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'SIGNOUT',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.greenAccent,
          Colors.white,
          Colors.white,
          Colors.white
        ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: Stack(
          children: <Widget>[
            SafeArea(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
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
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://img.freepik.com/premium-vector/rice-bowl-with-chopstick-cartoon-vector-illustration-rice-food-flat-icon-outline_385450-1061.jpg?w=740'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        primary: true,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage1()));
                            },
                            splashColor: Colors.greenAccent,
                            focusColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 150,
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "PROFILE",
                                      style: cardStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Classify()));
                            },
                            splashColor: Colors.greenAccent,
                            focusColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 150,
                                      child: Image.network(
                                        'https://grammartop.com/wp-content/uploads/2020/11/diseased-2d8f6d3ff0d14e48d3b618409ed5e58f30f64d72.png',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "FIND DISEASE",
                                      style: cardStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AgroShop()));
                            },
                            splashColor: Colors.greenAccent,
                            focusColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 150,
                                      child: Image.network(
                                        'https://play-lh.googleusercontent.com/05jlriR37vJHeKv1dRi8wMXigdIivp_t9BRsze-CDhNAV3HPv4CafUrjC4s30uDQNtBV',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "AGRO NEAR BY",
                                      style: cardStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => History1()));
                            },
                            splashColor: Colors.greenAccent,
                            focusColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 150,
                                      child: Image.network(
                                        'https://media.istockphoto.com/vectors/open-book-with-history-doodles-and-lettering-vector-id1092170968?k=6&m=1092170968&s=612x612&w=0&h=j_qReeZ6d-7T8fXChMTqHS3EAKc_WICk2XLLfwbonfQ=',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "HISTORY",
                                      style: cardStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        crossAxisCount: 2),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
