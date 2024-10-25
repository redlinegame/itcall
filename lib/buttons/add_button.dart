import 'dart:async';

import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final screenContext;
  final bool isWhite;
  final onTap;
  CustomAddButton({super.key, required this.screenContext, required this.isWhite, this.onTap});

  final StreamController _streamController = StreamController();
  final StreamController _dayToAddController = StreamController.broadcast();

  List<String> _dayName = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Воскресенье"];


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
                    boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 10, spreadRadius: 2, offset: Offset(0,isWhite == true ? 2 : 4))],
                    borderRadius: BorderRadius.circular(50)
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  onPressed: (){
                    showModalBottomSheet(
                      useSafeArea: true,
                      showDragHandle: true,
                      context: screenContext,
                      backgroundColor: Colors.transparent,
                      builder: (context){
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: ListView(
                              reverse: true,
                              children: [

                                StreamBuilder(
                                    stream: _dayToAddController.stream.asBroadcastStream(),
                                    builder: (context, snapshot) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(35),
                                        onTap: (){
                                          onTap(snapshot.data+1);
                                          Navigator.of(context).pop();
                                        },
                                        child: Ink(
                                          height: 60,
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                          decoration: BoxDecoration(
                                              color: snapshot.hasData ? Colors.black : Color(0xFFC6C6C6),
                                              borderRadius: BorderRadius.circular(35),
                                              boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 10, spreadRadius: 2, offset: Offset(0, 4))]
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              const Expanded(child: SizedBox()),

                                              Expanded(
                                                flex: 2,
                                                child: Align(alignment: Alignment.center,child: Text("Продолжить", style: TextStyle(color: snapshot.hasData ? Colors.white : Color(0xFF3E3E3E), fontSize: 15, fontWeight: FontWeight.w700),)),
                                              ),

                                              Expanded(child: Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward, color: snapshot.hasData ? Colors.white : Color(0xFF3E3E3E),)))

                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),

                                SizedBox(height: 30,),

                                PreferredSize(
                                  preferredSize: const Size.fromHeight(60.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50.0,
                                    child: StreamBuilder(
                                        stream: _dayToAddController.stream,
                                        builder: (context, snapshot) {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _dayName.length,
                                            itemBuilder: (BuildContext context, int i) {
                                              return FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        _dayToAddController.add(i);
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 300),
                                                        margin: i != 4 ? const EdgeInsets.only(left: 5) : const EdgeInsets.only(left: 5, right: 5),
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: i != snapshot.data
                                                                ? Colors.black
                                                                : Color(0xFFC5C5C5),
                                                            borderRadius: BorderRadius.circular(6)
                                                        ),
                                                        child: Center(child: Text(_dayName[i], style: TextStyle(color: i != snapshot.data
                                                            ? Colors.white
                                                            : Colors.black,
                                                          fontWeight: FontWeight.w800, fontSize: 12, ),),),
                                                      )
                                                  )
                                              );
                                            },
                                          );
                                        }
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20,),

                                Text("День недели", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),),



                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  splashColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  backgroundColor: isWhite == true ? Colors.white : Colors.black,
                  child: Row(
                    children: [

                      Expanded(child: SizedBox()),

                      Expanded(
                          flex: 2,
                          child: Align(
                              child: Text("Добавить новый", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: isWhite == true ? Colors.black : Colors.white),)
                          )
                      ),

                      isWhite == true ? Expanded(child: Icon(Icons.add, color:  Colors.black,)) : Expanded(child: SizedBox()),

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


class CustomAddComponentButton extends StatelessWidget {
  final screenContext;
  final onTap;
  CustomAddComponentButton({super.key, required this.screenContext, this.onTap});

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
                    boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 10, spreadRadius: 2, offset: Offset(0,2))],
                    borderRadius: BorderRadius.circular(50)
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  onPressed: onTap,
                  splashColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.white,
                  child: const Row(
                    children: [

                      Expanded(child: SizedBox()),

                      Expanded(
                          flex: 2,
                          child: Align(
                              child: Text("Добавить новый", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: Colors.black),)
                          )
                      ),

                      Expanded(child: Icon(Icons.add, color:  Colors.black,)),

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