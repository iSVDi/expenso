import "package:flutter/material.dart";

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("go Back"),
    ));
  }
}
