import 'package:flutter/material.dart';
import 'package:ip_checker/screens/Home.dart';
import 'package:ip_checker/widget/textField.dart';

class Adddvice extends StatefulWidget {
  const Adddvice({super.key});

  @override
  State<Adddvice> createState() => _AdddviceState();
}

class _AdddviceState extends State<Adddvice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Device",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //Text add new device
          Container(
            padding: EdgeInsets.only(left: 5),
            //margin: EdgeInsets.zero,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Check the condition of the equipment.",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
                )
              ],
            ),
          ),
          //Text field
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                //name device
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 27),
                      child: Text(
                        "Name device",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(37, 37, 37, 0.612)),
                      ),
                    ),
                    textField(widthField: 350.0)
                  ],
                ),
                //ip address , Port
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //ip address
                        Container(
                          padding: EdgeInsets.only(left: 27),
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ip address",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(37, 37, 37, 0.612)),
                              ),
                              textField(widthField: 240.0)
                            ],
                          ),
                        ),
                        //Port
                        Container(
                          padding: EdgeInsets.only(left: 27),
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Port",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(37, 37, 37, 0.612)),
                              ),
                              textField(widthField: 90.0)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          //Button Add & Close
          Container(
              height: 570,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 110,
                          child: FilledButton(
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(159, 173, 192, 100))),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Text(
                              "CANCEL",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        width: 100,
                      ),
                      Container(
                          width: 110,
                          child: FilledButton(
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(101, 138, 190, 0.644))),
                            onPressed: () {},
                            child: Text("ADD",
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              )
            )
        ],
      ),
    );
  }
}
