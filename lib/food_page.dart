import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcall/component_page.dart';
import 'dart:io';

import 'buttons/back_button.dart';

Future<int> EditDialog(context, name, hint) async {

  final TextEditingController textController = TextEditingController();
  int value = 0;

  await showDialog(context: context, builder: (context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      title: Text("$name",overflow: TextOverflow.ellipsis , style: TextStyle(color: Colors.black ,fontSize: 25, fontWeight: FontWeight.w900),),
      content: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
        ),
        child: TextField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onTapOutside: (point) {
            FocusNode focusDel = FocusScope.of(context);
            focusDel.unfocus();
          },
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          controller: textController,
          decoration: InputDecoration(
            isDense: true,
            hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
            hintText: "$hint",
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: [

        Row(
          children: [

            Expanded(
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    fixedSize: const WidgetStatePropertyAll(Size(220, 40)),
                    side: WidgetStatePropertyAll(BorderSide(color: Colors.black , width: 1.5)),
                    backgroundColor: WidgetStateColor.transparent,
                    overlayColor: const WidgetStatePropertyAll(Color(0x1AFF0000)),
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Отмена", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black ),)
              ),
            ),

            const SizedBox(width: 10,),

            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    fixedSize: const WidgetStatePropertyAll(Size(220, 40)),
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    value = int.parse(textController.text).round();
                    Navigator.pop(context);
                  },
                  child: Text("Сохранить", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),)
              ),
            ),

          ],
        )

      ],
    );
  });
  return value;
}

class FoodScreen extends StatefulWidget {
  final int index;
  //final Map<String,dynamic> data;
  const FoodScreen({
    super.key,
    required this.index,
    /*required this.data*/
  });

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  XFile? image;

  final TextEditingController _foodNameController = TextEditingController();

  List<String> _caloriesNames= ["ккал", "белки", "жиры", "углеводы"];
  Map<String, dynamic> _caloriesMap = {
    "ккал": 0,
    "белки": 0,
    "жиры": 0,
    "углеводы": 0,
  };
  List<Map<String, dynamic>> _componentMaps = [
    {
      "название": "Лук",
      "ккал": 10,
      "белки": 5,
      "жиры": 4,
      "углеводы": 2,
    },
    {
      "название": "Чеснок",
      "ккал": 2,
      "белки": 2,
      "жиры": 2,
      "углеводы": 4,
    },
  ];
  List<TextEditingController> _controllersList = [];
  List<Map<String, dynamic>> _componentsList = [];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          titleSpacing: 20,
          title: Text(
            "${widget.index} блюдо",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),
          ),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          clipBehavior: Clip.none,
          children: [

            const Text(
              "Фото",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black),
            ),

            const SizedBox(
              height: 20,
            ),

            FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final img =
                  await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    image = img;
                  });
                },
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Добавить",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              height: 123,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFFCCCCCC), width: 2),
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: image== null
                        ? const AssetImage("assets/images/noimage.png")
                        : FileImage(File(image!.path))),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Text(
              "Название",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 15,
                        offset: Offset.zero)
                  ]),
              child: TextField(
                controller: _foodNameController,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Макароны с сыром...",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFB3B3B3)),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Text(
              "Калории",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 65,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(13),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 15),
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
                          child: Text("${_caloriesMap[_caloriesNames[i]].round()}", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 12),),
                        ),

                        Expanded(
                          child: Text(_caloriesNames[i], style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12),),
                        ),

                      ],
                    ),
                  );},
                itemCount: 4,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Text(
              "Состав",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: _componentMaps.length + 1,
                itemBuilder: (BuildContext context, int i) {
                  return i==_componentMaps.length
                      ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ComponentScreen()));
                          },
                          child: Ink(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFDEE2E5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(child: Text("Изменить", style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w800, fontSize: 12, ),),),
                          )
                      )
                  )
                      : FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () async {
                            //TODO add component
                            int _weight = await EditDialog(context, "Введите вес(в граммах)", "100 гр.");
                            if (_weight != 0) {
                              setState(() {
                                _controllersList.add(TextEditingController());

                                _controllersList.last.text = _weight.toString();
                                _componentsList.add(_componentMaps[i]);
                                _caloriesMap["ккал"] += _componentMaps[i]["ккал"] * (_weight / 100);
                                _caloriesMap["жиры"] += _componentMaps[i]["жиры"] * (_weight / 100);
                                _caloriesMap["белки"] += _componentMaps[i]["белки"] * (_weight / 100);
                                _caloriesMap["углеводы"] += _componentMaps[i]["углеводы"] * (_weight / 100);
                              });
                            }
                          },
                          child: Ink(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Center(child: Text(_componentMaps[i]["название"], style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.w800, fontSize: 12, ),),),
                          ),
                        ),
                      )
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Column(
              children: List.generate(_controllersList.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [

                      Text("${i + 1}.", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),),

                      const SizedBox(width: 10,),

                      Expanded(
                        flex: 3,
                        child: Text(_componentsList[i]["название"], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),),
                      ),

                      const SizedBox(width: 10,),

                      Container(
                        clipBehavior: Clip.none,
                        width: 50,
                        height: 35,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric( horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextField(
                          controller: _controllersList[i],
                          readOnly: true,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: "100",
                            hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFFB3B3B3)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5,),

                      Text("гр.", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),),

                      const SizedBox(width: 15,),

                      InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: (){
                          //TODO удаление продукта
                          setState(() {
                            int _weight = int.parse(_controllersList[i].text).round();
                            double _ccal = _componentsList[i]["ккал"] * (_weight/100);
                            double _jiry = _componentsList[i]["жиры"] * (_weight/100);
                            double _belki = _componentsList[i]["белки"] * (_weight/100);
                            double _yglevody = _componentsList[i]["углеводы"] * (_weight/100);
                            _controllersList.removeAt(i);
                            _caloriesMap["ккал"] -= _ccal;
                            _caloriesMap["жиры"] -= _jiry;
                            _caloriesMap["белки"] -= _belki;
                            _caloriesMap["углеводы"] -= _yglevody;
                            _componentsList.removeAt(i);
                          });
                        },
                        child: Ink(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E2E2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(CupertinoIcons.minus, color: Colors.black,),
                        ),
                      )

                    ],
                  ),
                );
              }),
            ),

            const SizedBox(
              height: 105,
            ),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomBackButton(screenContext: context),
      ),
    );
  }
}
