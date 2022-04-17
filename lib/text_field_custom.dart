import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  late TextEditingController infoController;
  String label;
  String? errorText;

  TextFieldCustom({
    required this.infoController,
    required this.label,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 6),
      child: SizedBox(
        height: 55,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "O campo deve ser preenchido!";
            }
          },
          cursorColor: Colors.white,
          cursorWidth: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          controller: infoController,
          decoration: InputDecoration(
            errorText: errorText,
            fillColor: const Color.fromARGB(123, 158, 158, 158),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: label,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
