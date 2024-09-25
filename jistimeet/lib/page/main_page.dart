import 'package:flutter/material.dart';
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
    // Request camera and microphone permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera]?.isDenied ?? true) {
      // Permissions are denied, show a dialog or error
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
        room: "jitsiIsAwesomeWithFlutter",
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
          "subject": subjectText,
        },
        featureFlags: {"unsaferoomwarning.enabled": false},
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: commonText(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
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

  commonText(
      {String? text,
      double? top,
      TextAlign? textAlign,
      double? fontSize,
      FontWeight? fontWeight}) {
    return Container(
        margin: EdgeInsets.only(top: top ?? 0),
        child: Text(
          textAlign: textAlign,
          text ?? 'Display Name',
          style: TextStyle(
              color: Colors.black,
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w400),
        ));
  }

  commonTextFiled(
      {TextEditingController? controller,
      String? hint,
      double? top,
      String? Function(String?)? validator}) {
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      child: TextFormField(
        validator: validator,
        style: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        controller: controller,
        decoration: InputDecoration(
          //  labelText: hint??"Room Name",
          filled: true,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          hintText: hint,
          // <-- add filled
          fillColor: Colors.white,
          // <--- and this

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.20),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.20),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.20),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
