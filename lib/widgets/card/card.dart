import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/edit_device.dart';
import 'package:intl/intl.dart';
import 'package:ip_checker/utils/sqlite_helper.dart';

class CardDevice extends StatefulWidget {
  final Device device;
  final Function(Device) deleteDevice;

  const CardDevice(
      {super.key, required this.device, required this.deleteDevice});

  @override
  State<CardDevice> createState() => _CardDeviceState();
}

class _CardDeviceState extends State<CardDevice> {
  bool _showDetail = false;

  @override
  void initState() {
    super.initState();
  }

  void delete(){
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text('Are you sure to remove the device?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await SQLiteHelper().delete(widget.device);
                widget.deleteDevice(widget.device);
                
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

  String getStatus(Status s) {
    switch (s) {
      case Status.online:
      case Status.lowOnline:
        return "Online";
      case Status.offline:
        return "Offline";
      default:
        return "Waiting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDetail = !_showDetail;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: widget.device.status.color,
                  blurRadius: 7,
                  offset: const Offset(0, 0))
            ]),
        height: _showDetail ? 200 : 100,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 20, top: 20, left: 4, right: 4),
        duration: const Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: widget.device.status.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.only(left: 10),
              margin: EdgeInsets.zero,
              child: Wrap(
                children: [
                  // <---- Name device---->
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      // <----Ip address here---->
                      Text(widget.device.ip,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                  //Date & LastOffline & Type
                  Visibility(
                      visible: _showDetail,
                      child: AnimatedOpacity(
                        opacity: _showDetail ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          margin: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Date add: ${DateFormat('dd/MM/yyyy hh:mm a').format(widget.device.dateAdd)}",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              Text(
                                  "Last offline: ${DateFormat('dd/MM/yyyy hh:mm a').format(widget.device.dateAdd)}",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              Text(
                                  "Type: ${widget.device.type.name.toUpperCase()}",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.height * 0.19,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        getStatus(widget.device.status),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                    Visibility(
                        visible: _showDetail,
                        child: AnimatedOpacity(
                            opacity: _showDetail
                                ? 1.0
                                : 0.0, //device.getSelected() ? 0.0 : 1.0
                            duration: const Duration(milliseconds: 0),
                            child: Row(
                              children: [
                                FilledButton(
                                  style: const ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          CircleBorder()),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color.fromRGBO(172, 192, 220, 100))),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => EditDevice(
                                                  device: widget.device,
                                                )));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                                FilledButton(
                                  style: const ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          CircleBorder()),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color.fromRGBO(206, 68, 68, 100))),
                                  onPressed: () {
                                    setState(() {
                                      delete(); //call delete fuction for delete DEVICE
                                    });
                                  },
                                  child: const Text(
                                    "X",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            )))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
