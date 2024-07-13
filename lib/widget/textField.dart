import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class textField extends StatefulWidget {
  const textField({super.key , required this.widthField});
  final double widthField;
  
  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 209, 209, 209),
                    blurRadius: 25,
                    offset: Offset(0, 0),
                  )
                ]),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            width: widget.widthField,
            height: 43,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    child: TextField(
                  showCursor: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
