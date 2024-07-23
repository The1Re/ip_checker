import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/home.dart';
import 'package:ip_checker/utils/sqlite_helper.dart';
import 'package:ip_checker/widgets/text_field.dart';

class EditDevice extends StatefulWidget {
  final Device device;

  const EditDevice({super.key, required this.device});

  @override
  State<EditDevice> createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  late MyTextField nameDevice, ipAddress;

  Color selectICMP = Color.fromRGBO(101, 138, 190, 0.644);
  Color selectHTTP = Color.fromRGBO(159, 173, 192, 100);
  String selected = "ICMP"; //Del when device have Type varible.....

  @override
  void initState() {
    super.initState();
    nameDevice = MyTextField(
      widthField: 0.95,
      text: widget.device.name,
    );
    ipAddress = MyTextField(
      widthField: 0.95,
      text: widget.device.ip,
    );
  }

  void edit() async {
    if (nameDevice.textController.text != "" &&
        ipAddress.textController.text != "") {
      if (await SQLiteHelper().isExist(nameDevice.textController.text)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                "This name has already used",
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              // title: const Text(''),
              content: const Text('Are you sure?',
              style: TextStyle(fontSize: 30),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Device update = Device(
                        name: nameDevice.textController.text,
                        ip: ipAddress.textController.text,
                        dateAdd: DateTime.now(),
                        lastOffline: DateTime.now());
                    await SQLiteHelper().update(widget.device.name, update);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              "Please provide all the necessary details.",
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          );
        },
      );
    }
  }

  void selectedICMP(){
    setState(() {
      selected = "ICMP";
      selectICMP = Color.fromRGBO(101, 138, 190, 0.644);
      selectHTTP = Color.fromRGBO(159, 173, 192, 100);
    });
  }

  void selectedHTTP(){
    setState(() {
      selected = "HTTP";
      selectICMP = Color.fromRGBO(159, 173, 192, 100);
      selectHTTP = Color.fromRGBO(101, 138, 190, 0.644);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Device",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //Text add new device
          Container(
            padding: const EdgeInsets.only(left: 5),
            //margin: EdgeInsets.zero,
            width: 400,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Configure your new device.",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
                )
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(selectICMP),

                  ),
                  onPressed: (){
                    selectedICMP();
                  }, 
                child: const Text("  ICMP  "))
                ,
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(selectHTTP),
                    
                  ),
                  onPressed: (){
                    selectedHTTP();
                  }, 
                child: const Text("  HTTP  "))
              ],
            ),
          ),


          //Text field
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                //name device

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Name device",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(37, 37, 37, 0.612)),
                      ),
                    ),
                    nameDevice,
                  ],
                ),
                //ip address , Port
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Ip address",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(37, 37, 37, 0.612)),
                      ),
                    ),
                    ipAddress,
                  ],
                ),
              ],
            ),
          ),
          //Button Add & Close
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 110,
                        child: FilledButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(159, 173, 192, 100))),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      width: 100,
                    ),
                    SizedBox(
                        width: 110,
                        child: FilledButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(101, 138, 190, 0.644))),
                          onPressed: () {
                            edit(); //call edit fuction for edit device
                          },
                          child: const Text("SAVE",
                              style: TextStyle(color: Colors.white)),
                        )),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
