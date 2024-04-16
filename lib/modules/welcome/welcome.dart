import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final datas = [
    "slide 1",
    "slide 2",
    "slide 3",
    "slide 4",
    "slide 5",
    "slide 6",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("welcome widget"),
      ),
    );
  }
}
