import 'dart:io';
import 'package:rmsnewmodule/screens/scale1/rmsDS.dart';
import 'package:rmsnewmodule/screens/scale2/dcdas.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading({this.getImage, this.scaleNumber});
  final File? getImage;
  final int? scaleNumber;
  @override
  _LoadingState createState() => _LoadingState();
}

//two_pi = 3.14 * 2
class _LoadingState extends State<Loading> {
  @override
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 6), () {
      if (widget.scaleNumber == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPatient(
                      getImage: widget.getImage!,
                    )));
      } else if (widget.scaleNumber == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dcdas()));
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
    return Scaffold(
      body: Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 4),
              builder: (context, value, child) {
                int percentage = (value * 100).ceil();
                return Container(
                  width: 110,
                  height: 150,
                  //color: Color(0xA60D79DD),
                  child: Stack(
                    children: <Widget>[
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                              startAngle: 0.0,
                              endAngle: 3.14 * 2,
                              stops: [value, value],
                              center: Alignment.center,
                              colors: [
                                Color(0xA60D79DD),
                                Colors.grey.withAlpha(55)
                              ]).createShader(rect);
                        },
                        child: Container(
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      Image.asset('assets/loading.png').image)),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 80,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '$percentage' + '%',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
