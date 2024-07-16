import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/Home.dart';
import 'package:ip_checker/widgets/text_field.dart';

class EditDevice extends StatefulWidget {
  EditDevice({super.key,required this.device});

  final Device device;
  late final MyTextField nameDevice , ipAddress ;

  @override
  State<EditDevice> createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.nameDevice = MyTextField(widthField: 0.95,text: widget.device.name,);
    widget.ipAddress = MyTextField(widthField: 0.95,text: widget.device.ip,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Device",
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
                  "Configure your new device.",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Name device",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(37, 37, 37, 0.612)),
                      ),
                    ),
                    widget.nameDevice,
                  ],
                ),
                //ip address , Port
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Ip address",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(37, 37, 37, 0.612)),
                      ),
                    ),
                    widget.ipAddress,
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
                    Container(
                        width: 110,
                        child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(159, 173, 192, 100))),
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
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(101, 138, 190, 0.644))),
                          onPressed: () {
                            if (widget.nameDevice.textController.text != "" &&
                                  widget.ipAddress.textController.text != "") {


                                // <----Update data to database here---->


                                widget.device.name = widget.nameDevice.textController.text;
                                widget.device.ip = widget.ipAddress.textController.text;

                                
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        "Please provide all the necessary details.",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "OK",
                                              style: TextStyle(fontSize: 15),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              }
                          },
                          child: Text("SAVE",
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