import 'dart:convert';
import 'result.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import "package:dot_navigation_bar/dot_navigation_bar.dart";
import "homeScreenWidget.dart";
import "previewPage.dart";
import "cameraWidget.dart";
import 'package:flutter/material.dart';
import 'package:untitled/functions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}): super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

enum _SelectedTab { home, analysis, user }

class _HomeState extends State<Home> {

  var _selectedTab = _SelectedTab.home;
  List<Widget> pages = [HomeScreenWidget(), Scaffold(), ResultWidget()];
  var _selectedPage;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      _selectedPage = pages[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Video Emotion Detection"),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      // ),
      extendBody: true,
      body: _selectedPage == null ? pages[0] : _selectedPage,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: const Color(0xFFFFFFFF),
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Color.fromARGB(80, 221, 221, 221),
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Colors.blue,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.analytics),
              selectedColor: Color.fromARGB(255, 253, 51, 68),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.supervised_user_circle),
              selectedColor: Color.fromARGB(255, 207, 104, 238),
            ),
          ],
        ),
      ),
    );
  }
}