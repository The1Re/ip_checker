import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';

class SearchDeviceBar extends StatefulWidget {
  final List<Device> devices;
  final void Function(List<Device>) callback; //ไว้ส่งค่ากลับไปยังที่เรียก widget นี้

  const SearchDeviceBar(
      {super.key, required this.devices, required this.callback});

  @override
  State<SearchDeviceBar> createState() => _SearchDeviceBarState();
}

class _SearchDeviceBarState extends State<SearchDeviceBar> {
  final TextEditingController _searchController = TextEditingController();
  List<Device> _filteredDevices = [];

  @override
  void initState() {
    super.initState();
    _filteredDevices = widget.devices;
    _searchController.addListener(() => filterDevices());
  }

  void filterDevices() {
    String input = _searchController.text;
    setState(() {
      _filteredDevices = widget.devices.where((device) => device.name.contains(input)).toList();
    });

    widget.callback(_filteredDevices); //ส่งค่ากลับไปยังที่เรียก widget นี้
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 209, 209, 209),
              blurRadius: 25,
              offset: Offset(0, 0),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: 350,
      height: 43,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search your device',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black)
                ),
            )
          ),
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
        ],
      ),
    );
  }
}
