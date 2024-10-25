import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final screenContext;
  CustomBackButton({super.key, required this.screenContext});

  final StreamController _streamController = StreamController();

  Stream _scaleStream() {

    Timer(Duration(milliseconds: 100), () {
      _streamController.add(1.0);
    });

    return _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: StreamBuilder(
          initialData: 0.0,
          stream: _scaleStream(),
          builder: (context, snapshot) {
            return AnimatedScale(
              scale: snapshot.data ?? 0.0,
              duration: Duration(milliseconds: 900),
              curve: Curves.elasticOut,
              child: snapshot.data == 0.0 ? SizedBox( height: 1, width: 1,) : Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 10, spreadRadius: 4, offset: Offset(0, 2))],
                    borderRadius: BorderRadius.circular(50)
                ),
                margin: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 30),
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  onPressed: (){
                    Navigator.pop(screenContext);
                  },
                  splashColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.black,
                  child: Row(
                    children: [

                      Expanded(child: Icon(Icons.arrow_back, color: snapshot.data == 0.0 ? Colors.transparent : Colors.white,)),

                      Expanded(
                          flex: 2,
                          child: Align(
                              child: Text("Вернуться назад", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: snapshot.data == 0.0 ? Colors.transparent : Colors.white),)
                          )
                      ),

                      Expanded(child: SizedBox())

                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
