import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({required this.text, required this.onPressed, super.key});

  final VoidCallback onPressed;
  final String text;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff099885),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(child: widget.text.body1),
      ),
    );
  }
}
