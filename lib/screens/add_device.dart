import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/home.dart';
import 'package:ip_checker/utils/sqlite_helper.dart';
import 'package:ip_checker/widgets/text_field.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  late MyTextField nameDevice, ipAddress;

  @override
  void initState() {
    super.initState();
    nameDevice = MyTextField(
      widthField: 0.95,
      text: "",
    );
    ipAddress = MyTextField(
      widthField: 0.95,
      text: "",
    );
  }

  void add() {
    if (nameDevice.textController.text != "" &&
        ipAddress.textController.text != "") {
      Device device = Device(
          name: nameDevice.textController.text,
          ip: ipAddress.textController.text,
          status: false,
          dateAdd: DateTime.now(),
          lastOffline: DateTime.now());
      SQLiteHelper().insert(device);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Device",
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
                  "Check the condition of the equipment.",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
                )
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
                    Row(
                      children: [
                        //ip address
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ip address",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(37, 37, 37, 0.612)),
                              ),
                              ipAddress,
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
                                    builder: (context) => HomePage()));
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
                            add();
                              //<---- Insert data to database here ---->
                          },
                          child: const Text("ADD",
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
