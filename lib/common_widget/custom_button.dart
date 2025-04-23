
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key, required this.buttonName, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(


        child: ElevatedButton(onPressed: onPressed,style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo), child: Text(buttonName,style: const TextStyle(color: Colors.white),)));
  }
}