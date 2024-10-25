import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itcall/buttons/add_button.dart';
import 'package:itcall/food_page.dart';

import 'buttons/back_button.dart';
import 'buttons/history_button.dart';

class ComponentScreen extends StatefulWidget {
  const ComponentScreen({super.key});

  @override
  State<ComponentScreen> createState() => _ComponentScreenState();
}

class _ComponentScreenState extends State<ComponentScreen> {

  List<Map<String, dynamic>> _componentsMaps = [];
  List<TextEditingController> _controllersList = [];

  void _addComponent() {
    setState(() {
      _componentsMaps.add({
        "название": "",
        "ккал": 0,
        "белки": 0,
        "жиры": 0,
        "углеводы": 0,
      });
      _controllersList.add(TextEditingController());
    });
  }



  void _deleteMap(i) {
    setState(() {
      print(_controllersList);
      _controllersList.removeAt(i);
      _componentsMaps.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          titleSpacing: 20,
          title: const Text(
            "Ингридиенты",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),
          ),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 20, bottom: 180),
          itemCount: _componentsMaps.length,
          itemBuilder: (context, i) {
            return _componentsMaps[i]["название"].toString().isEmpty
                ? ComponentCard(isExpanded: true,deleteMap: _deleteMap,index: i, map: _componentsMaps[i], controller: _controllersList,)
                : ComponentCard(isExpanded: false,index: i, deleteMap: _deleteMap, map: _componentsMaps[i], controller: _controllersList);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomAddComponentButton(screenContext: this.context,onTap: _addComponent,),
            CustomBackButton(screenContext: this.context,),
          ],
        ),
      ),
    );
  }
}

class ComponentCard extends StatefulWidget {
  final bool isExpanded;
  final deleteMap;
  final int index;
  final Map<String, dynamic> map;
  final controller;
  const ComponentCard({super.key, required this.isExpanded, this.deleteMap, required this.index, required this.map, required this.controller});

  @override
  State<ComponentCard> createState() => _ComponentCardState();
}

class _ComponentCardState extends State<ComponentCard> {

  late bool _isExpanded;
  var _deleteMap;
  late Map<String, dynamic> _map;
  late int _index;

  List<String> _caloriesNames= ["ккал", "белки", "жиры", "углеводы"];

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _deleteMap = widget.deleteMap;
    _index = widget.index;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;

        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
        padding: EdgeInsets.all(20),
        height: _isExpanded ? 310 : 110,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text("${_index+1}", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),)),
                  ),
                ),

                SizedBox(width: 5,),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOutCirc,
                    switchOutCurve: Curves.easeInOutCirc,
                    child: _isExpanded
                        ?  Container(
                      key: Key("fc$_index"),
                      clipBehavior: Clip.none,
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric( horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextField(
                        controller: widget.controller[_index],
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Название...",
                          hintStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFFB3B3B3)),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                        :  Container(
                      key: Key("sc$_index"),
                      clipBehavior: Clip.none,
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric( horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        controller: widget.controller[_index],
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                        decoration:  InputDecoration(
                          hintText: "Название...",
                          hintStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFFB3B3B3)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),



            Expanded(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCirc,
                opacity: _isExpanded ? 1 : 0,
                child: _isExpanded == false ? SizedBox() : Column(
                  children: [

                    Expanded(flex: 2,child: SizedBox(height: 30,)),

                    Expanded(
                      flex: 5,
                      child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                              "Калорийность (100 гр.)",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)
                          )),
                    ),

                    Expanded(flex: 1,child: SizedBox(height: 20,)),

                    Expanded(
                      flex: 10,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          height: 75,
                          width: MediaQuery.of(context).size.width -60,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Material(
                                    clipBehavior: Clip.none,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(7),
                                      onTap: () async {
                                        int value = await EditDialog(context, _caloriesNames[i], "Введите количество");
                                        setState(() {
                                          widget.map[_caloriesNames[i]] = value;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(13),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(7),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color(0x40000000),
                                                  blurRadius: 12,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 1)
                                            ]),
                                        child: Column(
                                          children: [

                                            Expanded(
                                              child: Text("${widget.map[_caloriesNames[i]].round()}", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 12),),
                                            ),

                                            Expanded(
                                              child: Text(_caloriesNames[i], style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12),),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );},
                            itemCount: 4,
                          ),
                        ),
                      ),
                    ),

                    Expanded(flex: 2,child: SizedBox(height: 30,)),

                    Expanded(
                      flex: 10,
                      child: FittedBox(
                        child: SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Color(0xFFCB3030)),
                            ),
                            onPressed: () {
                              _deleteMap(_index);
                            },
                            child: Row(
                              children: [

                                Expanded(child: SizedBox()),

                                Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Удалить", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),),
                                    )),

                                Expanded(child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete_outline, color: Colors.white,),
                                ))

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

