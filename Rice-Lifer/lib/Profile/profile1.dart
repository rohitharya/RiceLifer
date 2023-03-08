import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  var email;
  var useremail;
  var username;
  var image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((value) {
      setState(() {
        useremail = value.data()?['email'];
        username = value.data()?['name'];
        image = value.data()?['profile'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: (useremail != null)
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.greenAccent,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PROFILE',
                    style: GoogleFonts.oleoScript(
                      textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'USER-NAME',
                          style: GoogleFonts.rakkas(
                            textStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'USER-EMAIL',
                          style: GoogleFonts.rakkas(
                            textStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.email_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          useremail,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
