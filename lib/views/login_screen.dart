import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/forgot_password_screen.dart';
import 'package:health_form_app/views/home_screen.dart';
import 'package:health_form_app/views/phone_auth_screen.dart';
import 'package:health_form_app/views/signup_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == "" && password == "") {
      return CustomWidgets.customAlertDialog(context, "Enter Required Fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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
    emailController.text = '';
    passwordController.text = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
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
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidgets.customWelcomeText(
                      "Welcome to the Login Screen"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomWidgets.customTextFormField(
                      emailController,
                      Icons.mail,
                      false,
                      "Email",
                      "Enter the email address..",
                      TextInputType.emailAddress, (value) {
                    if (value.isEmpty ||
                        value.toString().trim() == "" ||
                        !(value.contains('@'))) {
                      return 'Please enter the valid email address';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomWidgets.customTextFormField(
                      passwordController,
                      Icons.password,
                      true,
                      "Password",
                      "Enter the Password",
                      TextInputType.text, (value) {
                    if (value.isEmpty ||
                        value.toString().trim() == "" ||
                        !(value.length > 6)) {
                      return 'Please enter the valid password';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomWidgets.customButtonContainer("Login", () {
                    login(emailController.text.toString(),
                        passwordController.text.toString());
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomWidgets.customTextButton(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  }, "Don't have an Account?"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomWidgets.customTextButton(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  }, "Forgot Password ?"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomWidgets.customTextButton(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhoneAuthScreen(),
                      ),
                    );
                  }, "Login By Phone Number -->"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
