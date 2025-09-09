// OTP Input Field Widget
import 'package:flutter/material.dart';

class OTPInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final Function(String)? onCompleted;
  final int length;

  const OTPInputField({
    Key? key,
    required this.controllers,
    this.onCompleted,
    this.length = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (index) {
        return SizedBox(
          width: 50,
          height: 50,
          child: TextFormField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < length - 1) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }

              // Check if all fields are filled
              String otp = controllers.map((c) => c.text).join();
              if (otp.length == length && onCompleted != null) {
                onCompleted!(otp);
              }
            },
          ),
        );
      }),
    );
  }
}
