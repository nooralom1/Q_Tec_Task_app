
import 'package:flutter/material.dart';

import 'common_widget/background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Q-TEC_TASK_APP",
                  style: TextStyle(color: Color(0xff34A353),fontSize: 25,fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ));
  }
}
