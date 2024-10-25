import 'package:flutter/material.dart';
import 'package:itcall/buttons/add_button.dart';

import 'day_page.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  List<Map<String, dynamic>> _itemsMaps = [
    {"dayNumber": 1,"number": 1},
    {"dayNumber": 2,"number": 1},
    {"dayNumber": 3,"number": 1},
    {"dayNumber": 4,"number": 1},
    {"dayNumber": 5,"number": 1},
    {"dayNumber": 6,"number": 1},
    {"dayNumber": 7,"number": 1},
  ];
/*
  void _createTables() {
    final db = sql.sqlite3.openInMemory();
    db.execute('''
    CREATE TABLE days (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
    CREATE TABLE intakes (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
    CREATE TABLE foods (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
    CREATE TABLE components (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
    CREATE TABLE history (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');



    final stmt = db.prepare('INSERT INTO days (name) VALUES (?)');
    stmt
      ..execute(['The Beatles'])
      ..execute(['Led Zeppelin'])
      ..execute(['The Who'])
      ..execute(['Nirvana']);

    db.execute('''
    ALTER TABLE days
    ADD COLUMN email TEXT;
    ''');

    final stmt3 = db.prepare('INSERT INTO days (email) VALUES (?)');
    stmt3
      ..execute(['makaka'])
      ..execute(['makaka'])
      ..execute(['makaka'])
      ..execute(['makaka']);

    final stmt2 = db.prepare('INSERT INTO intakes (name) VALUES (?)');
    stmt2
      ..execute(['The Beatles'])
      ..execute(['Led Zeppelin'])
      ..execute(['The Who'])
      ..execute(['Nirvana']);

    stmt3.dispose();
    stmt2.dispose();
    stmt.dispose();

    final sql.ResultSet resultSet =
    db.select('SELECT * FROM artists');

    final sql.ResultSet resultSet2 =
    db.select('SELECT * FROM gamers');

    print("first table:$resultSet\nSecond Table: $resultSet2");

  }

  void _test() {
    final db = sql.sqlite3.open("myDB", mode: sql.OpenMode.readWriteCreate);
    db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

    final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
    stmt
      ..execute(['The Beatles'])
      ..execute(['Led Zeppelin'])
      ..execute(['The Who'])
      ..execute(['Nirvana']);

    // Dispose a statement when you don't need it anymore to clean up resources.
    stmt.dispose();

    // You can run select statements with PreparedStatement.select, or directly
    // on the database:
    final sql.ResultSet resultSet =
    db.select('SELECT * FROM artists');

    // You can iterate on the result set in multiple ways to retrieve Row objects
    // one by one.
    for (final sql.Row row in resultSet) {
      print('Artist[id: ${row['id']}, name: ${row['name']}]');
    }
    db.dispose();
  }*/

  void _addDay(dayNum) {
    int _num = _itemsMaps.where((item)=> item["dayNumber"] == dayNum).toList().length + 1;
    setState(() {
      _itemsMaps.add({
        "dayNumber":dayNum,"number":_num
      });
      var _sortedList = _itemsMaps.map((day) => day).toList()
        ..sort((a, b) =>
            a["dayNumber"].compareTo(b["dayNumber"]));
      _itemsMaps = _sortedList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _sortedList = _itemsMaps.map((day) => day).toList()
      ..sort((a, b) =>
          a["dayNumber"].compareTo(b["dayNumber"]));
    _itemsMaps = _sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          title: const Text("Главная", overflow: TextOverflow.ellipsis ,style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 20, bottom: 105),
          itemBuilder: (context, i) {
            return DayCard(key: Key("$i"), dayMap: _itemsMaps[i],);
          },
          itemCount: _itemsMaps.length,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomAddButton(screenContext: context, isWhite: false, onTap: _addDay,),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final Map<String, dynamic> dayMap;
  DayCard({super.key, required this.dayMap});

  final List<Gradient> _backgroundGradients = [
    const LinearGradient(colors: [Color(0xFF6E79DA), Color(0xFF3A4074)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFF6EDA72), Color(0xFF3A743D)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFFBE6EDA), Color(0xFF653A74)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFFDA6E81), Color(0xFF743A45)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFFD1DA6E), Color(0xFF6F743A)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFF6EB9DA), Color(0xFF3A6374)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
    const LinearGradient(colors: [Color(0xFFDABC6E), Color(0xFF74643A)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.25, 1.0]),
  ];

  final List<String> _dayName = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Воскресенье"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DayScreen()));
        },
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: BoxDecoration(
            gradient: _backgroundGradients[dayMap["dayNumber"]-1],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("${_dayName[dayMap["dayNumber"]-1]} - ${dayMap["number"]}", maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: ClipOval(
                  child: Container(
                    height: 30,
                    width: 30,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

