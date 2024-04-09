import 'package:flutter/material.dart';

class CustomWidgets {
  static customTextFormField(
      TextEditingController controller,
      IconData? iconData,
      bool toHide,
      String labeltext,
      String hinttext,
      TextInputType typeKeyboard) {
    return TextFormField(
      controller: controller,
      obscureText: toHide,
      keyboardType: typeKeyboard,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: labeltext,
        hintText: hinttext,
      ),
    );
  }

  static customIconButton(VoidCallback voidCallback, IconData iconData) {
    return IconButton(onPressed: voidCallback, icon: Icon(iconData));
  }

  static customButtonContainer(String text, VoidCallback voidCallback) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  static customAlertDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Warning Pop Up'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(text),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  static customTextButton(VoidCallback voidCallback, String text) {
    return TextButton(
      onPressed: voidCallback,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  static customWelcomeText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.w500),
    );
  }
}
