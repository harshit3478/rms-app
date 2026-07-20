import 'dart:io';
import 'package:rmsnewmodule/screens/camera.dart';
import 'package:rmsnewmodule/screens/scale1/rmsDS.dart';
import 'package:rmsnewmodule/screens/scale2/dcdas.dart';
import 'package:rmsnewmodule/widgets/loading.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatefulWidget {
  LoadingImage({
    this.getImage, this.scaleNumber,
    this.name,
    this.age,
    this.phnum,
    this.address,
    this.patientid,
    this.appointmentNum,
    this.gender,
  });
  
  final File? getImage;
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String?address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;

  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  @override
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 4), () {
      if (widget.scaleNumber == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPatient(
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
      } else if (widget.scaleNumber == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dcdas(
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
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Error, please restart the app.',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            color: Colors.black),
                      ),
                    )),
              );
            });
      }
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: Text("Successfully",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: 'Poppins')),
                ),
                Center(
                  child: Text("Uploaded",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 20,
                          fontFamily: 'Poppins')),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/loader.gif'))),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Center(
                        child: Text("Please wait, rendering emotions...",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                                fontSize: 18,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
