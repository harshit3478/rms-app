import 'dart:io';

import 'package:rmsnewmodule/screens/scale2/mcdas.dart';
import 'package:rmsnewmodule/screens/scale2/scale2_compare_with.dart';
import 'package:rmsnewmodule/translations/locale_keys.g.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/apipath.dart';

class Dcdas extends StatefulWidget {
  Dcdas({Key? key,
    this.getImage, this.scaleNumber,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
  
  }) : super(key: key);

  final File? getImage;
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;

  @override
  _DcdasState createState() => _DcdasState();
}

class _DcdasState extends State<Dcdas> {
  String dcdasq1 = '';
  String dcdasq2 = '';
  String dcdasq3 = '';
  String dcdasq4 = '';
  String dcdasq5 = '';
  String dcdasq6 = '';
  String dcdasq7 = '';
  String dcdasq8 = '';
  int counter = 0;
  String? uid;
  String? email;
  String selectedLang = 'English';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
        return await showDialog(
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
      child: Scaffold(
        appBar: selectedLang == 'English' 
        ? AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: ()async {
               return await showDialog(
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
          ),
          actions: <Widget>[

            TextButton(
                onPressed: () async {
                  setState(() {
                    selectedLang = 'English';
                  });
                  await context.setLocale(Locale('en'));
                },
                child: selectedLang == 'English'
                    ? Text('English',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800))
                    : Text('English',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400))),
            SizedBox(width: 5),
            TextButton(
                onPressed: () async {
                  setState(() {
                    selectedLang = 'arabic';
                  });
                  await context.setLocale(Locale('ar'));
                },
                child: selectedLang == 'arabic'
                    ? Text('العربية',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800))
                    : Text('العربية',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400))),
            SizedBox(width: 5),
            IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'References',
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
                              Text(
                                  "• Howard KE, Freeman R. Reliability and validity of a faces version of the Modified Child Dental Anxiety Scale. Int J Paediatr Dent 2007;17(4):281-8.",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })
          ],
        ) : AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Row(
            children: [
              
              // IconButton(
              //   icon: Icon(
              //     Icons.info_outline,
              //     color: Colors.black,
              //   ),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           content: Container(
              //             height: 300,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Center(
              //                   child: Text(
              //                     'References',
              //                     style: TextStyle(
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w800),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 20,
              //                 ),
              //                 Text(
              //                     "• Shetty RM, Khandelwal M, Rath S. RMS Pictorial Scale (RMS-PS): An innovative scale for the assessment of child’s dental anxiety. J Indian Soc Pedod Prev Dent 2015;33:48-52.",
              //                     style: TextStyle(
              //                         fontFamily: 'Poppins', fontSize: 12)),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                     "• Howard KE, Freeman R. Reliability and validity of a faces version of the Modified Child Dental Anxiety Scale. Int J Paediatr Dent 2007;17(4):281-8.",
              //                     style: TextStyle(
              //                         fontFamily: 'Poppins', fontSize: 12)),
              //                 SizedBox(
              //                   height: 20,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   }),
                SizedBox(width: 5),
                InkWell(
                onTap: () async {
                  setState(() {
                    selectedLang = 'English';
                  });
                  await context.setLocale(Locale('en'));
                },
                child: selectedLang == 'English'
                    ? Container(
                      child: Text('English',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800)),
                    )
                    : Container(
                      child: Text('English',
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400)),
                    )),
            SizedBox(width: 5),
            TextButton(
                onPressed: () async {
                  setState(() {
                    selectedLang = 'arabic';
                  });
                  await context.setLocale(Locale('ar'));
                },
                child: selectedLang == 'arabic'
                    ? Text('العربية',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800))
                    : Text('العربية',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400))),
            //SizedBox(width: 15),
            ],
          ),
          // actions:[
          //   IconButton(
          //   icon: Icon(
          //     Icons.arrow_forward,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          // ]
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
                    'RMS Digital Children Dental Anxiety Scale ',
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
                  'Questions for RMS-DCDAS',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                //dcdasq1

                Row(
                  children: [
                    dcdasq1 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq1)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                         LocaleKeys.q1.tr(),
                         // "Select the expression that you feel if you are visiting the dentist tomorrow?",
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
                                        LocaleKeys.q1.tr(),
                                        //'Select the expression that you feel If you are visiting the dentist tomorrow',
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
                                                dcdasq1 = '1';
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
                                                                    'Q1 RMS-DCDAS Score - ' +
                                                                        dcdasq1,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq1 = '2';
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
                                                                    'Q1 RMS-DCDAS Score -  ' +
                                                                        dcdasq1,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq1 = '3';
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
                                                                    'Q1 RMS-DCDAS Score -  ' +
                                                                        dcdasq1,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid!! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq1 = '4';
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
                                                                    'Q1 RMS-DCDAS Score -  ' +
                                                                        dcdasq1,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq1 = '5';
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
                                                                  'Q1 RMS-DCDAS Score -  ' +
                                                                      dcdasq1,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq2
                Row(
                  children: [
                    dcdasq2 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq2)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          
                          LocaleKeys.q2.tr(),
                          //'Q2. Select the expression that you feel  if your teeth are examined by the dentist',
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
                                        
                                        LocaleKeys.q2.tr(),
                                        //'Select the expression that you feel  if your teeth are examined by the dentist',
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
                                                dcdasq2 = '1';
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
                                                                    'Q2 RMS-DCDAS Score -  ' +
                                                                        dcdasq2,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq2 = '2';
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
                                                                    'Q2 RMS-DCDAS Score -  ' +
                                                                        dcdasq2,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq2 = '3';
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
                                                                    'Q2 RMS-DCDAS Score -  ' +
                                                                        dcdasq2,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq2 = '4';
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
                                                                    'Q2 RMS-DCDAS Score -  ' +
                                                                        dcdasq2,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq2 = '5';
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
                                                                  'Q2 RMS-DCDAS Score -  ' +
                                                                      dcdasq2,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq3
                Row(
                  children: [
                    dcdasq3 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq3)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q3.tr(),
                          //'Q3. Select the expression that you feel  if your teeth are cleaned and polished',
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
                                            LocaleKeys.q3.tr(),
                                        //'Select the expression that you feel  if your teeth are cleaned and polished',
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
                                                dcdasq3 = '1';
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
                                                                    'Q3 RMS-DCDAS Score -  ' +
                                                                        dcdasq3,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq3 = '2';
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
                                                                    'Q3 RMS-DCDAS Score -  ' +
                                                                        dcdasq3,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq3 = '3';
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
                                                                    'Q3 RMS-DCDAS Score -  ' +
                                                                        dcdasq3,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq3 = '4';
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
                                                                    'Q3 RMS-DCDAS Score -  ' +
                                                                        dcdasq3,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq3 = '5';
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
                                                                  'Q3 RMS-DCDAS Score -  ' +
                                                                      dcdasq3,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq4
                Row(
                  children: [
                    dcdasq4 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq4)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q4.tr(),
                          //'Q4. Select the expression that you feel  if you are having a small infection in the gums',
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
                                        LocaleKeys.q4.tr(),
                                        //'Select the expression that you feel  if you are having a small infection in the gums',
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
                                                dcdasq4 = '1';
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
                                                                    'Q4 RMS-DCDAS Score -  ' +
                                                                        dcdasq4,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq4 = '2';
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
                                                                    'Q4 RMS-DCDAS Score -  ' +
                                                                        dcdasq4,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq4 = '3';
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
                                                                    'Q4 RMS-DCDAS Score -  ' +
                                                                        dcdasq4,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq4 = '4';
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
                                                                    'Q4 RMS-DCDAS Score -  ' +
                                                                        dcdasq4,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq4 = '5';
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
                                                                  'Q4 RMS-DCDAS Score -  ' +
                                                                      dcdasq4,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq5
                Row(
                  children: [
                    dcdasq5 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq5)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q5.tr(),
                          //'Q5. Select the expression that you feel  if you are getting a filling in your tooth',
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
                                        LocaleKeys.q5.tr(),
                                        //'Select the expression that you feel  if you are getting a filling in your tooth',
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
                                                dcdasq5 = '1';
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
                                                                    'Q5 RMS-DCDAS Score -: ' +
                                                                        dcdasq5,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq5 = '2';
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
                                                                    'Q5 RMS-DCDAS Score -: ' +
                                                                        dcdasq5,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq5 = '3';
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
                                                                    'Q5 RMS-DCDAS Score -: ' +
                                                                        dcdasq5,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq5 = '4';
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
                                                                    'Q5 RMS-DCDAS Score -: ' +
                                                                        dcdasq5,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq5 = '5';
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
                                                                  'Q5 RMS-DCDAS Score -: ' +
                                                                      dcdasq5,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq6
                Row(
                  children: [
                    dcdasq6 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq6)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q6.tr(),
                          //'Q6. Select the expression that you feel  if you are having a tooth taken out',
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
                                        LocaleKeys.q6.tr(),
                                        //'Select the expression that you feel  if you are having a tooth taken out',
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
                                                dcdasq6 = '1';
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
                                                                    'Q6 RMS-DCDAS Score -: ' +
                                                                        dcdasq6,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq6 = '2';
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
                                                                    'Q6 RMS-DCDAS Score -: ' +
                                                                        dcdasq6,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq6 = '3';
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
                                                                    'Q6 RMS-DCDAS Score -: ' +
                                                                        dcdasq6,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq6 = '4';
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
                                                                    'Q6 RMS-DCDAS Score -: ' +
                                                                        dcdasq6,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq6 = '5';
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
                                                                  'Q6 RMS-DCDAS Score -: ' +
                                                                      dcdasq6,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq7
                Row(
                  children: [
                    dcdasq7 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq7)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q7.tr(),
                          //'Q7. Select the expression that you feel  if you are being put to sleep for the treatment of your teeth',
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
                                        LocaleKeys.q7.tr(),
                                        //'Select the expression that you feel  if you are being put to sleep for the treatment of your teeth',
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
                                                dcdasq7 = '1';
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
                                                                    'Q7 RMS-DCDAS Score -: ' +
                                                                        dcdasq7,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq7 = '2';
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
                                                                    'Q7 RMS-DCDAS Score -: ' +
                                                                        dcdasq7,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq7 = '3';
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
                                                                    'Q7 RMS-DCDAS Score -: ' +
                                                                        dcdasq7,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq7 = '4';
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
                                                                    'Q7 RMS-DCDAS Score -: ' +
                                                                        dcdasq7,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq7 = '5';
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
                                                                  'Q7 RMS-DCDAS Score -: ' +
                                                                      dcdasq7,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //dcdasq8
                Row(
                  children: [
                    dcdasq8 == ''
                        ? Text(
                            '(0)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          )
                        : Text(
                            '($dcdasq8)',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.blue),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 240,
                        child: Text(
                          LocaleKeys.q8.tr(),
                          //"Q8. Select the expression that you feel  if you are having a mixture of gas and air which while will help you feel comfortable for treatment but cannot put you to sleep",
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
                                        LocaleKeys.q8.tr(),
                                        //"Select the expression that you feel  if you are having a mixture of gas and air which while will help you feel comfortable for treatment but cannot put you to sleep",
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
                                                dcdasq8 = '1';
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
                                                                    'Q8 RMS-DCDAS Score -: ' +
                                                                        dcdasq8,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smile.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq8 = '2';
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
                                                                    'Q8 RMS-DCDAS Score -: ' +
                                                                        dcdasq8,
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
                                                    image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_smirk.jpg?dummy=${counter++}',
                                                    ),
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
                                                dcdasq8 = '3';
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
                                                                    'Q8 RMS-DCDAS Score -: ' +
                                                                        dcdasq8,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_poker.jpg?dummy=${counter++}'),
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
                                                dcdasq8 = '4';
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
                                                                    'Q8 RMS-DCDAS Score -: ' +
                                                                        dcdasq8,
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
                                                    image: NetworkImage(
                                                        baseUrl+'static/' +
                                                            uid! +
                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
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
                                              dcdasq8 = '5';
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
                                                                  'Q8 RMS-DCDAS Score -: ' +
                                                                      dcdasq8,
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
                                                  image: NetworkImage(
                                                      baseUrl+'static/' +
                                                          uid! +
                                                          '_input_sad.jpg?dummy=${counter++}'),
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
                      onPressed: () async{
                       //await context.setLocale(Locale('en'));
                       if((dcdasq1 != '') && (dcdasq2 != '') 
                       && (dcdasq3 != '') && (dcdasq4 != '') 
                       && (dcdasq5 != '') && (dcdasq6 != '') 
                       && (dcdasq7 != '') && (dcdasq8 != '')){
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scale2CompareWith(
                              getImage: widget.getImage!,
                              scaleNumber: widget.scaleNumber!,
                              patientid: widget.patientid!,
                              name: widget.name!,
                              appointmentNum: widget.appointmentNum!,
                              age: widget.age!,
                              address: widget.address!,
                              gender: widget.gender!,
                              phnum: widget.phnum!,
                              dcdas1: dcdasq1,dcdas2: dcdasq2,
                              dcdas3: dcdasq3,dcdas4: dcdasq4,
                              dcdas5: dcdasq5,dcdas6: dcdasq6,
                              dcdas7: dcdasq7,dcdas8: dcdasq8, 
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
