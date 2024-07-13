import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ip_checker/model/Device.dart';
import 'package:ip_checker/screens/addDvice.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;

  void PingCheck(int index){
    bool In = false;
    setState(() {
      final ping = Ping(data[index].ip,count: 5);
      ping.stream.listen((event) {
        print(event);
        if(event.error != null && In == false){
          data[index].setColorstatus(Color.fromRGBO(206, 68, 68, 100));
          data[index].setStatus(false);
          In = true;
        }else if(event.error == null && In == false){
          data[index].setColorstatus(Color.fromRGBO(64, 230, 171, 100));
          data[index].setStatus(true);
          In = true;
        }
      }
    );});
  }

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
              height: 690,
              child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });
                    },
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: data[index].colorStatus,
                                blurRadius: 7,
                                offset: Offset(0, 0))
                          ]),
                      height: selected ? 100 : 190,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      margin: const EdgeInsets.only(
                          bottom: 20, top: 20, left: 4, right: 4),
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 5),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: data[index].colorStatus,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 140),
                                child: Text(
                                  data[index].nameDeivce,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(data[index].ip,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                            ],
                          ),
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data[index].status ? "online" : "offline" ,style: TextStyle(fontSize: 20, color: Colors.grey),),
                              Visibility(
                                  visible: selected ? false : true,
                                  child: AnimatedOpacity(
                                    opacity: selected ? 0.0 : 1.0,
                                    duration: const Duration(milliseconds: 0),
                                    child: FilledButton(
                                      style: ButtonStyle(
                                          shape: WidgetStatePropertyAll(
                                              CircleBorder()),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Color.fromRGBO(
                                                      206, 68, 68, 100))),
                                      onPressed: () {
                                        PingCheck(index);
                                      },
                                      child: Text(
                                        "X",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
              .push(MaterialPageRoute(builder: (context) => Adddvice()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


