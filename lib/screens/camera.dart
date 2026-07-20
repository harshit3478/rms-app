import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:convert';
import 'package:image_cropper/image_cropper.dart';
import 'package:rmsnewmodule/widgets/loadingImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:dio/dio.dart';
import 'package:photofilters/photofilters.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/apipath.dart';

// ── Logging helpers ──────────────────────────────────────────────────────────
void _log(String msg) => dev.log(msg, name: 'Camera');
void _logErr(String msg, [Object? err, StackTrace? st]) =>
    dev.log(msg, name: 'Camera', level: 1000, error: err, stackTrace: st);

// Translate a DioException into a human-readable reason for logs + UI
String _dioReason(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return 'Cannot reach server (${e.requestOptions.uri.host}) — '
          'check network or server status. ${e.error}';
    case DioExceptionType.connectionTimeout:
      return 'Connection timed out after ${e.requestOptions.connectTimeout?.inSeconds}s';
    case DioExceptionType.receiveTimeout:
      return 'Server took too long to respond '
          '(>${e.requestOptions.receiveTimeout?.inSeconds}s)';
    case DioExceptionType.sendTimeout:
      return 'Upload timed out — image may be too large';
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      final body = e.response?.data?.toString() ?? '';
      return 'Server returned HTTP $code. Body: $body';
    case DioExceptionType.cancel:
      return 'Request was cancelled';
    case DioExceptionType.unknown:
    default:
      return 'Unknown error: ${e.message}';
  }
}

// Shared Dio instance with sane timeouts for an AI inference server
final _dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 15),
  sendTimeout:    const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 60),
));

class Camera extends StatefulWidget {
  Camera(
      {Key? key,
      this.name,
      this.age,
      this.phnum,
      this.address,
      this.patientid,
      this.appointmentNum,
      this.gender,
      this.scaleNumber})
      : super(key: key);
  final int? scaleNumber;
  final String? name;
  final String? age;
  final String? phnum;
  final String? address;
  final String? patientid;
  final String? appointmentNum;
  final String? gender;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  bool isLoading = false;
  XFile? _image;
  File? _newimage;
  var croppedfilenew;
  String uid = '';
  String? email;
  Uint8List? imagebyte;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      email = user.email;
      _log('Authenticated as ${user.email} (uid: ${user.uid})');
    } else {
      _logErr('WARNING: No authenticated user in Camera — uid will be empty');
    }
  }

  final ImagePicker picker = ImagePicker();

  String? fileName;

  Future pickImage(context, ImageSource source) async {
    setState(() => isLoading = true);

    _image = await picker.pickImage(source: source);
    _log('Image picked: ${_image?.path}');

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 900,
      maxWidth: 900,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Cropper'),
      ],
    );

    _log('Image cropped: ${croppedFile?.path}');
    setState(() {
      croppedfilenew = croppedFile;
      isLoading = false;
    });

    imagebyte = await croppedfilenew.readAsBytes();
    setState(() => isLoading = false);

    fileName = basename(_image!.path);
    _log('Filename: $fileName | bytes: ${imagebyte?.length}');

    var image = imageLib.decodeImage(File(croppedfilenew!.path).readAsBytesSync());
    image = imageLib.copyResize(image!, width: 420);

    final Map imagefile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text('Add Filters'),
          image: image!,
          filters: presetFiltersList,
          filename: fileName!,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imagefile.containsKey('image_filtered')) {
      setState(() {
        _newimage = imagefile['image_filtered'];
        isLoading = false;
      });
      _log('Filter applied — output path: ${_newimage?.path}');
    } else {
      _log('Filter selector returned without image_filtered key. Keys: ${imagefile.keys.toList()}');
    }
  }

  Future<void> _passImage(BuildContext context) async {
    if (uid.isEmpty) {
      _logErr('Aborting upload — uid is empty (user not authenticated)');
      if (!mounted) return;
      _showError(context, 'Not logged in. Please restart the app.');
      return;
    }

    setState(() => isLoading = true);

    final String base64Image =
        base64Encode(File(_newimage!.path).readAsBytesSync());
    final int byteLen = base64Image.length;
    final String url = '${baseUrl}api?uid=$uid';

    _log('POST $url | payload size: ${(byteLen / 1024).toStringAsFixed(1)} KB');

    try {
      final Response response = await _dio.post(
        url,
        options: Options(contentType: 'application/json; charset=UTF-8'),
        data: {'data': base64Image},
      );

      _log('Response status: ${response.statusCode}');
      _log('Response headers: ${response.headers.map}');
      _log('Response data (first 300 chars): '
          '${response.data.toString().substring(0, response.data.toString().length.clamp(0, 300))}');

      if (response.statusCode == 200) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoadingImage(
              getImage: File(_newimage!.path),
              scaleNumber: widget.scaleNumber,
              patientid: widget.patientid,
              name: widget.name,
              appointmentNum: widget.appointmentNum,
              age: widget.age,
              address: widget.address,
              gender: widget.gender,
              phnum: widget.phnum,
            ),
          ),
        );
      } else {
        _logErr('Unexpected success-range status: ${response.statusCode}');
        if (!mounted) return;
        setState(() => isLoading = false);
        _showError(context, 'Server returned status ${response.statusCode}. Please try again.');
      }
    } on DioException catch (e, st) {
      final reason = _dioReason(e);
      _logErr('DioException [${e.type.name}]: $reason', e, st);
      final msg = _userFacingDioMessage(e);
      if (!mounted) return;
      setState(() => isLoading = false);
      // ignore: use_build_context_synchronously
      _showError(context, msg);
    } catch (e, st) {
      _logErr('Unexpected error during image upload', e, st);
      if (!mounted) return;
      setState(() => isLoading = false);
      // ignore: use_build_context_synchronously
      _showError(context, 'Unexpected error. Please try again.');
    }
  }

  String _userFacingDioMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'Cannot reach the server. Check your internet connection and try again.';
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The server is taking too long to respond. Please try again.';
      case DioExceptionType.sendTimeout:
        return 'Upload timed out — the image may be too large.';
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}). Please try again.';
      default:
        return 'Connection failed. Please try again.';
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: !isLoading
          ? IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ) : SizedBox(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.info_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                            height: 250,
                            child: Column(
                              children: [
                                Text(
                                  "1. Make sure the image is cropped to square. (1:1 Aspect Ratio)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "2. Make sure the face is not covered with the patient's hair or by mask.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "3. Make sure the image is clear and of good resolution.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      color: Colors.black),
                                )
                              ],
                            )),
                      );
                    });
              })
        ],
      ),
      body: isLoading
        ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height:10),
              Text('dont close the app',
                style: TextStyle(
                  fontFamily: 'Poppins'
                ),
              )
            ],
          ),
        )
          // ? Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: 60.0,
          //       ),
          //       Center(
          //         child: Text("Uploading",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 20,
          //                 fontFamily: 'Poppins')),
          //       ),
          //       Center(
          //         child: Text("Image",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.blue,
          //                 fontSize: 20,
          //                 fontFamily: 'Poppins')),
          //       ),
          //       SizedBox(
          //         height: 60.0,
          //       ),
          //       Center(
          //         child: Column(
          //           children: <Widget>[
          //             Container(
          //               height: 300,
          //               width: 300,
          //               decoration: BoxDecoration(
          //                   image: DecorationImage(
          //                       image: AssetImage('assets/loader.gif'))),
          //             ),
          //             SizedBox(
          //               height: 5.0,
          //             ),
          //             Center(
          //               child: Text("Please wait, do not close the app...",
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                       color: Colors.blue,
          //                       fontSize: 18,
          //                       fontFamily: 'Poppins')),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    //padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Add Patient Picture',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          'Select an picture for ${widget.name}!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25.0),
                  //padding: EdgeInsets.all(1.0),
                  height: 360,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2),
                    color: Color(0xFFE5E5EB),
                  ),
                  child: _image == null
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/preview.gif'),
                                  fit: BoxFit.cover)),
                        )
                      : Image.memory(
                    imagebyte!,
                          fit: BoxFit.cover,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Container(
                        height: 40.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xA60D79DD),
                                  Color(0xA60D79DD),
                                  Color(0xA60D79DD),
                                ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Text('Gallery',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            IconButton(
                                icon: Icon(Icons.image_outlined,
                                    size: 19, color: Colors.white),
                                onPressed: () async {
                                  try {
                                    await pickImage(context, ImageSource.gallery);
                                  } catch (e, st) {
                                    _logErr('Gallery pick failed', e, st);
                                    if (context.mounted) Navigator.of(context).pop();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xA60D79DD),
                                Color(0xA60D79DD),
                                Color(0xA60D79DD),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Text('Camera',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Colors.white)),
                          IconButton(
                              icon: Icon(Icons.camera,
                                  size: 19, color: Colors.white),
                              onPressed: () async {
                                try {
                                  await pickImage(context, ImageSource.camera);
                                } catch (e, st) {
                                  _logErr('Camera pick failed', e, st);
                                  if (context.mounted) Navigator.of(context).pop();
                                }
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xA60D79DD),
                                Color(0xA60D79DD),
                                Color(0xA60D79DD),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '   Next',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                          ),
                          IconButton(
                              icon: Icon(Icons.arrow_forward,
                                  size: 19, color: Colors.white),
                              onPressed: () async {
                                _image == null
                                    ? showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    'Please select an image.',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black),
                                                  ),
                                                )),
                                          );
                                        })
                                    : await _passImage(context);
                              }),
                          //_refresh(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
