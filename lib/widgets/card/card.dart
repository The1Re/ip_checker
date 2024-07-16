import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/edit_device.dart';

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
    ping(widget.device);
  }

  void ping(Device device) {
    bool visited = false;

    final ping = Ping(device.ip, count: 5);
    ping.stream.listen((event) {
      if (visited) return;
      setState(() {
        if (event.response?.ttl != null) {
          device.setColorstatus(ONLINE);
          device.setStatus(true);
        } else {
          device.setColorstatus(OFFLINE);
          device.setStatus(false);
        }
      });
      visited = true;
    });
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
                  color: widget.device.colorStatus,
                  blurRadius: 7,
                  offset: const Offset(0, 0))
            ]),
        height: _showDetail ? 190 : 100,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 20, top: 20, left: 4, right: 4),
        duration: const Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //bug!
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: widget.device.colorStatus,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    widget.device.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(widget.device.ip,
                    style: const TextStyle(fontSize: 20, color: Colors.grey)),
              ],
            ),
            Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        widget.device.status ? "online" : "offline",
                        style: const TextStyle(fontSize: 20, color: Colors.grey),
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
                                      widget.deleteDevice(widget.device);
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
