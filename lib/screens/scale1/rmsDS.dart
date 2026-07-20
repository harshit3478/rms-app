import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmsnewmodule/screens/camera.dart';
import 'package:rmsnewmodule/screens/scale1/scale1_compare_with.dart';
import 'package:rmsnewmodule/screens/scale2/rmsPcdas.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/apipath.dart';

class AddPatient extends StatefulWidget {
  final File? getImage;
  final int? scaleNumber;
  final String? name;
  final String ?age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;
  
  const AddPatient({Key? key,
  @required this.getImage,
  this.scaleNumber,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
  
  }) : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  String? name = '';
  String ?age = '';
  String ?phnum = '';
  String ?address = '';
  String ?patientid = '';
  String ?appointmentNum = '';
  String ?gender = '';
  String ?rmsDSS = '';
  String ?rmsPS = '';
  String ?rmsPSg = '';
  String ?vpt = '';
  String ?fis = '';
  String ?rmsBS = '';
  String? uid;
  String? email;
  AssetImage? sadimg;
  String? cry;
  String ?smile;
  String ?smirk;
  String ?poker;
  String ?angry;
  var vpt1;
  var vpt2;
  var vpt3;
  var vpt4;
  var vpt5;
  var vpt6;
  var vpt7;
  var vpt8;
  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool image4 = false;
  bool image5 = false;
  //var finalvpt = (int.parse(vpt1));
  int counter = 0;
  @override
  void initState() {
    super.initState();
    User?user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      this.uid = user.uid;
      this.email = user.email;
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
                          hintText: '       Yay, Patient Data Saved!',
                          hintStyle: TextStyle(fontFamily: 'Poppins')),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  popupScore(context, String score) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds:2),(){
          if (context.mounted) Navigator.of(context).pop();
        });
        return AlertDialog(
          content: Container(
            height: 40,
            child: Center(
              child: Text(
                'RMS DAS Score - ' + score,
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w800),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future _addData(BuildContext context) async {
  //   print('submit button clicked');
  //   //String imgName = basename(widget.getImage.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child("$email/$name/" + 'input.jpg');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget.getImage);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   final String url = await taskSnapshot.ref.getDownloadURL();
  //   String webUrl = url.toString();
  //   print('the url is $webUrl');
  //
  //   var dbTimeKey = new DateTime.now();
  //   var formatDate = new DateFormat('MMM d,yyyy');
  //   var formatTime = new DateFormat('EEEE, hh:mm aaa');
  //
  //   String date = formatDate.format(dbTimeKey);
  //   String time = formatTime.format(dbTimeKey);
  //
  //   FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
  //     CollectionReference reference = FirebaseFirestore.instance.collection('Patient');
  //     await reference.add({
  //       "ID": patientid,
  //       "app no": appointmentNum,
  //       "name": name,
  //       "age": age,
  //       "address": address,
  //       "gender": gender,
  //       "phnum": phnum,
  //       "RMS Digital Anxiety Scale": rmsDSS, //done
  //       "rms ps scale score": rmsPS, //done
  //       "vpt scale score": vpt,
  //       "fis scale score": fis,
  //       'rms blind score': rmsBS,
  //       "uid": uid,
  //       "url": webUrl,
  //       "rms ps girls": rmsPSg, //done
  //       //"sadimg": sadimg,
  //       "date": date,
  //       "time": time
  //     });
  //   });
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Navigation(),
  //       ));
  //
  //   dialogBox(context);
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) async {
      if (didPop) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                    height: MediaQuery.of(context).size.height/6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Are you sure you want to go back? Data will not be saved",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(

                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.of(context).pop();
                                },
                                child: Text('NO ',
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                        fontSize: 20
                                    )
                                ),
                              ),
                              SizedBox(width: 20,),
                              InkWell(
                                onTap:(){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Navigation(),
                                      ));
                                },
                                child: Text('YES',
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        fontSize: 20
                                    )),
                              ),

                            ],
                          ),
                        ),

                      ],
                    )),

              );
            }
        );
      }

    },
      child: Scaffold(
          //resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () async{
                return showDialog(
          context: context,
           builder: (context) {
            return AlertDialog(
              content: Container(
              height: MediaQuery.of(context).size.height/6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Are you sure you want to go back? Data will not be saved",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.of(context).pop();
                          },
                          child: Text('NO ',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 20
                            )
                          ),
                        ),
                        SizedBox(width: 20,),
                        InkWell(
                          onTap:(){
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Navigation(),
                            ));
                          },
                          child: Text('YES',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 20
                            )),
                        ),
                        
                      ],
                    ),
                  ),
                
                ],
              )),
            
            );
          }
        );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              // IconButton(
              //     icon: Icon(
              //       Icons.refresh,
              //       color: Colors.black,
              //       size: 30,
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           new MaterialPageRoute(
              //               builder: (context) => this.build(context)));
              //     }),
              // IconButton(
              //     icon: Icon(
              //       Icons.info_outline,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             content: Container(
              //               height: 400,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Center(
              //                     child: Text(
              //                       'References',
              //                       style: TextStyle(
              //                           fontFamily: 'Poppins',
              //                           fontWeight: FontWeight.w800),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 20,
              //                   ),
              //                   Text(
              //                       "• Shetty RM, Khandelwal M, Rath S. RMS Pictorial Scale (RMS-PS): An innovative scale for the assessment of child’s dental anxiety. J Indian Soc Pedod Prev Dent 2015;33:48-52.",
              //                       style: TextStyle(
              //                           fontFamily: 'Poppins', fontSize: 12)),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text(
              //                       "• Buchanan H, Niven N. Validation of a facial image scale to assess child dental anxiety. Int J Paediatr Dent 2002;12:47-52.",
              //                       style: TextStyle(
              //                           fontFamily: 'Poppins', fontSize: 12)),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text(
              //                       "• Venham LL, Gaulin-Kremer E. A self-report measure of situational anxiety for young children. Pediatr Dent 1979;1:91-6.",
              //                       style: TextStyle(
              //                           fontFamily: 'Poppins', fontSize: 12)),
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     })
            ],
          ),
          //backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: FractionalOffset.center,
                      child: Text(
                        'RMS Digital Anxiety Scale',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            fontFamily: 'Poppins'),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    image1 = true;
                                    image2 = false;
                                    image3 = false;
                                    image4 = false;
                                    image5 = false;
                                    rmsDSS = '1';
                                  });
                                  popupScore(context, rmsDSS!);
                                },
                                child: image1 == false
                                    ? Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                baseUrl+'/static/' +
                                                    uid! +
                                                    '_input_smile.jpg?dummy=${counter++}',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xA60D79DD),
                                                Color(0xA60DDD98),
                                                Color(0xFF35B8BD),
                                              ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    baseUrl+'/static/' +
                                                        uid! +
                                                        '_input_smile.jpg?dummy=${counter++}',
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Very happy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3A7DB8),
                                    fontFamily: 'Poppins'))
                          ],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    image1 = false;
                                    image2 = true;
                                    image3 = false;
                                    image4 = false;
                                    image5 = false;
                                    rmsDSS = '2';
                                  });
                                  popupScore(context, rmsDSS!);
                                },
                                child: image2 == false
                                    ? Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                baseUrl+'/static/' +
                                                    uid! +
                                                    '_input_smirk.jpg?dummy=${counter++}',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xA60D79DD),
                                                Color(0xA60DDD98),
                                                Color(0xFF35B8BD),
                                              ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    baseUrl+'/static/' +
                                                        uid! +
                                                        '_input_smirk.jpg?dummy=${counter++}',
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      )),
                            Text('Happy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3A7DB8),
                                    fontFamily: 'Poppins'))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    image1 = false;
                                    image2 = false;
                                    image3 = true;
                                    image4 = false;
                                    image5 = false;
                                    rmsDSS = '3';
                                  });
                                  popupScore(context, rmsDSS!);
                                },
                                child: image3 == false
                                    ? Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                baseUrl+'/static/' +
                                                    uid! +
                                                    '_input_poker.jpg?dummy=${counter++}',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xA60D79DD),
                                                Color(0xA60DDD98),
                                                Color(0xFF35B8BD),
                                              ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    baseUrl+'/static/' +
                                                        uid! +
                                                        '_input_poker.jpg?dummy=${counter++}',
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Normal',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3A7DB8),
                                    fontFamily: 'Poppins'))
                          ],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    image1 = false;
                                    image2 = false;
                                    image3 = false;
                                    image4 = true;
                                    image5 = false;
                                    rmsDSS = '4';
                                  });
                                  popupScore(context, rmsDSS!);
                                },
                                child: image4 == false
                                    ? Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                baseUrl+'/static/' +
                                                    uid! +
                                                    '_input_sligthlysad.jpg?dummy=${counter++}',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xA60D79DD),
                                                Color(0xA60DDD98),
                                                Color(0xFF35B8BD),
                                              ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    baseUrl+'/static/' +
                                                        uid! +
                                                        '_input_sligthlysad.jpg?dummy=${counter++}',
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      )),
                            Text('Sad',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3A7DB8),
                                    fontFamily: 'Poppins'))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  image1 = false;
                                  image2 = false;
                                  image3 = false;
                                  image4 = false;
                                  image5 = true;
                                  rmsDSS = '5';
                                });
                                popupScore(context, rmsDSS!);
                              },
                              child: image5 == false
                                  ? Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                baseUrl+'/static/' +
                                                    uid! +
                                                    '_input_sad.jpg?dummy=${counter++}'),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xA60D79DD),
                                              Color(0xA60DDD98),
                                              Color(0xFF35B8BD),
                                            ]),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    baseUrl+'/static/' +
                                                        uid! +
                                                        '_input_sad.jpg?dummy=${counter++}'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    )),
                          Text('Crying',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3A7DB8),
                                  fontFamily: 'Poppins'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        if (rmsDSS == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'Please select an image.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              color: Colors.black),
                                        ),
                                      )),
                                );
                              });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RmsDSCompareWith(
                                    rmsDs: rmsDSS!,
                                    getImage: widget.getImage!,
                                    scaleNumber: widget.scaleNumber!,
                                    patientid: widget.patientid!,
                                    name: widget.name!,
                                    appointmentNum: widget.appointmentNum!,
                                    age: widget.age!,
                                    address: widget.address!,
                                    gender: widget.gender!,
                                    phnum: widget.phnum!,
                                  )));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xA60D79DD),
                                  Color(0xA60D79DD),
                                  Color(0xFF357DBD),
                                ])),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 8),
                          child: Text(
                            'Proceed',
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
                    ),

                    //sadImg,
                    // Container(
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    //   height: 130,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: <Widget>[
                    //       Container(
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage(
                    //                 baseUrl+'/static/' +
                    //                     uid +
                    //                     '_input_smile.jpg?dummy=${counter++}',
                    //               ),
                    //               fit: BoxFit.cover),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5.0,
                    //       ),
                    //       Container(
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage(
                    //                 baseUrl+'/static/' +
                    //                     uid +
                    //                     '_input_smirk.jpg?dummy=${counter++}',
                    //               ),
                    //               fit: BoxFit.cover),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5.0,
                    //       ),
                    //       Container(
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage(
                    //                   baseUrl+'/static/' +
                    //                       uid +
                    //                       '_input_poker.jpg?dummy=${counter++}'),
                    //               fit: BoxFit.cover),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5.0,
                    //       ),
                    //       Container(
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage(
                    //                   baseUrl+'/static/' +
                    //                       uid +
                    //                       '_input_sligthlysad.jpg?dummy=${counter++}'),
                    //               fit: BoxFit.cover),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5.0,
                    //       ),
                    //       Container(
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           //borderRadius: BorderRadius.circular(5),
                    //           image: DecorationImage(
                    //               image: NetworkImage(
                    //                   baseUrl+'/static/' +
                    //                       uid +
                    //                       '_input_sad.jpg?dummy=${counter++}'),
                    //               fit: BoxFit.cover),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10.0,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    /*Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 670,
                                  decoration: BoxDecoration(
                                      //border: Border.all(width: 1),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Color(0xA60D79DD),
                                            offset: Offset(0.0, 3))
                                      ])),
                            ),
                            Container(
                              alignment: FractionalOffset.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Text(
                                  'Add Patient Info',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, top: 75),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          patientid = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle,
                                              color: Color(0xA60D79DD)),
                                          hintText: "PATIENT ID",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          appointmentNum = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle,
                                              color: Color(0xA60D79DD)),
                                          hintText: "APPOINTMENT NO",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          name = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle,
                                              color: Color(0xA60D79DD)),
                                          hintText: "FULL NAME",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          age = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.details,
                                              color: Color(0xA60D79DD)),
                                          hintText: "AGE",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          address = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.location_city,
                                              color: Color(0xA60D79DD)),
                                          hintText: "ADDRESS",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle,
                                            color: Color(0xA60D79DD)),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        gender == ''
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Container(
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      gender =
                                                                          'MALE';
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'MALE',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      gender =
                                                                          'FEMALE';
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'FEMALE',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text(
                                                  'GENDER',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Container(
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      gender =
                                                                          'MALE';
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'MALE',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      gender =
                                                                          'FEMALE';
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'FEMALE',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text(
                                                  '$gender',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15),
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    TextField(
                                      onChanged: (String str) {
                                        setState(() {
                                          phnum = str;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.phone,
                                              color: Color(0xA60D79DD)),
                                          hintText: "PHONE NUMBER",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none),
                                      style: TextStyle(color: Colors.black),
                                    ),

                                    //RMS Digital Anxiety Scale
                                    Row(
                                      children: <Widget>[
                                        rmsDSS == ''
                                            ? Text(
                                                '(0)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                '($rmsDSS)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              ),
                                        Container(
                                          width: 255,
                                          child: Text(
                                            '    RMS Digital Anxiety Scale   ',
                                            style:
                                                TextStyle(fontFamily: 'Poppins'),
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
                                                      height: 350,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Center(
                                                              child: Text(
                                                            'RMS Digital Anxiety Scale',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsDSS = '1';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Digital Anxiety Scale: ' + rmsDSS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image: NetworkImage(baseUrl+'/static/' +
                                                                                uid +
                                                                                '_input_smile.jpg?dummy=${counter++}'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsDSS = '2';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Digital Anxiety Scale: ' + rmsDSS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image: NetworkImage(baseUrl+'/static/' +
                                                                                uid +
                                                                                '_input_smirk.jpg?dummy=${counter++}'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsDSS = '3';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Digital Anxiety Scale: ' + rmsDSS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                                uid +
                                                                                '_input_poker.jpg?dummy=${counter++}'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsDSS = '4';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Digital Anxiety Scale: ' + rmsDSS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                                uid +
                                                                                '_input_sligthlysad.jpg?dummy=${counter++}'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  rmsDSS = '5';
                                                                });
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                          content: Container(
                                                                              height: 100,
                                                                              width: 80,
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Center(
                                                                                    child: Text(
                                                                                      'Score',
                                                                                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 25,
                                                                                  ),
                                                                                  Text('RMS Digital Anxiety Scale: ' + rmsDSS,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                      ))
                                                                                ],
                                                                              )));
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 90.0,
                                                                height: 90.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                              uid +
                                                                              '_input_sad.jpg?dummy=${counter++}'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Colors
                                                                              .black,
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

                                    //RMS PICTORIAL SCALE
                                    Row(
                                      children: <Widget>[
                                        rmsPS == ''
                                            ? Text(
                                                '(0)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                '($rmsPS)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              ),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            '    RMS Pictorial Scale - Boys',
                                            style:
                                                TextStyle(fontFamily: 'Poppins'),
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
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Container(
                                                              width:
                                                                  double.infinity,
                                                              height: 110,
                                                              child: Image.asset(
                                                                  'assets/rmspsb.jpg')),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPS = '1';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/boys1.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPS = '2';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/boys2.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPS = '3';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/boys3.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPS = '4';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/boys4.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  rmsPS = '5';
                                                                });
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                          content: Container(
                                                                              height: 100,
                                                                              width: 80,
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Center(
                                                                                    child: Text(
                                                                                      'Score',
                                                                                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 25,
                                                                                  ),
                                                                                  Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                      ))
                                                                                ],
                                                                              )));
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 90.0,
                                                                height: 90.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image: AssetImage(
                                                                              'assets/boys5.jpg'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Colors
                                                                              .black,
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

                                    //RMS PICTORIAL SCALE - GIRLS
                                    Row(
                                      children: <Widget>[
                                        rmsPSg == ''
                                            ? Text(
                                                '(0)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                '($rmsPSg)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              ),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            '   RMS Pictorial Scale - Girls',
                                            style:
                                                TextStyle(fontFamily: 'Poppins'),
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
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Container(
                                                              width:
                                                                  double.infinity,
                                                              height: 110,
                                                              child: Image.asset(
                                                                  'assets/rmspsg.jpg')),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPSg = '1';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/girl1.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPSg = '2';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/girl2.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPSg = '3';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/girl3.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    rmsPSg = '4';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/girl4.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  rmsPSg = '5';
                                                                });
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                          content: Container(
                                                                              height: 100,
                                                                              width: 80,
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Center(
                                                                                    child: Text(
                                                                                      'Score',
                                                                                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 25,
                                                                                  ),
                                                                                  Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                      ))
                                                                                ],
                                                                              )));
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 90.0,
                                                                height: 90.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image: AssetImage(
                                                                              'assets/girl5.jpg'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Colors
                                                                              .black,
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

                                    //RMS fis
                                    Row(
                                      children: <Widget>[
                                        fis == ''
                                            ? Text(
                                                '(0)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                '($fis)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              ),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            '    Facial Image Scale ',
                                            style:
                                                TextStyle(fontFamily: 'Poppins'),
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
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Container(
                                                              width:
                                                                  double.infinity,
                                                              height: 110,
                                                              child: Image.asset(
                                                                  'assets/fis.jpg')),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    fis = '1';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Facial Image Scale: ' + fis,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/fis1.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    fis = '2';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Facial Image Scale: ' + fis,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/fis2.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    fis = '3';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Facial Image Scale: ' + fis,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/fis3.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    fis = '4';
                                                                  });
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            content: Container(
                                                                                height: 100,
                                                                                width: 80,
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Score',
                                                                                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 25,
                                                                                    ),
                                                                                    Text('RMS Facial Image Scale: ' + fis,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Poppins',
                                                                                        ))
                                                                                  ],
                                                                                )));
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 90.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/fis4.jpg'),
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  fis = '5';
                                                                });
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                          content: Container(
                                                                              height: 100,
                                                                              width: 80,
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Center(
                                                                                    child: Text(
                                                                                      'Score',
                                                                                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 25,
                                                                                  ),
                                                                                  Text('RMS Facial Image Scale: ' + fis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                      ))
                                                                                ],
                                                                              )));
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 90.0,
                                                                height: 90.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image: AssetImage(
                                                                              'assets/fis5.jpg'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Colors
                                                                              .black,
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

                                    //Venham Picture Test
                                    Row(
                                      children: <Widget>[
                                        vpt == ''
                                            ? Text(
                                                '(0)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                '($vpt)',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.blue),
                                              ),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            '    Venham Picture Test Scale ',
                                            style:
                                                TextStyle(fontFamily: 'Poppins'),
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
                                                      height: 450,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Center(
                                                              child: Text(
                                                            'Venham Picture Test(Pick all)',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt1 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt1 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );

                                                                  // setState(() {
                                                                  //   vpt = '1';
                                                                  // });
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt1.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt2 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt2 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt2.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt3 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt3 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt3.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt4 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt4 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt4.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt5 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt5 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt5.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt6 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt6 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt6.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt7 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt7 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt7.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt8 = '0';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'zero (0)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    vpt8 = '1';
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text(
                                                                                  'one (1)',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: 105.0,
                                                                  height: 90.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/vpt8.jpg'),
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                      height: 45,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      width: 220,
                                      child: FlatButton(
                                        onPressed: () {
                                          gender == ''
                                              ? showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0)), //this right here
                                                      child: Container(
                                                        height: 120,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  'Please select a gender!',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Poppins'),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SecondScale(
                                                            gender: gender,
                                                          )));
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xA62E4357),
                                                    Color(0xA6546A7E),
                                                    Color(0xFF4D6981),
                                                  ])),
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(
                                                maxWidth: double.infinity,
                                                minHeight: 50),
                                            child: Text(
                                              "RMS PCDAS",
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      width: 300,
                                      child: FlatButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(7),
                                                  ),
                                                  child: Container(
                                                    height: 165,
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(height: 15),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            child: Text(
                                                              'Save Patient Data',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    right: 15),
                                                            child: Container(
                                                              width:
                                                                  double.infinity,
                                                              child: Text(
                                                                'Are you sure you store this patient details?',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 15.0),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'CANCEL',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      rmsDSS == ''
                                                                          ? showDialog(
                                                                              context:
                                                                                  context,
                                                                              builder: (BuildContext
                                                                                  context) {
                                                                                return Dialog(
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
                                                                                  child: Container(
                                                                                    height: 120,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(12.0),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Please select a Score for RMSDAS!',
                                                                                            style: TextStyle(fontFamily: 'Poppins'),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              })
                                                                          : _addData(
                                                                              context);
                                                                    },
                                                                    child: Text(
                                                                      'CONFIRM',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 15)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xA60D79DD),
                                                    Color(0xA60D79DD),
                                                    Color(0xFF1C63A1),
                                                  ])),
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(
                                                maxWidth: double.infinity,
                                                minHeight: 50),
                                            child: Text(
                                              "Submit",
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )*/
                  ]),
            ),
          )),
    );
  }
}
