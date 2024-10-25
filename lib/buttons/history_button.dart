import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itcall/history_page.dart';

class CustomHistoryButton extends StatelessWidget {
  final screenContext;
  CustomHistoryButton({super.key, required this.screenContext});

  final StreamController _streamController = StreamController();

  Stream _scaleStream() {

    Timer(Duration(milliseconds: 350), () {
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
                    boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 10, spreadRadius: 2, offset: Offset(0, 2))],
                    borderRadius: BorderRadius.circular(50)
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HistoryScreen()));
                  },
                  splashColor: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.white,
                  child: Row(
                    children: [

                      Expanded(child: SizedBox()),

                      Expanded(
                          flex: 2,
                          child: Align(
                              child: Text("История приёмов пищи", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: snapshot.data == 0.0 ? Colors.transparent : Colors.black),)
                          )
                      ),

                      Expanded(child: Icon(Icons.history, color: snapshot.data == 0.0 ? Colors.transparent : Colors.black,)),

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
