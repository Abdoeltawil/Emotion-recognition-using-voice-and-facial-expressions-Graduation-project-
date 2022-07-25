import 'dart:convert';
import 'dart:io';
import 'functions.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "package:video_player/video_player.dart";
import "package:google_fonts/google_fonts.dart";
import 'Home.dart';

class previewPage extends StatefulWidget {
  XFile? file;
  // const PreviewPage({Key? key}) : super(key: key);
  previewPage(this.file);

  @override
  _previewPageState createState() => _previewPageState();
}

class _previewPageState extends State<previewPage> {
  bool notTapped = true;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file!.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  String url = '';
  var data;

  @override
  Widget build(BuildContext context) {
    print("Hello");
    // el path hena " widget.file!.path "
    print("The file path inside the Preview Page Widget: ${widget.file!.path}");
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                children: [
                  //Text at Top
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Preview: ",
                      style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  //End Text at top
                  Card(
                    elevation: 10,
                    color: Colors.transparent,
                    child: _controller!.value.isInitialized
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              height: MediaQuery.of(context).size.height * .55,
                              child: AspectRatio(
                                // aspectRatio: 16 / 22,
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                            ),
                          )
                        : Container(),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("Play/Pause",
                            style: GoogleFonts.lato(
                              color: Colors.black87,
                              fontSize: 12,
                            )),
                      ),
                      SizedBox(width: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _controller!.value.isPlaying
                                  ? _controller!.pause()
                                  : _controller!.play();
                            });
                          },
                          child: Center(
                            child: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // const Text("Submit This Video?",
            //     style: GoogleFonts.lato(
            //       fontSize: 28,
            //     )),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .1,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: InkWell(
                  onTap: () async {

                    setState(() {
                      notTapped = !notTapped;

                    });

                    var decoded = await upload_file(widget.file!.path, widget.file!.name);
                    print("finished");
                    print(decoded['output']);
                    Widget continueButton = FlatButton(
                      child: Text("Continue"),
                      onPressed:  () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Results"),
                      content: Text("Your mood now is: " + decoded['output']),
                      actions: [
                        continueButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );



                  },
                  child: notTapped == true
                      ? Center(
                          child: Text("Submit",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 24)))
                      : Center(
                          child: Text("Submitting...",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 24))),

                  // color: Colors.white,
                ),
              ),
            ),

            //Submit Text Widget
          ],
        ),
      ),
    );
  }
}
