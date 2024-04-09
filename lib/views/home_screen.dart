import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_form_app/views/login_screen.dart';
import 'package:health_form_app/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? valueChoose;
  List genders = ["Male", "Female", "other"];
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController diseaseDescriptionController = TextEditingController();

  addData(String firstName, String lastName, String age, String phoneNo,
      String email, String disease, String gender) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(firstName).set({
        "name": "$firstName $lastName",
        "email": email,
        "phone no": phoneNo,
        "age": age,
        "disease": disease,
        "gender": gender,
      }).then((value) {
        return CustomWidgets.customAlertDialog(context, "Form Submitted");
      }).then((value) {
        resetFields();
      });
    } catch (ex) {
      return CustomWidgets.customAlertDialog(context, ex.toString());
    }
  }

  logout() async {
    FirebaseAuth.instance.signOut().then(
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

  void resetFields() {
    firstNameController.text = '';
    lastNameController.text = '';
    ageController.text = '';
    phoneNoController.text = '';
    emailController.text = '';
    diseaseDescriptionController.text = '';
    _formKey = GlobalKey<FormState>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Health Form'),
        centerTitle: true,
        actions: [
          CustomWidgets.customIconButton(() {
            logout();
          }, Icons.logout),
          CustomWidgets.customIconButton(() {
            resetFields();
          }, Icons.refresh),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomWidgets.customWelcomeText(
                          "Welcome to the Heath Form Screen"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomWidgets.customTextFormField(
                          firstNameController,
                          Icons.person,
                          false,
                          "First Name",
                          "Enter your First Name",
                          TextInputType.name, (value) {
                        if (value.isEmpty || value.toString().trim() == "") {
                          return 'Please enter the valid name';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomWidgets.customTextFormField(
                          lastNameController,
                          Icons.person,
                          false,
                          "Last Name",
                          "Enter your Last Name",
                          TextInputType.name, (value) {
                        if (value.isEmpty || value.toString().trim() == "") {
                          return 'Please enter the valid name';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomWidgets.customTextFormField(
                          emailController,
                          Icons.mail,
                          false,
                          "Email",
                          "Enter your email address",
                          TextInputType.emailAddress, (value) {
                        if (value.isEmpty ||
                            value.toString().trim() == "" ||
                            !(value.contains('@'))) {
                          return 'Please enter the valid email address';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomWidgets.customTextFormField(
                          phoneNoController,
                          Icons.phone,
                          false,
                          "Mobile No.",
                          "Enter your mobile no.",
                          TextInputType.phone, (value) {
                        if (value.isEmpty ||
                            value.toString().trim() == "" ||
                            !(value.length == 10)) {
                          return 'Please enter the valid mobile no.';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomWidgets.customTextFormField(
                          ageController,
                          Icons.numbers,
                          false,
                          "Age",
                          "Enter your age",
                          TextInputType.number, (value) {
                        if (value.isEmpty ||
                            value.toString().trim() == "" ||
                            (value.length > 2)) {
                          return 'Please enter the valid age';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          hint: const Text("Select Gender"),
                          dropdownColor: Colors.grey,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          iconSize: 30,
                          value: valueChoose,
                          items: genders.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem, child: Text(valueItem));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue.toString();
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomWidgets.customTextFormField(
                          diseaseDescriptionController,
                          Icons.text_fields,
                          false,
                          "Disease Description",
                          "Enter your disease Description here..",
                          TextInputType.multiline, (value) {
                        if (value.isEmpty || value.toString().trim() == "") {
                          return 'Please enter the valid disease description';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomWidgets.customButtonContainer(
                        "Submit Form",
                        () {
                          if (_formKey.currentState!.validate()) {
                            addData(
                                firstNameController.text.toString(),
                                lastNameController.text.toString(),
                                ageController.text.toString(),
                                phoneNoController.text.toString(),
                                emailController.text.toString(),
                                diseaseDescriptionController.text.toString(),
                                valueChoose!);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
