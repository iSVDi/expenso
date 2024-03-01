import "package:flutter/material.dart";

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
      onPressed: () {
        Navigator.pop(context);
        
      },
      child: Text("go Back"),
    ));
  }
}
