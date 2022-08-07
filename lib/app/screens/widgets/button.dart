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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[100] ?? Colors.black,
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(child: widget.text.body1),
        ),
      ),
    );
  }
}
