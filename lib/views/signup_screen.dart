import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/login_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      return CustomWidgets.customAlertDialog(context, "Enter Required Fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        );
      } on FirebaseAuthException catch (ex) {
        return CustomWidgets.customAlertDialog(context, ex.code.toString());
      }
    }
  }

  void resetFields() {
    nameController.text = '';
    emailController.text = '';
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screen"),
        centerTitle: true,
        actions: [
          CustomWidgets.customIconButton(() {
            resetFields();
          }, Icons.refresh)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customWelcomeText("Welcome to the SignUp Screen"),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.customTextFormField(nameController, Icons.person,
                  false, "Name", "Enter your name", TextInputType.name),
              const SizedBox(
                height: 15,
              ),
              CustomWidgets.customTextFormField(
                  emailController,
                  Icons.mail,
                  false,
                  "Email",
                  "Enter the email address..",
                  TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              CustomWidgets.customTextFormField(
                  passwordController,
                  Icons.password,
                  true,
                  "Password",
                  "Enter the Password",
                  TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.customButtonContainer(
                "SignUp",
                () {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
