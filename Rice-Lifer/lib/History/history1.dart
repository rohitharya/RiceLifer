import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'history2.dart';

class History1 extends StatefulWidget {
  const History1({Key? key}) : super(key: key);

  @override
  State<History1> createState() => _History1State();
}

class _History1State extends State<History1> {
  List myarray = [];
  var email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection('history')
        .doc(email)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          myarray = value.data()?['list'];
        });
      }
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.white],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(
            'https://thumbs.dreamstime.com/z/erasing-history-15821381.jpg',
            fit: BoxFit.cover,
            height: 150,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'DATEWISE:',
                style: GoogleFonts.rakkas(
                    textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            child: (myarray.isEmpty)
                ? Container(child: Center(child: CircularProgressIndicator()))
                : Container(
                    child: ListView.builder(
                      itemCount: myarray.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => History2(
                                        filename: myarray[index],
                                      )));
                        },
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.folder,
                                      color: Color(0xfffccc77),
                                    ),
                                    title: Text(myarray[index]),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ]),
      ),
    );
  }
}
