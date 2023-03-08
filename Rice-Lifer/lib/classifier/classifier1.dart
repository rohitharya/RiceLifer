import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ricelife/classifier/classifier2.dart';

class Classify extends StatefulWidget {
  @override
  State<Classify> createState() => _ClassifyState();
}

class _ClassifyState extends State<Classify> {
  List<String> array = [
    'https://www.wikihow.com/images/thumb/9/90/Grow-Rice-Step-1.jpg/aid1151588-v4-728px-Grow-Rice-Step-1.jpg',
    'https://www.wikihow.com/images/thumb/9/9a/Grow-Rice-Step-2.jpg/aid1151588-v4-728px-Grow-Rice-Step-2.jpg.webp',
    'https://www.wikihow.com/images/thumb/c/c5/Grow-Rice-Step-3.jpg/aid1151588-v4-728px-Grow-Rice-Step-3.jpg.webp',
    'https://www.wikihow.com/images/thumb/0/0c/Grow-Rice-Step-4.jpg/aid1151588-v4-728px-Grow-Rice-Step-4.jpg.webp',
    'https://www.wikihow.com/images/thumb/8/8e/Grow-Rice-Step-5.jpg/aid1151588-v4-728px-Grow-Rice-Step-5.jpg.webp',
    'https://www.wikihow.com/images/thumb/b/b3/Grow-Rice-Step-6.jpg/aid1151588-v4-728px-Grow-Rice-Step-6.jpg.webp',
    'https://www.wikihow.com/images/thumb/7/7f/Grow-Rice-Step-7.jpg/aid1151588-v4-728px-Grow-Rice-Step-7.jpg.webp',
    'https://www.wikihow.com/images/thumb/7/7c/Grow-Rice-Step-8.jpg/aid1151588-v4-728px-Grow-Rice-Step-8.jpg.webp',
    'https://www.wikihow.com/images/thumb/6/6b/1151588-9.jpg/aid1151588-v4-728px-1151588-9.jpg.webp',
    'https://www.wikihow.com/images/thumb/3/34/1151588-10.jpg/aid1151588-v4-728px-1151588-10.jpg.webp',
    'https://www.wikihow.com/images/thumb/9/9a/1151588-11.jpg/aid1151588-v4-728px-1151588-11.jpg.webp',
  ];

  var _image;

  Future getimage(bool isCamera) async {
    XFile image;
    final imgpic = ImagePicker();
    if (isCamera) {
      image = (await imgpic.pickImage(source: ImageSource.camera))!;
    } else {
      image = (await imgpic.pickImage(source: ImageSource.gallery))!;
    }
    setState(() {
      _image = image;
    });
    if (_image != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Classify1(
                    image: _image,
                  )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.greenAccent,
          Colors.white,
          Colors.white,
          Colors.greenAccent
        ], begin: Alignment.bottomCenter, end: Alignment.topLeft)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'RICE-LIFER',
                  style: GoogleFonts.oleoScript(
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                  child: CarouselSlider(
                items: [
                  Image.network(
                    array[0],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[1],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[2],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[3],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[4],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[5],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[6],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[7],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[8],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[9],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.network(
                    array[10],
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
                options: CarouselOptions(
                  autoPlayInterval: Duration(milliseconds: 800),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlay: true,
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'CHOOSE TO CARE RICE..',
                  style: GoogleFonts.oleoScript(
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: MaterialButton(
                        height: 150,
                        minWidth: 150,
                        onPressed: () {
                          getimage(false);
                        },
                        color: Color(0xFF27C87A),
                        splashColor: Color(0xFF27C57A),
                        child: Column(
                          children: [
                            Icon(Icons.insert_drive_file_outlined),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'BY GALLERY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: MaterialButton(
                        height: 150,
                        minWidth: 150,
                        clipBehavior: Clip.hardEdge,
                        onPressed: () {
                          getimage(true);
                        },
                        color: Color(0xFF27C87A),
                        splashColor: Color(0xFF27C57A),
                        child: Column(
                          children: [
                            Icon(Icons.camera),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'BY CAMERA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
