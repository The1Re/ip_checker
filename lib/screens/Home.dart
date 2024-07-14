import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ip_checker/screens/addDvice.dart';
import 'package:ip_checker/widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Device",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text under header My Device
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
            //search bar
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    width: 350,
                    height: 43,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: TextField(
                          showCursor: false,
                          decoration: InputDecoration(
                              hintText: 'Search your device',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black)),
                        )),
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //All device
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsetsDirectional.only(top: 20),
              height: 490,
              child: deviceCard()
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: CircleBorder(),
        backgroundColor: Color.fromRGBO(101, 138, 190, 100),
        label: Text(
          "+",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Adddvice()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
