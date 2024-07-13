import 'package:flutter/material.dart';

class Adddvice extends StatefulWidget {
  const Adddvice({super.key});

  @override
  State<Adddvice> createState() => _AdddviceState();
}

class _AdddviceState extends State<Adddvice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add device",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
      ),
    );
  }
}