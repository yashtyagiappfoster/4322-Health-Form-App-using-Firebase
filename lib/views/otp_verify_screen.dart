import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/home_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String verificationId;
  const OTPVerifyScreen({super.key, required this.verificationId});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  TextEditingController otpController = TextEditingController();

  verifyOtp(String otp) async {
    if (otp == "") {
      return CustomWidgets.customAlertDialog(context, "Enter required Fields");
    } else {
      try {
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: otp);
        FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        );
      } catch (ex) {
        return CustomWidgets.customAlertDialog(context, ex.toString());
      }
    }
  }

  void resetFields() {
    otpController.text = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification Screen'),
        centerTitle: true,
        actions: [
          CustomWidgets.customIconButton(() {
            resetFields();
          }, Icons.refresh),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidgets.customWelcomeText(
                    "Welcome to the OTP Verification Screen Screen"),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.customTextFormField(
                    otpController,
                    Icons.mail,
                    false,
                    "OTP",
                    "Enter the code",
                    TextInputType.text, (value) {
                  if (value.isEmpty || value.toString().trim() == "") {
                    return 'Please enter the valid disease description';
                  }
                  return null;
                }),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.customButtonContainer("Verify OTP", () {
                  verifyOtp(otpController.text.toString());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
