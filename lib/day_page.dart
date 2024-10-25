import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itcall/buttons/back_button.dart';
import 'package:itcall/intake_page.dart';

import 'buttons/history_button.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({super.key});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {

  final List<Map<String, dynamic>> _itemsMaps = [
    {"intakeNumber": 0,"foodCount": 0},
    {"intakeNumber": 1,"foodCount": 0},
    {"intakeNumber": 2,"foodCount": 4},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.easeInOut,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.black,),
                tooltip: 'Редактировать',
                onPressed: () {
                  // handle the press
                },
              ),
            ),
          ],
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          titleSpacing: 20,
          title: const Text("Приёмы пищи", overflow: TextOverflow.ellipsis ,style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
          ),
        ),
        body: ReorderableListView.builder(
          padding: EdgeInsets.only(top: 15, bottom: 170),
          itemBuilder:(context, i){
            return Material(
                key: Key("$i"),
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: _itemsMaps.length==i && _itemsMaps.length!=9 ? AddIntakeCard(key: Key("$i"), index: i,) : IntakeCard(key: Key("$i"),intakeMap: _itemsMaps[i], index: i,)
            );
          },
          itemCount:_itemsMaps.length != 9 ? _itemsMaps.length + 1 : _itemsMaps.length,
          onReorder: (i, newi){
            if (newi > i) {
              newi -= 1;
            }

            final Map<String, dynamic> items = _itemsMaps.removeAt(i);
            _itemsMaps.insert(newi, items);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomHistoryButton(screenContext: this.context,),
            CustomBackButton(screenContext: this.context,),
          ],
        ),
      ),
    );
  }
}

class IntakeCard extends StatelessWidget {
  final Map<String, dynamic> intakeMap;
  final int index;
  IntakeCard({super.key, required this.intakeMap, required this.index});

  final List<String> _intakeName = ["Завтрак","Обед","Ужин","Полдник","Перекус"];
  final List<String> _intakeImgName = ["zavtrak","obed","yjin","poldnik","perekys"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => IntakeScreen(intakeNumber: index + 1, intakeName: _intakeName[index],)));
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Ink(
            width: 400,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [BoxShadow(blurRadius: 8, color: Color(0x40000000))]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Ink(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage("assets/images/${_intakeImgName[intakeMap["intakeNumber"]]}.png"),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                ),

                Text(_intakeName[intakeMap["intakeNumber"]], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),),

                Text("${intakeMap["foodCount"]} блюд", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF444444)),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddIntakeCard extends StatelessWidget {
  final int index;
  AddIntakeCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => IntakeScreen(intakeNumber: index + 1, intakeName: "Перекус",)));
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Ink(
            width: 400,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [BoxShadow(blurRadius: 8, color: Color(0x40000000))]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Ink(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: AssetImage("assets/images/addintake.png"), fit: BoxFit.cover)
                    ),
                  ),
                ),

                Text("Добавить приём пищи", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}