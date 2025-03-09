import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Color _buttonColor = Colors.white;
  Color _textColor = Colors.red;

  bool _pressed = false;

  void _onPressed() {
    if (_pressed) return;

    setState(() {
      _buttonColor = Colors.red;
      _textColor = Colors.white;
      _pressed = true;
    });

    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          _buttonColor = Colors.white;
          _textColor = Colors.red;
          _pressed = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Stream Widgets!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: _onPressed,
                color: _buttonColor,
                child: Text(
                  ':)',
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
