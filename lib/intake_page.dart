import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcall/buttons/back_button.dart';
import 'package:itcall/food_page.dart';

import 'buttons/history_button.dart';

class IntakeScreen extends StatefulWidget {
  final int intakeNumber;
  final String intakeName;
  const IntakeScreen({super.key, required this.intakeNumber, required this.intakeName});

  @override
  State<IntakeScreen> createState() => _IntakeScreenState();
}

class _IntakeScreenState extends State<IntakeScreen> {

  List _itemsNames = ["Кабачок с мясомdwawdwdwadwadwadaw",];
  late int _intakeNumber;
  late String _intakeName;

  String _choosedSort = "Перекус";

  final List<String> _choicesItemModalWindow = ["Перекус","Полдник"];

  @override
  void initState() {
    super.initState();
    _intakeName = widget.intakeName;
    _intakeNumber = widget.intakeNumber;
  }

  XFile? image;


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
          title: Text("$_intakeNumber приём пищи", overflow: TextOverflow.ellipsis ,style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 30,),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Название", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Ink(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [BoxShadow(blurRadius: 10, offset: Offset(0, 2), color: Color(0x40000000))],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Material(
                    type: MaterialType.transparency,
                    child: _intakeName != "Завтрак" && _intakeName != "Обед" && _intakeName != "Ужин" ?  PopupMenuButton(
                      tooltip: "Название",
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      itemBuilder: (BuildContext context) {
                        return _choicesItemModalWindow
                            .map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            padding: const EdgeInsets.only(right: 50, left: 20,),
                            child: Text(choice, style: const TextStyle(color: Colors.black),),
                            onTap: () {
                              setState(() {
                                _choosedSort = choice;

                                FocusScope.of(context).requestFocus(FocusNode());
                              });
                            },
                          );
                        }).toList();
                      },
                      child: Ink(
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 10, offset: Offset(0, 2), color: Color(0x40000000))],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [


                              Text(_choosedSort, textAlign: TextAlign.end, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600 , fontSize: 15),),

                              const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_down,)
                              ),


                            ],
                          ),
                        ),
                      ),
                    ) : Ink(
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 10, offset: Offset(0, 2), color: Color(0x40000000))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [


                            Text(_intakeName, textAlign: TextAlign.end, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600 , fontSize: 15),),



                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Блюда (${_itemsNames.length} из 20)", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),),
            ),

            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(top: 5, bottom: 105, left: 10, right: 10),
                crossAxisCount: 2,
                childAspectRatio: 1.15/1,
                children: List.generate(_itemsNames.length!=20 ?_itemsNames.length+1 : _itemsNames.length, (i)=> Material(
                    key: Key("$i"),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: i==_itemsNames.length && _itemsNames.length!=20
                        ? AddFoodCard(key: Key("$i"), index: i + 1,)
                        : FoodCard(key: Key("$i"),foodName: _itemsNames[i], index: i + 1,)
                )),
              ),
            ),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomBackButton(screenContext: this.context,),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final int index;
  final String foodName;
  FoodCard({super.key, required this.foodName, required this.index});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodScreen(index: index)));
          },
          child: Ink(
            width: 180,
            height: 150,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [const BoxShadow(blurRadius: 8, color: Color(0x40000000))]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Ink(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFCCCCCC), width: 2),
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                        image: AssetImage("assets/images/noimage.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Expanded(child: Text(foodName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddFoodCard extends StatelessWidget {
  final int index;
  const AddFoodCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodScreen(index: index)));
          },
          child: Ink(
            width: 180,
            height: 150,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [const BoxShadow(blurRadius: 8, color: Color(0x40000000))]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Ink(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(Icons.add, color: Colors.black, size: 50,),
                  ),
                ),

                Expanded(child: Text("Добавить блюдо", maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
