import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:line_icons/line_icons.dart';

import "cameraWidget.dart";
import "modalBottomSheet.dart";

void selectPage(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return VideoCapture();
  }));
}

void startNewTransactionModal(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      elevation: 7,
      builder: (_) {
        return Container(
            height: MediaQuery.of(ctx).size.height * .25, child: bottomSheet());
      });
}

Widget cardBox(
    IconData icon, String txt, Color clr, var func, BuildContext ctx) {
  return GestureDetector(
    onTap: () {
      startNewTransactionModal(ctx);
      print("Gesture Clicked Outsider");
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          startNewTransactionModal(ctx);
          print("Gesture Clicked Inside One");
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            Text(
              txt,
              style: GoogleFonts.charm(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ]),
        ),
      ),
    ),
  );
  //End Box One;
}

class HomeScreenWidget extends StatelessWidget {
  // const HomeScreenWidget({Key? key}) : super(key: key);
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome,",
              style: GoogleFonts.lato(
                color: Color.fromARGB(255, 155, 155, 155),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mazen Mohamed",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 60),
          cardBox(LineIcons.video, "Video & Audio",
              Color.fromARGB(255, 51, 155, 253), null, context),
          SizedBox(height: 30),
          cardBox(LineIcons.smilingFace, "Video Only",
              Color.fromARGB(255, 253, 51, 68), null, context),
          SizedBox(height: 30),
          cardBox(LineIcons.audioFile, "Audio Only",
              Color.fromARGB(255, 207, 104, 238), null, context),
        ]),
      ),
    );
  }
}
