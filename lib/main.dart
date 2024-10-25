import 'package:flutter/material.dart';

import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashActivity(),
    );
  }
}

class SplashActivity extends StatefulWidget {
  const SplashActivity({super.key});

  @override
  State<SplashActivity> createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {

  final   List _allAsset = [
    "assets/images/addintake.png",
    "assets/images/obed.png",
    "assets/images/perekys.png",
    "assets/images/poldnik.png",
    "assets/images/yjin.png",
    "assets/images/zavtrak.png",
    "assets/images/noimage.png",
  ];

  Future _checkLaunch() async {
    for(var asset in _allAsset)
    {
      await precacheImage(AssetImage(asset), context);
    }
    _navigateToMain();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _checkLaunch();
    });
  }

  void _navigateToMain() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MainActivity()));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
