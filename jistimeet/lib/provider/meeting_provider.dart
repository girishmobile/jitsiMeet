import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

class MeetingProvider with ChangeNotifier {
  String _roomName = '';
  String _subject = '';

  // Getters
  String get roomName => _roomName;

  String get subject => _subject;

  // Setters
  void setRoomName(String value) {
    _roomName = value;
    notifyListeners();
  }

  void setSubject(String value) {
    _subject = value;
    notifyListeners();
  }

  // Method to request permissions
  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera]?.isDenied ?? true) {
      throw Exception("Permissions Denied");
    }
  }

  joinMeeting(
      {required TextEditingController roomController, required TextEditingController subjectController, required TextEditingController displayName, required TextEditingController email }) async {
    await requestPermissions();
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
}
