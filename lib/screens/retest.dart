import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restest extends StatefulWidget {
  Restest(
      {Key? key,
      this.age,
      this.name,
      this.phnum,
      this.img,
      this.index,
      this.date,
      this.time,
      this.rmsBS,
      this.rmsDS,
      this.rmsPsg,
      this.fis,
      this.vpt,
      this.rmsPS,
      this.id,
      this.appNo,
      this.address,
      this.gender})
      : super(key: key);
  final String? name;
  final String? age;
  final String? phnum;
  final String? date;
  final String? time;
  final String? img;
  final String? id;
  final String? appNo;
  final String? address;
  final String? gender;
  final String? rmsDS;
  final String? vpt;
  final String? fis;
  final String? rmsBS;
  final String? rmsPS;
  final String? rmsPsg;
  final index;

  @override
  _RestestState createState() => _RestestState();
}

class _RestestState extends State<Restest> {
  TextEditingController? controllerRMSDS;
  TextEditingController? controllerRMSPS;
  TextEditingController? controllerRMSPSG;
  TextEditingController? controllerFIS;

  String? rmsds;
  String? rmsPS;
  String? rmsPSg;
  String? fis;
  String? uid;

  void dialogBox(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '       Yay, retest data update!',
                          hintStyle: TextStyle(fontFamily: 'Poppins')),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void updatePatientData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "fis scale score": fis,
        "rms ps scale score": rmsPS,
        "rms ps girls": rmsPSg,
        "RMS Digital Anxiety Scale": rmsds
      });
      Navigator.pop(context);
      Navigator.pop(context);
      dialogBox(context);
    });
  }

  @override
  void initState() {
    super.initState();
    User?user= FirebaseAuth.instance!.currentUser;
    if(user!=null){
      this.uid = user.uid;
    }

    rmsds = widget.rmsDS;
    rmsPS = widget.rmsPS;
    rmsPSg = widget.rmsPsg;
    fis = widget.fis;

    controllerRMSDS = new TextEditingController(text: widget.rmsDS);
    controllerRMSPS = new TextEditingController(text: widget.rmsPS);
    controllerRMSPSG = new TextEditingController(text: widget.rmsPsg);
    controllerFIS = new TextEditingController(text: widget.fis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.info_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Take your retest here,',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              'Edit the value from 1-5 based on the new score',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 13, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "RMS DIGITAL ANXIETY SCALE",
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black))),
                controller: controllerRMSDS,
                //controller: _phoneController,
                onChanged: (String str) {
                  rmsds = str;
                },
              ),
            ),
            widget.gender == 'MALE'
                ? Row(
                    children: <Widget>[
                      rmsPS == ''
                          ? Text(
                              '(0)',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.blue),
                            )
                          : Text(
                              '($rmsPS)',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.blue),
                            ),
                      Container(
                        width: 230,
                        child: Text(
                          '    RMS Pictorial Scale - Boys',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.black,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 500,
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                            child: Text(
                                          'RMS Pictorial Scale - Boys',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        )),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                            width: double.infinity,
                                            height: 110,
                                            child: Image.asset(
                                                'assets/rmspsb.jpg')),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPS = '1';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPS!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/boys1.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPS = '2';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPS!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/boys2.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPS = '3';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPS!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/boys3.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPS = '4';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPS!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/boys4.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                rmsPS = '5';
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Container(
                                                            height: 100,
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Center(
                                                                  child: Text(
                                                                    'Score',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 25,
                                                                ),
                                                                Text(
                                                                    'RMS Pictorial Scale: ' +
                                                                        rmsPS!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                    ))
                                                              ],
                                                            )));
                                                  });
                                            },
                                            child: Container(
                                              width: 90.0,
                                              height: 90.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/boys5.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                      SizedBox(width: 18),
                    ],
                  )
                : //RMS PICTORIAL SCALE - GIRLS
                Row(
                    children: <Widget>[
                      rmsPSg == ''
                          ? Text(
                              '(0)',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.blue),
                            )
                          : Text(
                              '($rmsPSg)',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.blue),
                            ),
                      Container(
                        width: 250,
                        child: Text(
                          '   RMS Pictorial Scale - Girls',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.black,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 500,
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                            child: Text(
                                          'RMS Pictorial Scale - Girls',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        )),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                            width: double.infinity,
                                            height: 110,
                                            child: Image.asset(
                                                'assets/rmspsg.jpg')),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPSg = '1';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPSg!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/girl1.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPSg = '2';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPSg!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/girl2.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPSg = '3';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPSg!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/girl3.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rmsPSg = '4';
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 100,
                                                              width: 80,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      'Score',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Text(
                                                                      'RMS Pictorial Scale: ' +
                                                                          rmsPSg!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ))
                                                                ],
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                width: 90.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/girl4.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                rmsPSg = '5';
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: Container(
                                                            height: 100,
                                                            width: 80,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Center(
                                                                  child: Text(
                                                                    'Score',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 25,
                                                                ),
                                                                Text(
                                                                    'RMS Pictorial Scale: ' +
                                                                        rmsPSg!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                    ))
                                                              ],
                                                            )));
                                                  });
                                            },
                                            child: Container(
                                              width: 90.0,
                                              height: 90.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/girl5.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                      SizedBox(width: 15),
                    ],
                  ),
            //RMS fis
            Row(
              children: <Widget>[
                fis == ''
                    ? Text(
                        '(0)',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.blue),
                      )
                    : Text(
                        '($fis)',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.blue),
                      ),
                Container(
                  width: 250,
                  child: Text(
                    '    Facial Image Scale ',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 500,
                              child: Column(
                                children: <Widget>[
                                  Center(
                                      child: Text(
                                    'RMS Facial Image Scale',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  )),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 110,
                                      child: Image.asset('assets/fis.jpg')),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fis = '1';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: Container(
                                                        height: 100,
                                                        width: 80,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                'Score',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Text(
                                                                'RMS Facial Image Scale: ' +
                                                                    fis!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ))
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/fis1.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fis = '2';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: Container(
                                                        height: 100,
                                                        width: 80,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                'Score',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Text(
                                                                'RMS Facial Image Scale: ' +
                                                                    fis!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ))
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/fis2.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fis = '3';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: Container(
                                                        height: 100,
                                                        width: 80,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                'Score',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Text(
                                                                'RMS Facial Image Scale: ' +
                                                                    fis!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ))
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/fis3.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fis = '4';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: Container(
                                                        height: 100,
                                                        width: 80,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Text(
                                                                'Score',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Text(
                                                                'RMS Facial Image Scale: ' +
                                                                    fis!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ))
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/fis4.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          fis = '5';
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Container(
                                                      height: 100,
                                                      width: 80,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Center(
                                                            child: Text(
                                                              'Score',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Text(
                                                              'RMS Facial Image Scale: ' +
                                                                  fis!,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                              ))
                                                        ],
                                                      )));
                                            });
                                      },
                                      child: Container(
                                        width: 90.0,
                                        height: 90.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image:
                                                  AssetImage('assets/fis5.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                SizedBox(width: 18),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  updatePatientData();
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  //color: Colors.black,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text("                           "),
                      Text(
                        "Submit Retest   ",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
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
