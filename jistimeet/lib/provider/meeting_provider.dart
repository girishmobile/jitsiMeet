import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

class MeetingProvider with ChangeNotifier {
  String _roomName = '';
  String _subject = '';
  String _displayName = '';
  String _email = '';
  final tetDisplayName = TextEditingController();
  final tetEmail = TextEditingController();
  final tetRoomName = TextEditingController();
  final tetSubject = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Getters display name
  String get displayName => _displayName;
  // Getters email
  String get email => _email;
  // Getters room name
  String get roomName => _roomName;
  // Getters subject
  String get subject => _subject;

  set setDisplayName(String value) {
    _displayName = value;
    notifyListeners();
  }

  set setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  // Setters
  set setRoomName(String value) {
    _roomName = value;
    notifyListeners();
  }

  set setSubject(String value) {
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

  joinMeeting() async {
    await requestPermissions();
    String roomName = _roomName;
    String subjectText = _subject;


    if (roomName.isEmpty) {
      return;
    }

    try {
      
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        //serverURL: "https://meet.jit.si",
        serverURL: "https://meet.jit.si/jitsiIsRedefineSolutions#config.enableLobby=false&config.requireDisplayName=false&config.disableModerator=true",
        room: "jitsiIsRedefineSolutions",
            configOverrides: {
              "requireDisplayName": false,

          "startWithAudioMuted": false,
              "disableModeratorIndicator": false,
          "startWithVideoMuted": false,
          "subject": subjectText,
        },
        featureFlags: {
          "unsaferoomwarning.enabled": true,
          "security-options.enabled": false,
          "meeting-password.enabled": false,
        },
        userInfo: JitsiMeetUserInfo(
            displayName: _displayName.isEmpty ? "Test" : _displayName,
            email: _email.isEmpty ? "test@gmail.com" : _email),
      );
      jitsiMeet.join(options);
    } catch (error) {
      debugPrint("-------Error: $error");
    }
  }
}
