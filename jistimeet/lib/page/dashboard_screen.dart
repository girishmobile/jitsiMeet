import 'package:flutter/material.dart';
import 'package:jistimeet/core/component.dart';
import 'package:jistimeet/core/constants/num_constants.dart';
import 'package:jistimeet/core/string_utils.dart';
import 'package:jistimeet/provider/ThemeProvider.dart';
import 'package:jistimeet/provider/meeting_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      //backgroundColor: Colors.white,

      appBar: AppBar(
       // backgroundColor: Colors.white,
        actions: [
          Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              // Toggle the theme based on the switch
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<MeetingProvider>(builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(sixteen),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * zero02,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                          fit: BoxFit.fitWidth,
                          width: size.width * zero6,
                          height: size.height * zero1,
                          icLogo),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: commonText(
                          fontSize: sixteen,
                          top: ten,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                          text: callDesc),
                    ),
                    commonText(top: size.height * zero03),
                    commonTextFiled(
                      hint: enterDisplayName,
                      onChanged: (value) {
                        provider.setDisplayName = value;
                      },
                      controller: provider.tetDisplayName,
                      top: five,
                    ),
                    commonText(top: fifteen, text: emailID),
                    commonTextFiled(
                        onChanged: (value) {
                          provider.setEmail = value;
                        },
                        hint: enterEmailID,
                        controller: provider.tetEmail,
                        top: five),
                    commonText(top: fifteen, text: roomName),
                    commonTextFiled(
                        onChanged: (value) {
                          provider.setRoomName = value;
                        },
                        hint: enterRoomName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return pleaseEnterRoomName;
                          }
                          return null; // return null if the input is valid
                        },
                        controller: provider.tetRoomName,
                        top: five),
                    commonText(top: fifteen, text: subject),
                    commonTextFiled(
                        hint: enterSubject,
                        onChanged: (value) {
                          provider.setSubject = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return pleaseEnterSubject;
                          }
                          return null; // return null if the input is valid
                        },
                        controller: provider.tetSubject,
                        top: five),
                    const SizedBox(height: forty),
                    SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(eight), // <-- Radius
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
                        child: commonText(text: joinMeeting,color: Colors.white),
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
