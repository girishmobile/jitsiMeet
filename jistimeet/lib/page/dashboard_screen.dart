import 'package:flutter/material.dart';
import 'package:jistimeet/core/component.dart';
import 'package:jistimeet/provider/meeting_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MeetingProvider>(builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
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
                      height: size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                          fit: BoxFit.fitWidth,
                          width: size.width * 0.6,
                          height: size.height * 0.1,
                          "assets/icons/ic_logo.png"),
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
                      onChanged: (value) {
                        provider.setDisplayName=value;
                      },
                      controller: provider.tetDisplayName,
                      top: 5,
                    ),
                    commonText(top: 15, text: "Email ID"),
                    commonTextFiled(
                        onChanged: (value) {
                          provider.setEmail=value;
                        },
                        hint: "Enter email id",
                        controller: provider.tetEmail,
                        top: 5),
                    commonText(top: 15, text: "Room Name"),
                    commonTextFiled(
                        onChanged: (value) {
                          provider.setRoomName=value;
                        },
                        hint: "Enter room name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter room name';
                          }
                          return null; // return null if the input is valid
                        },
                        controller: provider.tetRoomName,
                        top: 5),
                    commonText(top: 15, text: "Subject"),
                    commonTextFiled(
                        hint: "Enter subject",
                        onChanged: (value) {
                          provider.setSubject=value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject';
                          }
                          return null; // return null if the input is valid
                        },
                        controller: provider.tetSubject,
                        top: 5),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // <-- Radius
                          ),
                          backgroundColor: Colors.blue, // background
                          foregroundColor: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          if (provider.formKey.currentState!.validate()) {
                            provider.formKey.currentState?.save();
                            await provider.joinMeeting();
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
        );
      }),
    );
  }
}
