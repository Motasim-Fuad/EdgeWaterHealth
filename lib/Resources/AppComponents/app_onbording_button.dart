import 'package:flutter/material.dart';

class OnbordingBtn extends StatelessWidget {
  final bool isForward; // true = forward, false = back
  final VoidCallback onTap;
  final String? text; // 👈 optional text

  const OnbordingBtn({
    Key? key,
    required this.isForward,
    required this.onTap,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 56,
        width: text == null ? 56 : 120,
        decoration: BoxDecoration(
          color: const Color(0xFF2787A5), // button color
          borderRadius: BorderRadius.circular(12),
        ),
        child: text == null
            ? Center( // 👉 only icon, centered
          child: Icon(
            isForward ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 20,
          ),
        )
            : Row( // 👉 text + icon
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isForward) ...[
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isForward) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
