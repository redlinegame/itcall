import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itcall/buttons/back_button.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<TextEditingController> _namesControllersList = [];
  List<TextEditingController> _weightControllersList = [];
  List<Map<String, dynamic>> _componentsList = [];

  void _addMap() {
    setState(() {
      _namesControllersList.add(TextEditingController());
      _weightControllersList.add(TextEditingController());
      _componentsList.add({
        "productName": "",
        "productWeight": '',
      });
    });
  }
  void _delMap(i) {
    setState(() {
      _namesControllersList.removeAt(i);
      _weightControllersList.removeAt(i);
      _componentsList.removeAt(i);
    });
  }

  @override
  void initState() {
    super.initState();
    if(_namesControllersList.isEmpty){
      _addMap();
    }
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
          title: const Text("История", overflow: TextOverflow.ellipsis ,style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 105),
          itemBuilder: (context, i) {
            return ProductCard(
              key: Key("$i"),
              productMap: _componentsList,
              index: i,
              weightControllers: _weightControllersList,
              namesControllers: _namesControllersList,
              addMap: _addMap,
              delMap: _delMap,
              isLast: _componentsList.length == 1 ? true : false,
            );
          },
          itemCount: _componentsList.length,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomBackButton(screenContext: context),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final List<Map<String, dynamic>> productMap;
  final int index;
  final weightControllers;
  final namesControllers;
  final addMap;
  final delMap;
  final bool isLast;
  const ProductCard({
    super.key,
    required this.productMap,
    required this.index,
    this.weightControllers,
    this.namesControllers,
    this.addMap,
    this.delMap,
    required this.isLast
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  late int _index;

  void _addName() {
    setState(() {
      widget.namesControllers[_index].text = widget.productMap[_index]["productName"].toString();
    });
  }

  void _addWeight() {
    setState(() {
      widget.weightControllers[_index].text = widget.productMap[_index]["productWeight"].toString();
    });
  }

  void _checkAbility() {
    if(widget.weightControllers.last.text.toString().isNotEmpty && widget.namesControllers.last.text.toString().isNotEmpty) {
      widget.addMap();
    }
  }

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _addName();
    _addWeight();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric( horizontal: 20),
        child: Row(
          children: [

            Text("${widget.index+1}.", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),),

            const SizedBox(width: 10,),

            Expanded(
              flex: 3,
              child: TextField(
                controller: widget.namesControllers[widget.index],
                onChanged: (change) {
                  _checkAbility();
                },
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Продукт/блюдо",
                  hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFFB3B3B3)),
                  border: InputBorder.none,
                ),
              ),
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
                controller: widget.weightControllers[widget.index],
                maxLines: 1,
                onChanged: (change) {
                  _checkAbility();
                },
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
              onTap: widget.isLast ? null : (){
                widget.delMap(_index);
              },
              child: Ink(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFE2E2E2),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(CupertinoIcons.minus, color: widget.isLast ? Color(0xFFB3B3B3) : Colors.black,),
              ),
            )

          ],
        )
    );
  }
}
