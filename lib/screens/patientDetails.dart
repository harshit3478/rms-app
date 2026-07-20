import 'package:rmsnewmodule/screens/camera.dart';
import 'package:rmsnewmodule/screens/files.dart';
import 'package:rmsnewmodule/screens/scale3/scale3_add_image.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientDetails extends StatefulWidget {
  PatientDetails(
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
      this.gender,
      
      this.dataModel
      })
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
  final String?rmsBS;
  final String? rmsPS;
  final String? rmsPsg;
  final index;

  final PatientDataModel? dataModel;

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  TextEditingController? controllerName;
  TextEditingController? controllerAge;
  TextEditingController? controllerPhnum;
  TextEditingController? controllerAddress;
  TextEditingController? controllerUniqueID;
  TextEditingController? controllerAppNo;

  String? name;
  String? age;
  String? phnum;
  String? address;
  String? uniId;
  String? uid;
  String? appointmentNum;
  void dialogBox(BuildContext ctx, String text) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) {
        Future.delayed(const Duration(seconds: 2), () {
          if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
        });
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
                const SizedBox(width: 12),
                Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRetestDialog(BuildContext ctx) {
    final nextTest = (int.tryParse(widget.appNo ?? '0') ?? 0) + 1;
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('Select Scale', style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RetestOption(
              label: 'Scale 1 — RMS-DAS',
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (_) => Camera(
                    scaleNumber: 1,
                    patientid: widget.id!,
                    name: widget.name!,
                    appointmentNum: nextTest.toString(),
                    age: widget.age!,
                    address: widget.address!,
                    gender: widget.gender!,
                    phnum: widget.phnum!,
                  ),
                ));
              },
            ),
            const SizedBox(height: 8),
            _RetestOption(
              label: 'Scale 2 — RMS-DCDAS',
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (_) => Camera(
                    scaleNumber: 2,
                    patientid: widget.id!,
                    name: widget.name!,
                    appointmentNum: nextTest.toString(),
                    age: widget.age!,
                    address: widget.address!,
                    gender: widget.gender!,
                    phnum: widget.phnum!,
                  ),
                ));
              },
            ),
            const SizedBox(height: 8),
            _RetestOption(
              label: 'Scale 3 — RMS-PCDAS',
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (_) => Scale3AddImage(
                    scaleNumber: 3,
                    patientid: widget.id,
                    name: widget.name,
                    appointmentNum: nextTest.toString(),
                    age: widget.age,
                    address: widget.address,
                    gender: widget.gender,
                    phnum: widget.phnum,
                  ),
                ));
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void updatePatientData() {

    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "ID": uniId,
        "app no": appointmentNum,
        "name": name,
        "age": age,
        "phnum": phnum,
        "address": address
      });
    });
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => new Navigation()));

    dialogBox(context,'Yay, patient data updated!');
    Future.delayed(Duration(seconds:2),(){
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();

    User?user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      this.uid = user.uid;

    }

    uniId = widget.id;
    name = widget.name;
    age = widget.age;
    phnum = widget.phnum;
    address = widget.address;
    appointmentNum = widget.appNo;

    controllerUniqueID = new TextEditingController(text:widget.id);
    controllerName = new TextEditingController(text: widget.name);
    controllerAge = new TextEditingController(text: widget.age);
    controllerPhnum = new TextEditingController(text: widget.phnum);
    controllerAddress = new TextEditingController(text: widget.address);
    controllerAppNo = new TextEditingController(text: widget.appNo);
  }

  void _showEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                "Edit Patient Details",
                style: TextStyle(fontFamily: "Poppins", fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controllerUniqueID,
                onChanged: (str) => setState(() => uniId = str),
                decoration: InputDecoration(
                  icon: Icon(Icons.format_list_numbered),
                  hintText: "Unique ID",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
              TextField(
                controller: controllerAppNo,
                keyboardType: TextInputType.number,
                onChanged: (str) => setState(() => appointmentNum = str),
                decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number_outlined),
                  hintText: "Test number",
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: controllerName,
                onChanged: (str) => setState(() => name = str),
                decoration: InputDecoration(
                  icon: Icon(Icons.account_box_outlined),
                  hintText: "Name",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controllerAge,
                onChanged: (str) => setState(() => age = str),
                decoration: InputDecoration(
                  icon: Icon(Icons.pin),
                  hintText: "Age",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controllerPhnum,
                onChanged: (str) => phnum = str,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: "Phone Number",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
              TextField(
                controller: controllerAddress,
                onChanged: (str) => address = str,
                decoration: InputDecoration(
                  icon: Icon(Icons.pin_drop_outlined),
                  hintText: "Address",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: updatePatientData,
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text("Update Now",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete record?', style: TextStyle(fontFamily: 'Poppins')),
        content: Text('This will permanently delete this patient record.',
            style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              FirebaseFirestore.instance.runTransaction((transaction) async {
                DocumentSnapshot snapshot = await transaction.get(widget.index);
                await transaction.delete(snapshot.reference);
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Navigation()));
              dialogBox(context, 'Patient data deleted!');
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('About Scores',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 16),
            Text("• Score 1: Very happy emotion",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            const SizedBox(height: 8),
            Text("• Score 2: Happy emotion",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            const SizedBox(height: 8),
            Text("• Score 3: Normal emotion",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            const SizedBox(height: 8),
            Text("• Score 4: Sad emotion",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            const SizedBox(height: 8),
            Text("• Score 5: Crying emotion",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: _showEditSheet,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red),
              onPressed: _confirmDelete,
            ),
            IconButton(
              icon: Icon(Icons.info_outlined, color: Colors.black, size: 26),
              onPressed: _showInfoDialog,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.img!),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name!,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text('unique ID: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.id!,
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text('location: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.address!,
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('age: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.age! + " years old",
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('gender: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.gender!.toLowerCase(),
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('phone num: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.phnum!,
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('test number: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                            Text(
                              widget.appNo!,
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('appointment date/time: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),
                        Text(
                          widget.date! + ',  ' + widget.time!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10),
                        Text(
                          'RMS-DAS Scores',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                       
                           SizedBox(height: 5,), 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RMS Digital Scale: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                        ),
                                        widget.rmsDS == '' || widget.rmsDS == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(widget.rmsDS!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),),
                                      ],
                                    ),
                                    widget.gender != 'FEMALE'

                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RMS PS Scale(boys): ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                    ),
                                    widget.rmsPS == '' || widget.rmsPS == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.rmsPS!,
                                        
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      )
                             ,
                             SizedBox(
                          height: 5,
                        ),
                                  ],
                                )
                               : Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                      'RMS PS Scale(girls): ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                    ),
                                    widget.rmsPsg == '' || widget.rmsPsg == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.rmsPsg!,
                                        
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                              

                            // SizedBox(
                            //   height: 5,
                            // ),
                                 ],
                               ),
                                  ],
                                ),
                                
                              
                              
                                
                            // Text(
                            //   'RMS Blind Scale: ' + widget.rmsBS + '  ,',
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //   ),
                            // ),
                          
                        
                        
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'VPT Scale: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                        ),
                                        widget.vpt == '' || widget.vpt == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.vpt! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //SizedBox(height: 5,),
                                Text(
                                  'FIS Scale: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.fis == '' || widget.fis == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.fis! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      )
                              ,
                                      ],
                                    )
                                  ],
                                ),
                                
                              
                           
                          

                        SizedBox(height: 10),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10),

                        Text(
                          'RMS-DCDAS Scores',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                       
                       SizedBox(height: 5,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q1 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas1 == '' || widget.dataModel!.dcdas1 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas1! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q2 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas2 == '' || widget.dataModel!.dcdas2 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas2!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q3 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas3 == '' || widget.dataModel!.dcdas3 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas3! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q4 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas4 == '' || widget.dataModel!.dcdas4 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas4! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q5 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas5 == '' || widget.dataModel!.dcdas5 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas5! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q6 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas6 == '' || widget.dataModel!.dcdas6 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas6!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                        SizedBox(height: 5,),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q7 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas7 == '' || widget.dataModel!.dcdas7 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas7! ,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q8 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.dcdas8 == '' || widget.dataModel!.dcdas8 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.dcdas8!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           
                         ],
                       ), 


                        SizedBox(height: 10),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10),

                        Text(
                          'RMS-PCDAS Scores',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                       
                        SizedBox(height: 5,), 
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q1 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas1 == '' || widget.dataModel!.pcdas1 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas1!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q2 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas2 == '' || widget.dataModel!.pcdas2 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas2!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q3 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas3 == '' || widget.dataModel!.pcdas3 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas3!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q4 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas4 == '' || widget.dataModel!.pcdas4 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas4!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q5 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas5 == '' || widget.dataModel!.pcdas5 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas5!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q6 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas6 == '' || widget.dataModel!.pcdas6 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas6!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                        SizedBox(height: 5,),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q7 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas7 == '' || widget.dataModel!.pcdas7 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas7!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q8 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.pcdas8 == '' || widget.dataModel!.pcdas8 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.pcdas8!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           
                         ],
                       ), 
                        SizedBox(height: 5,), 


                        SizedBox(height: 10),
                        Divider(color: Colors.black,),
                        SizedBox(height: 10),

                        Text(
                          'MCDASf Scores',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(height: 5,),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q1 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf1 == '' || widget.dataModel!.mcdasf1 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf1!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q2 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf2 == '' || widget.dataModel!.mcdasf2 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf2!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q3 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf3 == '' || widget.dataModel!.mcdasf3 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf3!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q4 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf4 == '' || widget.dataModel!.mcdasf4 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf4!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q5 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf5 == '' || widget.dataModel!.mcdasf5 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf5!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q6 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf6 == '' || widget.dataModel!.mcdasf6 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf6!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                         ],
                       ),
                        SizedBox(height: 5,),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q7 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf7 == '' || widget.dataModel!.mcdasf7 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf7!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                  'Q8 score: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),
                                ),
                                widget.dataModel!.mcdasf8 == '' || widget.dataModel!.mcdasf8 == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.mcdasf8!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                            
                             ],
                           ),
                           
                         ],
                       ), 
                        //SizedBox(height: 5,),
                        SizedBox(height: 10),
                        Divider(color: Colors.black,),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('Note: ',
                                  style: TextStyle(fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,fontSize: 12),),

                             widget.dataModel!.note == '' || widget.dataModel!.note == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.note!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                          ],
                        ),
                       
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('Favorite Scale: ',
                              style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,fontSize: 12),),

                            
                          
                              widget.dataModel!.favScale == '' || widget.dataModel!.favScale == null
                                    ? Text('NA',
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),)
                                    : Text(
                                        widget.dataModel!.favScale!,
                          style: TextStyle(fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,fontSize: 12),
                                      ),
                          ],
                        ),
                        
                        SizedBox(height: 10),

                        SizedBox(height: 35),
                        AppButton(
                          label: 'Take Retest',
                          icon: Icons.refresh,
                          onTap: () => _showRetestDialog(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70),
              ]),
        ));
  }
}

class _RetestOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _RetestOption({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(label, style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
