import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/login_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  forgotPassword(String email) async {
    if (email == "") {
      return CustomWidgets.customAlertDialog(context, "Enter Required Fields");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
        (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
      );
    }
  }

  void resetFields() {
    emailController.text = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        actions: [
          CustomWidgets.customIconButton(() {
            resetFields();
          }, Icons.refresh),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customWelcomeText(
                "Welcome to the Forgot Password Screen"),
            const SizedBox(
              height: 20,
            ),
            CustomWidgets.customTextFormField(
                emailController,
                Icons.mail,
                false,
                "Email",
                "Enter the email address..",
                TextInputType.emailAddress),
            const SizedBox(
              height: 20,
            ),
            CustomWidgets.customButtonContainer("Get new Password", () {
              forgotPassword(emailController.text.toString());
            }),
          ],
        ),
      )),
    );
  }
}
