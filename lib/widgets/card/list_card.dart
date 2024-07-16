import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/widgets/card/card.dart';

class ListCardDevice extends StatefulWidget {
  final List<Device> devices;
  final Function(Device) deleteDevice;
  
  const ListCardDevice({super.key, required this.devices, required this.deleteDevice});

  @override
  State<ListCardDevice> createState() => _ListCardDeviceState();
}

class _ListCardDeviceState extends State<ListCardDevice> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.devices.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CardDevice(
          device: widget.devices[index],
          deleteDevice: widget.deleteDevice
        );
      },
    );
  }
}
