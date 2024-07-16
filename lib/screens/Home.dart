import 'package:flutter/material.dart';
import 'package:ip_checker/model/device.dart';
import 'package:ip_checker/screens/add_device.dart';
import 'package:ip_checker/widgets/card/list_card.dart';
import 'package:ip_checker/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device> _devices = [];
  List<Device> _filteredDevices = [];

  @override
  void initState() {
    //fetch data
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      // _devices = await fetchDeviceData();
      _devices = deviceList;
      _filteredDevices = deviceList; 
    });
  }

  void updateFilteredDevices(List<Device> devices) {
    setState(() {
      _filteredDevices = devices;
    });
  }

  void deleteDevice(Device device) {
    setState(() {
      _devices.remove(device);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
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
            //search bar
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: SearchDeviceBar(devices: _devices, callback: updateFilteredDevices)
            ),
            //All device
            _filteredDevices.isNotEmpty ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsetsDirectional.only(top: 20),
              height: MediaQuery.of(context).size.height*0.65,
              child: ListCardDevice(
                devices: _filteredDevices,
                deleteDevice: deleteDevice
              )
            ) : Container(
              child: const Text("No device"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(101, 138, 190, 100),
        label: const Text(
          "+",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator
            .of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => AddDevice()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
