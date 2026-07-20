import 'dart:io';

import 'package:rmsnewmodule/screens/scale2/dcdas.dart';
import 'package:rmsnewmodule/screens/scale2/mcdas.dart';
import 'package:rmsnewmodule/screens/scale2/scale2_compare_with.dart';
import 'package:rmsnewmodule/screens/scale2/scale2_review.dart';
import 'package:rmsnewmodule/screens/scale3/scale3_compare_with.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SecondScale extends StatefulWidget {
  SecondScale({
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
    this.scaleNumber,
    this.img,
    this.isMcdasfSelected,
    this.isRmspcdasSelected,
    this.dcdas1,
    this.dcdas2,
    this.dcdas3,
    this.dcdas4,
    this.dcdas5,
    this.dcdas6,
    this.dcdas7,
    this.dcdas8
  });
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;
  final File? img;

  final bool? isMcdasfSelected;
  final bool? isRmspcdasSelected;
  final String? dcdas1;
  final String? dcdas2;
  final String? dcdas3;
  final String? dcdas4;
  final String? dcdas5;
  final String? dcdas6;
  final String? dcdas7;
  final String? dcdas8;

  @override
  _SecondScaleState createState() => _SecondScaleState();
}

class _SecondScaleState extends State<SecondScale> {
  String q1 = '';
  String q2 = '';
  String q3 = '';
  String q4 = '';
  String q5 = '';
  String q6 = '';
  String q7 = '';
  String q8 = '';
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
      //        return showDialog(
      //   context: context,
      //    builder: (context) {
      //     return AlertDialog(
      //       content: Container(
      //       height: MediaQuery.of(context).size.height/6,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Text(
      //             "Are you sure you want to go back? Data will not be saved",
      //             style: TextStyle(
      //                 fontWeight: FontWeight.w500,
      //                 fontSize: 15,
      //                 fontFamily: 'Poppins',
      //                 color: Colors.black),
      //           ),
      //           SizedBox(
      //             height: 25.0,
      //           ),
      //           Align(
      //             alignment: Alignment.centerRight,
      //             child: Row(
                    
      //               children: [
      //                 InkWell(
      //                   onTap:(){
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: Text('NO ',
      //                     style: TextStyle(
      //                       fontFamily: "Poppins",
      //                       fontWeight: FontWeight.w500,
      //                       color: Colors.green,
      //                       fontSize: 20
      //                     )
      //                   ),
      //                 ),
      //                 SizedBox(width: 20,),
      //                 InkWell(
      //                   onTap:(){
      //                     Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => Navigation(),
      //                     ));
      //                   },
      //                   child: Text('YES',
      //                     style: TextStyle(
      //                       fontFamily: "Poppins",
      //                       fontWeight: FontWeight.w500,
      //                       color: Colors.red,
      //                       fontSize: 20
      //                     )),
      //                 ),
                      
      //               ],
      //             ),
      //           ),
              
      //         ],
      //       )),
          
      //     );
      //   }
      // );
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
                  'RMS Pictorial Children Dental Anxiety Scale',
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
                'Questions for RMS-PCDAS,',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              //q1

              Row(
                children: [
                  q1 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q1)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q1. Select the expression that you feel If you are visiting the dentist tomorrow',
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
                                      'Select the expression that you feel If you are visiting the dentist tomorrow',
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
                                              q1 = '1';
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
                                                                  'Q1 RMS-PCDAS Score - ' +
                                                                      q1,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q1 = '2';
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
                                                                  'Q1 RMS-PCDAS Score - ' +
                                                                      q1,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q1 = '3';
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
                                                                  'Q1 RMS-PCDAS Score - ' +
                                                                      q1,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q1 = '4';
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
                                                                  'Q1 RMS-PCDAS Score - ' +
                                                                      q1,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q1 = '5';
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
                                                                'Q1 RMS-PCDAS Score - ' +
                                                                    q1,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q2
              Row(
                children: [
                  q2 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q2)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q2. Select the expression that you feel  if your teeth are examined by the dentist',
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
                                      'Select the expression that you feel  if your teeth are examined by the dentist',
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
                                              q2 = '1';
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
                                                                  'Q2 RMS-PCDAS Score - ' +
                                                                      q2,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q2 = '2';
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
                                                                  'Q2 RMS-PCDAS Score - ' +
                                                                      q2,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q2 = '3';
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
                                                                  'Q2 RMS-PCDAS Score - ' +
                                                                      q2,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q2 = '4';
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
                                                                  'Q2 RMS-PCDAS Score - ' +
                                                                      q2,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q2 = '5';
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
                                                                'Q2 RMS-PCDAS Score - ' +
                                                                    q2,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q3
              Row(
                children: [
                  q3 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q3)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q3. Select the expression that you feel  if your teeth are cleaned and polished',
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
                                      'Select the expression that you feel  if your teeth are cleaned and polished',
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
                                              q3 = '1';
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
                                                                  'Q3 RMS-PCDAS Score - ' +
                                                                      q3,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q3 = '2';
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
                                                                  'Q3 RMS-PCDAS Score - ' +
                                                                      q3,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q3 = '3';
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
                                                                  'Q3 RMS-PCDAS Score - ' +
                                                                      q3,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q3 = '4';
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
                                                                  'Q3 RMS-PCDAS Score - ' +
                                                                      q3,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q3 = '5';
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
                                                                'Q3 RMS-PCDAS Score - ' +
                                                                    q3,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q4
              Row(
                children: [
                  q4 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q4)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q4. Select the expression that you feel  if you are having a small infection in the gums',
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
                                      'Select the expression that you feel  if you are having a small infection in the gums',
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
                                              q4 = '1';
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
                                                                  'Q4 RMS-PCDAS Score - ' +
                                                                      q4,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q4 = '2';
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
                                                                  'Q4 RMS-PCDAS Score - ' +
                                                                      q4,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q4 = '3';
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
                                                                  'Q4 RMS-PCDAS Score - ' +
                                                                      q4,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q4 = '4';
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
                                                                  'Q4 RMS-PCDAS Score - ' +
                                                                      q4,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q4 = '5';
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
                                                                'Q4 RMS-PCDAS Score - ' +
                                                                    q4,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q5
              Row(
                children: [
                  q5 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q5)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q5. Select the expression that you feel  if you are getting a filling in your tooth',
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
                                      'Select the expression that you feel  if you are getting a filling in your tooth',
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
                                              q5 = '1';
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
                                                                  'Q5 RMS-PCDAS Score - ' +
                                                                      q5,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q5 = '2';
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
                                                                  'Q5 RMS-PCDAS Score - ' +
                                                                      q5,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q5 = '3';
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
                                                                  'Q5 RMS-PCDAS Score - ' +
                                                                      q5,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q5 = '4';
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
                                                                  'Q5 RMS-PCDAS Score - ' +
                                                                      q5,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q5 = '5';
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
                                                                'Q5 RMS-PCDAS Score - ' +
                                                                    q5,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q6
              Row(
                children: [
                  q6 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q6)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q6. Select the expression that you feel  if you are having a tooth taken out',
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
                                      'Select the expression that you feel  if you are having a tooth taken out',
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
                                              q6 = '1';
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
                                                                  'Q6 RMS-PCDAS Score - ' +
                                                                      q6,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q6 = '2';
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
                                                                  'Q6 RMS-PCDAS Score - ' +
                                                                      q6,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q6 = '3';
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
                                                                  'Q6 RMS-PCDAS Score - ' +
                                                                      q6,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q6 = '4';
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
                                                                  'Q6 RMS-PCDAS Score - ' +
                                                                      q6,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q6 = '5';
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
                                                                'Q6 RMS-PCDAS Score - ' +
                                                                    q6,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q7
              Row(
                children: [
                  q7 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q7)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        'Q7. Select the expression that you feel  if you are being put to sleep for the treatment of your teeth',
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
                                      'Select the expression that you feel  if you are being put to sleep for the treatment of your teeth',
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
                                              q7 = '1';
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
                                                                  'Q7 RMS-PCDAS Score - ' +
                                                                      q7,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q7 = '2';
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
                                                                  'Q7 RMS-PCDAS Score - ' +
                                                                      q7,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q7 = '3';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {Future.delayed(Duration(seconds:2),(){
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
                                                                  'Q7 RMS-PCDAS Score - ' +
                                                                      q7,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q7 = '4';
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
                                                                  'Q7 RMS-PCDAS Score - ' +
                                                                      q7,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q7 = '5';
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
                                                                'Q7 RMS-PCDAS Score - ' +
                                                                    q7,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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

              //q8
              Row(
                children: [
                  q8 == ''
                      ? Text(
                          '(0)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        )
                      : Text(
                          '($q8)',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.blue),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 240,
                      child: Text(
                        "Q8. Select the expression that you feel  if you are having a mixture of gas and air which while will help you feel comfortable for treatment but cannot put you to sleep",
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
                                      "Select the expression that you feel  if you are having a mixture of gas and air which while will help you feel comfortable for treatment but cannot put you to sleep",
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
                                              q8 = '1';
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
                                                                  'Q8 RMS-PCDAS Score - ' +
                                                                      q8,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s1.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 1.jpg'),
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
                                              q8 = '2';
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
                                                                  'Q8 RMS-PCDAS Score - ' +
                                                                      q8,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s2.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 2.jpg'),
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
                                              q8 = '3';
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
                                                                  'Q8 RMS-PCDAS Score - ' +
                                                                      q8,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s3.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 3.jpg'),
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
                                              q8 = '4';
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
                                                                  'Q8 RMS-PCDAS Score - ' +
                                                                      q8,
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
                                                  image: widget.gender ==
                                                          'FEMALE'
                                                      ? AssetImage(
                                                          'assets/newAssets/s4.jpg')
                                                      : AssetImage(
                                                          'assets/newAssets/RMS PS 4.jpg'),
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
                                            q8 = '5';
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
                                                                'Q8 RMS-PCDAS Score - ' +
                                                                    q8,
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
                                                image: widget.gender == 'FEMALE'
                                                    ? AssetImage(
                                                        'assets/newAssets/s5.jpg')
                                                    : AssetImage(
                                                        'assets/newAssets/RMS PS 5.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    refereneceWidget()
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
                      if((q1 != '') && (q2 != '') 
                       && (q3 != '') && (q4 != '')
                       && (q5 != '') && (q6 != '')
                       && (q7 != '') && (q8 != '')
                       ){
                         widget.scaleNumber == 3
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                      Scale3CompareWith(
                                        scaleNumber: widget.scaleNumber,
                                        patientid: widget.patientid,
                                        name: widget.name,
                                        appointmentNum: widget.appointmentNum,
                                        age: widget.age,
                                        address: widget.address,
                                        gender: widget.gender,
                                        phnum: widget.phnum,
                                        img: widget.img,
                                        rmsPcdas1: q1,rmsPcdas2: q2,
                                        rmsPcdas3: q3,rmsPcdas4: q4,
                                        rmsPcdas5: q5,rmsPcdas6: q6,
                                        rmsPcdas7: q7,rmsPcdas8: q8
                                      )
                                    )
                                  )
                            : widget.isMcdasfSelected == false ?
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scale2Review(
                                      scaleNumber: widget.scaleNumber!,
                                      patientid: widget.patientid!,
                                      name: widget.name!,
                                      appointmentNum: widget.appointmentNum!,
                                      age: widget.age!,
                                      address: widget.address!,
                                      gender: widget.gender!,
                                      phnum: widget.phnum!,
                                      img: widget.img!,
                                      isMcdasfSelected: false,
                                      isRmspcdasSelected: true,
                                      dcdas1: widget.dcdas1!,dcdas2: widget.dcdas2!,
                                      dcdas3: widget.dcdas3!,dcdas4: widget.dcdas4!,
                                      dcdas5: widget.dcdas5!,dcdas6: widget.dcdas6!,
                                      dcdas7: widget.dcdas7!,dcdas8: widget.dcdas8!,
                                      rmsPcdas1: q1,rmsPcdas2: q2,
                                      rmsPcdas3: q3,rmsPcdas4: q4,
                                      rmsPcdas5: q5,rmsPcdas6: q6,
                                      rmsPcdas7: q7,rmsPcdas8: q8
                                    )
                                )
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mcdas(
                                      scaleNumber: widget.scaleNumber,
                                      patientid: widget.patientid,
                                      name: widget.name,
                                      appointmentNum: widget.appointmentNum,
                                      age: widget.age,
                                      address: widget.address,
                                      gender: widget.gender,
                                      phnum: widget.phnum,
                                      img: widget.img,
                                      isMcdasfSelected: true,
                                      isRmspcdasSelected: true,
                                      dcdas1: widget.dcdas1,dcdas2: widget.dcdas2,
                                      dcdas3: widget.dcdas3,dcdas4: widget.dcdas4,
                                      dcdas5: widget.dcdas5,dcdas6: widget.dcdas6,
                                      dcdas7: widget.dcdas7,dcdas8: widget.dcdas8,
                                      rmsPcdas1: q1,rmsPcdas2: q2,
                                      rmsPcdas3: q3,rmsPcdas4: q4,
                                      rmsPcdas5: q5,rmsPcdas6: q6,
                                      rmsPcdas7: q7,rmsPcdas8: q8
                                    )
                                )
                              );  
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
              
              
              //refereneceWidget(),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget refereneceWidget(){
    return Row(
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
                          height: 200,
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
                                  "• Shetty RM, Khandelwal M, Rath S. RMS Pictorial Scale (RMS-PS): An innovative scale for the assessment of child’s dental anxiety. J Indian Soc Pedod Prev Dent 2015;33:48-52.",
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
                      child: Container(width: MediaQuery.of(context).size.width*0.4,
                        child: Text('(Shetty et al., 2015,• Shetty RM, Khandelwal M, Rath S. RMS Pictorial Scale (RMS-PS): An innovative scale for the assessment of child’s dental anxiety. J Indian Soc Pedod Prev Dent 2015;33:48-52.)',
                        style:TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Color(0xA6067FF0),
                          fontSize: 14
                        )
                        ),
                      ),
                    ),
                  ],
                );
  }
}
