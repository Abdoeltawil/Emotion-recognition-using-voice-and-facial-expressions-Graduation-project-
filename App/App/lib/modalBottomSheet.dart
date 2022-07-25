import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_fonts/google_fonts.dart";
import "previewPage.dart";

class bottomSheet extends StatefulWidget {
  const bottomSheet({Key? key}) : super(key: key);

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Choose From",
                // textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                  color: Colors.black87,
                  fontSize: 24,
                ),
              ),
            ),
            Divider(),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //Record Video
              InkWell(
                onTap: () async {
                  print("gallery");
                  final XFile? file = await _picker.pickVideo(
                    source: ImageSource.camera,
                    // maxDuration: const Duration(seconds: 10)
                  );
                  setState(() {});
                  print("Video Path ${file!.path}");
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return previewPage(file);
                  }));
                  _playVideo(file);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      DecoratedIcon(
                        Icons.camera_alt_outlined,
                        size: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: const Text("Camera"),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(width: MediaQuery.of(context).size.width * .15),

              //Pick from gallery
              InkWell(
                onTap: () async {
                  final XFile? file = await _picker.pickVideo(
                    source: ImageSource.gallery,
                    // maxDuration: const Duration(seconds: 10)
                  );
                  setState(() {});
                  // _playVideo(file);
                  // print("Video Path ${file!.path}");
                  print("Video Path ${file!.path}");
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return previewPage(file);
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      DecoratedIcon(
                        Icons.filter_frames_outlined,
                        size: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: const Text("Gallery"),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

//Copied
  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      print("Loading Video");
      await _disposeVideoController();
      late VideoPlayerController controller;
      /*if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {*/
      controller = VideoPlayerController.file(File(file.path));
      //}
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).

      //await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    } else {
      print("Loading Video error");
    }
  }

  Future<void> _disposeVideoController() async {
    /*  if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;*/
    _controller = null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
