import 'package:flutter/material.dart';
import 'package:jistimeet/core/component.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final displayName = TextEditingController();
  final email = TextEditingController();
  final roomController = TextEditingController();
  final subjectController = TextEditingController();

  @override
  void dispose() {
    roomController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera]?.isDenied ?? true) {
      _showPermissionError();
    }
  }

  void _showPermissionError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Permissions Required"),
          content: const Text(
              "Camera and Microphone permissions are required to join a meeting."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _joinMeeting() async {
    await _requestPermissions();
    String roomName = roomController.text;
    String subjectText = subjectController.text;

    if (roomName.isEmpty) {
      return;
    }

    try {
      var jitsiMeet = JitsiMeet();

      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: "jitsiIsRedefineSolutions",

        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
          "subject": subjectText,
        },

        featureFlags: {

          "unsaferoomwarning.enabled": true,
          "security-options.enabled": false,

        },
        userInfo: JitsiMeetUserInfo(
            displayName: displayName.text.isEmpty ? "Test" : displayName.text,
            email: email.text.isEmpty ? "test@gmail.com" : email.text),
      );
      jitsiMeet.join(options);

      // await JitsiMeetFlutterSdk.joinMeeting(options);
    } catch (error) {
      debugPrint("-------Error: $error");
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      fit: BoxFit.fitWidth,
                      width: size.width*0.6,height: size.height*0.1,
                        "assets/icons/ic_logo.png"
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: commonText(
                        fontSize: 16,
                        top: 10,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        text:
                            "This Room name will identify your video call room.\nIt should be unique and relevant to your discussion topic."),
                  ),
                  commonText(top: size.height * 0.03),
                  commonTextFiled(
                    hint: "Enter display name",
                    controller: displayName,
                    top: 5,
                  ),
                  commonText(top: 15, text: "Email ID"),
                  commonTextFiled(
                      hint: "Enter email id", controller: email, top: 5),
                  commonText(top: 15, text: "Room Name"),
                  commonTextFiled(
                      hint: "Enter room name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter room name';
                        }
                        return null; // return null if the input is valid
                      },
                      controller: roomController,
                      top: 5),
                  commonText(top: 15, text: "Subject"),
                  commonTextFiled(
                      hint: "Enter subject",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter subject';
                        }
                        return null; // return null if the input is valid
                      },
                      controller: subjectController,
                      top: 5),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        backgroundColor: Colors.blue, // background
                        foregroundColor: Colors.white, // foreground
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          _joinMeeting();


                        }
                      },
                      child: const Text("Join Meeting"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
