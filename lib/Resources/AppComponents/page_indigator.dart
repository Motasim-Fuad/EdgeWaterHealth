// First, create a reusable page indicator widget
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    Key? key,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
            (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 60 : 60,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? const Color(0xFF057891)
                : const Color(0xFFF8F8F8).withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}