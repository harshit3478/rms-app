import 'dart:io';

import 'package:rmsnewmodule/screens/scale2/rmsPcdas.dart';
import 'package:rmsnewmodule/screens/scale2/scale2_review.dart';
import 'package:rmsnewmodule/screens/scale3/scale3_review.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mcdas extends StatefulWidget {
  Mcdas({
    Key? key,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.scaleNumber,
    this.img,
    this.rmsPcdas1,
    this.rmsPcdas2,
    this.rmsPcdas3,
    this.rmsPcdas4,
    this.rmsPcdas5,
    this.rmsPcdas6,
    this.rmsPcdas7,
    this.rmsPcdas8,
    this.isMcdasfSelected,
    this.isRmspcdasSelected,
    this.dcdas1,
    this.dcdas2,
    this.dcdas3,
    this.dcdas4,
    this.dcdas5,
    this.dcdas6,
    this.dcdas7,
    this.dcdas8,
    
  }) : super(key: key);


  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String?appointmentNum;
  final String? gender;
  final File? img;
  final String? rmsPcdas1;
  final String? rmsPcdas2;
  final String? rmsPcdas3;
  final String? rmsPcdas4;
  final String? rmsPcdas5;
  final String? rmsPcdas6;
  final String? rmsPcdas7;
  final String? rmsPcdas8;

  final bool? isMcdasfSelected;
  final bool? isRmspcdasSelected;

  final String? dcdas1;
  final String? dcdas2;
  final String? dcdas3;
  final String? dcdas4;
  final String?dcdas5;
  final String? dcdas6;
  final String? dcdas7;
  final String? dcdas8;

  @override
  _McdasState createState() => _McdasState();
}

class _McdasState extends State<Mcdas> {
  

  String mcdasq1 = '';
  String mcdasq2 = '';
  String mcdasq3 = '';
  String mcdasq4 = '';
  String mcdasq5 = '';
  String mcdasq6 = '';
  String mcdasq7 = '';
  String mcdasq8 = '';
  int counter = 0;
  String? uid;
  String? email;
  @override
  void initState() {
    super.initState();
    User?user= FirebaseAuth.instance!.currentUser;
    if(user!=null){
      setState(() {
        this.email = user.email;
        this.uid = user.uid;
      });
    }
    // FirebaseAuth.instance.currentUser().then((value) {
    //   setState(() {
    //     this.uid = value.uid;
    //     this.email = value.email;
    //     print(uid);
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: <Widget>[

        //   IconButton(
        //       icon: Icon(
        //         Icons.info_outline,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
                
        //       })
        // ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Faces Version of the Modified Child Dental Anxiety Scale',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Questions for MCDASf,',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              //mcdasq1

              Row(
                children: [
                  mcdasq1 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq1)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q1. How do you feel about going to the dentist generally?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about going to the dentist generally?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq1 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q1 MCDASf Score -  ' +
                                                                      mcdasq1,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq1 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q1 MCDASf Score -  ' +
                                                                      mcdasq1,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq1 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q1 MCDASf Score -  ' +
                                                                      mcdasq1,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq1 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q1 MCDASf Score -  ' +
                                                                      mcdasq1,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq1 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q1 MCDASf Score -  ' +
                                                                    mcdasq1,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq2
              Row(
                children: [
                  mcdasq2 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq2)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q2. How do you feel about having your teeth looked at?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about having your teeth looked at?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq2 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q2 MCDASf Score -  ' +
                                                                      mcdasq2,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq2 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q2 MCDASf Score -  ' +
                                                                      mcdasq2,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq2 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q2 MCDASf Score -  ' +
                                                                      mcdasq2,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq2 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q2 MCDASf Score -  ' +
                                                                      mcdasq2,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq2 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q2 MCDASf Score -  ' +
                                                                    mcdasq2,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq3
              Row(
                children: [
                  mcdasq3 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq3)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q3. How do you feel about having your teeth scraped and polished?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about having your teeth scraped and polished?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq3 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q3 MCDASf Score -  ' +
                                                                      mcdasq3,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq3 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q3 MCDASf Score -  ' +
                                                                      mcdasq3,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq3 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q3 MCDASf Score -  ' +
                                                                      mcdasq3,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq3 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q3 MCDASf Score -  ' +
                                                                      mcdasq3,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq3 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q3 MCDASf Score -  ' +
                                                                    mcdasq3,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq4
              Row(
                children: [
                  mcdasq4 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq4)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q4. How do you feel about having an injection in the gum?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about having an injection in the gum?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq4 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q4 MCDASf Score -  ' +
                                                                      mcdasq4,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq4 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q4 MCDASf Score -  ' +
                                                                      mcdasq4,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq4 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q4 MCDASf Score -  ' +
                                                                      mcdasq4,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq4 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q4 MCDASf Score -  ' +
                                                                      mcdasq4,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq4 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q4 MCDASf Score -  ' +
                                                                    mcdasq4,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq5
              Row(
                children: [
                  mcdasq5 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq5)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q5. How do you feel about having a filling?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about having a filling?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq5 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q5 MCDASf Score -  ' +
                                                                      mcdasq5,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq5 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q5 MCDASf Score -  ' +
                                                                      mcdasq5,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq5 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q5 MCDASf Score -  ' +
                                                                      mcdasq5,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq5 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q5 MCDASf Score -  ' +
                                                                      mcdasq5,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq5 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q5 MCDASf Score -  ' +
                                                                    mcdasq5,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq6
              Row(
                children: [
                  mcdasq6 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq6)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q6. How do you feel about having a tooth taken out?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about having a tooth taken out?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq6 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q6 MCDASf Score -: ' +
                                                                      mcdasq6,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq6 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q6 MCDASf Score -: ' +
                                                                      mcdasq6,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq6 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q6 MCDASf Score -: ' +
                                                                      mcdasq6,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq6 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q6 MCDASf Score -: ' +
                                                                      mcdasq6,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq6 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q6 MCDASf Score -: ' +
                                                                    mcdasq6,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq7
              Row(
                children: [
                  mcdasq7 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq7)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q7. How do you feel about being put to sleep to have treatment?',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'How do you feel about being put to sleep to have treatment?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq7 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q7 MCDASf Score -: ' +
                                                                      mcdasq7,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq7 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q7 MCDASf Score -: ' +
                                                                      mcdasq7,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq7 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q7 MCDASf Score -: ' +
                                                                      mcdasq7,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq7 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q7 MCDASf Score -: ' +
                                                                      mcdasq7,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq7 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q7 MCDASf Score -: ' +
                                                                    mcdasq7,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //mcdasq8
              Row(
                children: [
                  mcdasq8 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($mcdasq8)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        "Q8. How do you feel about having a mixture of 'gas & air' which will help you comfortable for treatment but cannot put you to sleep?",
                        style: TextStyle(fontFamily: 'Poppins'),
                      )),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      "How do you feel about having a mixture of 'gas & air' which will help you comfortable for treatment but cannot put you to sleep?",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    )),
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
                                              mcdasq8 = '1';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q8 MCDASf Score -: ' +
                                                                      mcdasq8,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq8 = '2';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q8 MCDASf Score -: ' +
                                                                      mcdasq8,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 2.png'),
                                                  fit: BoxFit.fill,
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
                                              mcdasq8 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q8 MCDASf Score -: ' +
                                                                      mcdasq8,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 3.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mcdasq8 = '4';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                  'Q8 MCDASf Score -: ' +
                                                                      mcdasq8,
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
                                            width: 110.0,
                                            height: 110.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/newAssets/MCDASf 4.png'),
                                                  fit: BoxFit.fill,
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
                                            mcdasq8 = '5';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(Duration(seconds:2),(){
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    });
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
                                                                'Q8 MCDASf Score -: ' +
                                                                    mcdasq8,
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
                                          width: 110.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/newAssets/MCDASf 5.png'),
                                                fit: BoxFit.fill,
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if((mcdasq1 != '') && (mcdasq2 != '') 
                         && (mcdasq3 != '') && (mcdasq4 != '')
                         && (mcdasq5 != '') && (mcdasq6 != '')
                         && (mcdasq7 != '') && (mcdasq8 != '')
                         ){
                           widget.scaleNumber == 3
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scale3Review(
                                        isSelected: true,
                                        scaleNumber: widget.scaleNumber!,
                                        patientid: widget.patientid!,
                                        name: widget.name!,
                                        appointmentNum: widget.appointmentNum!,
                                        age: widget.age!,
                                        address: widget.address!,
                                        gender: widget.gender!,
                                        phnum: widget.phnum!,
                                        img: widget.img!,
                                        rmsPcdas1: widget.rmsPcdas1!,rmsPcdas2: widget.rmsPcdas2!,
                                        rmsPcdas3: widget.rmsPcdas3!,rmsPcdas4: widget.rmsPcdas4!,
                                        rmsPcdas5: widget.rmsPcdas5!,rmsPcdas6: widget.rmsPcdas6!,
                                        rmsPcdas7: widget.rmsPcdas7!,rmsPcdas8: widget.rmsPcdas8!,

                                        mcdas1: mcdasq1,mcdas2: mcdasq2,mcdas3: mcdasq3,
                                        mcdas4: mcdasq4,mcdas5: mcdasq5,mcdas6: mcdasq6,
                                        mcdas7: mcdasq7,mcdas8: mcdasq8,
                                  )))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                      Scale2Review(
                                        scaleNumber: widget.scaleNumber!,
                                      patientid: widget.patientid!,
                                      name: widget.name!,
                                      appointmentNum: widget.appointmentNum!,
                                      age: widget.age!,
                                      address: widget.address!,
                                      gender: widget.gender!,
                                      phnum: widget.phnum!,
                                      img: widget.img!,
                                      isMcdasfSelected: widget.isMcdasfSelected!,
                                      isRmspcdasSelected: widget.isRmspcdasSelected!,
                                      dcdas1: widget.dcdas1!,dcdas2: widget.dcdas2!,
                                      dcdas3: widget.dcdas3!,dcdas4: widget.dcdas4!,
                                      dcdas5: widget.dcdas5!,dcdas6: widget.dcdas6!,
                                      dcdas7: widget.dcdas7!,dcdas8: widget.dcdas8!,
                                      rmsPcdas1: widget.rmsPcdas1!,rmsPcdas2: widget.rmsPcdas2!,
                                      rmsPcdas3: widget.rmsPcdas3!,rmsPcdas4: widget.rmsPcdas4!,
                                      rmsPcdas5: widget.rmsPcdas5!,rmsPcdas6: widget.rmsPcdas6!,
                                      rmsPcdas7: widget.rmsPcdas7!,rmsPcdas8: widget.rmsPcdas8!,
                                      mcdas1: mcdasq1,mcdas2: mcdasq2,mcdas3: mcdasq3,
                                      mcdas4: mcdasq4,mcdas5: mcdasq5,mcdas6: mcdasq6,
                                      mcdas7: mcdasq7,mcdas8: mcdasq8,
                                        
                                  )));
                         }else{
                           showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    height: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Please answer all the questions!',
                                              
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                         }
                      
                          
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xA6067FF0),
                                Color(0xA60180F7),
                                Color(0xFF0A83EE),
                              ])),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 50),
                        child: Text(
                          "Proceed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(6.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                  children: [
                    Text(
                      'Reference: ',
                  style: TextStyle(fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,fontSize: 12),
                    ),
                    InkWell(
                      onTap: (){
                        showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Reference',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "• Howard KE, Freeman R. Reliability and validity of a faces version of the Modified Child Dental Anxiety Scale. Int J Paediatr Dent 2007;17(4):281-8.",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 12)),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                      },
                      child: Text('(Howard and Freeman, 2007)',
                      style:TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color(0xA6067FF0),
                        fontSize: 14
                      )
                      ),
                    ),
                  ],
                ),
                
                SizedBox(
                  height: 45,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
