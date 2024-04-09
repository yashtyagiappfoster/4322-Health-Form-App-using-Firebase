import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/otp_verify_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();

  phoneAuth(String phoneno) async {
    if (phoneno == "") {
      return CustomWidgets.customAlertDialog(context, "Enter required Fields");
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException ex) {
            CustomWidgets.customAlertDialog(context, ex.code.toString());
          },
          codeSent: (String verificationId, int? resetToken) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OTPVerifyScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          phoneNumber: phoneno);
    }
  }

  void resetFields() {
    phoneController.text = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication Screen'),
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
                    "Welcome to the Phone Authentication Screen"),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.customTextFormField(
                    phoneController,
                    Icons.mail,
                    false,
                    "Phone no.",
                    "Enter your phone no. with country code",
                    TextInputType.number, (value) {
                  if (value.isEmpty || value.toString().trim() == "") {
                    return 'Please enter the valid mobile no.';
                  }
                  return null;
                }),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.customButtonContainer("Get OTP", () {
                  phoneAuth(phoneController.text.toString());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
