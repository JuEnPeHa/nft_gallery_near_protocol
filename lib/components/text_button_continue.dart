import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButtonContinue extends StatefulWidget {
  var fetch;
   CustomTextButtonContinue({Key? key, required this.fetch})
      : super(key: key);

  @override
  State<CustomTextButtonContinue> createState() =>
      _CustomTextButtonContinueState();
}

class _CustomTextButtonContinueState extends State<CustomTextButtonContinue> {
  bool _isButtonEnabled = true;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        if (_isButtonEnabled) {
          setState(() {
            _isButtonEnabled = false;
          });
          widget.fetch;
        }
      },
      icon: Icon(
        Icons.arrow_forward,
        color: _isButtonEnabled ? Colors.green : Colors.grey,
      ),
      label: _isButtonEnabled
          ? const Text(
              "Continuar",
              style: TextStyle(color: Colors.green, fontSize: 18),
            )
          : const Text("Cargando...",
              style: TextStyle(color: Colors.grey, fontSize: 18)),
    );
  }
}
