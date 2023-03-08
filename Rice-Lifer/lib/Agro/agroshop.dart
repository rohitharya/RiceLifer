import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AgroShop extends StatefulWidget {
  const AgroShop({Key? key}) : super(key: key);

  @override
  _AgroShopState createState() => _AgroShopState();
}

class Shopmodel {
  String name;
  String phone;
  String address;
  String image;
  String lat;
  String long;
  String distance;
  Shopmodel(
      {required this.name,
      required this.phone,
      required this.lat,
      required this.long,
      required this.address,
      required this.image,
      required this.distance});
}

class _AgroShopState extends State<AgroShop> {
  List<Shopmodel> model1 = [];
  List<Shopmodel> model = [];
  var lat;
  var long;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myvalue();
  }

  void myvalue() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    FirebaseFirestore.instance
        .collection('AgroShops')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        double distanceInMeters = Geolocator.distanceBetween(
            double.parse(element['lat']),
            double.parse(element['long']),
            position.latitude,
            position.longitude);
        if (distanceInMeters < 10000) {
          Shopmodel s = Shopmodel(
              name: element['name'],
              phone: element['phone'],
              lat: element['lat'],
              long: element['long'],
              address: element['address'],
              image: element['image'],
              distance: distanceInMeters.ceil().toString());
          setState(() {
            model1.add(s);
          });
        }
      });
    }).then((value) {
      for (int i = 0; i < model1.length; i++) {
        for (int j = i; j < model1.length; j++) {
          if (double.parse(model1[j].distance) <
              double.parse(model1[i].distance)) {
            var temp = model1[i];
            model1[i] = model1[j];
            model1[j] = temp;
          }
        }
      }
      setState(() {
        model = model1;
        this.lat = position.latitude;
        this.long = position.longitude;
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
        body: Column(
          children: [
            Image.network(
              'https://scontent.fixm4-2.fna.fbcdn.net/v/t1.6435-9/107683108_107722764343944_2932326109644198190_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_ohc=14G9-qmxAEIAX9ExTiT&_nc_ht=scontent.fixm4-2.fna&oh=00_AT-nIygJFYubpj6NHYAmnJRylk9mm3K0760JPEEgVtzNzA&oe=62FAB991',
              fit: BoxFit.cover,
              height: 160,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              child: model.length != 0
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: model.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: InkWell(
                                  splashColor: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  model[index]
                                                      .name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                child: Row(
                                              children: <Widget>[
                                                Icon(Icons.location_city),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    model[index].address,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 150,
                                                  width: 200,
                                                  child: Image.network(
                                                    model[index].image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(Icons
                                                            .social_distance),
                                                        Text(
                                                          ':',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          model[index]
                                                                  .distance +
                                                              'ms',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(Icons
                                                            .phone_android),
                                                        Text(
                                                          ':',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          model[index].phone,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          gradient: (index % 2 == 0)
                                              ? LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                      Colors.white,
                                                      Colors.lightGreen
                                                    ])
                                              : LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                      Colors.orangeAccent,
                                                      Colors.white
                                                    ]))),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ));
  }
}
