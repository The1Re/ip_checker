import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final double widthField;
  late final TextEditingController textController;
  final String text;
  MyTextField({super.key , required this.widthField , required this.text});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.textController = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 209, 209, 209),
                    blurRadius: 25,
                    offset: Offset(0, 0),
                  )
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width*widget.widthField,
            height: 43,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
