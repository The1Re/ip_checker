import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:ip_checker/model/Device.dart';

class deviceCard extends StatefulWidget {
  const deviceCard({super.key});

  @override
  State<deviceCard> createState() => _deviceCardState();
}

class _deviceCardState extends State<deviceCard> {


  void PingCheck(int index) {
    bool In = false;
    setState(() {
      final ping = Ping(deviceList[index].ip, count: 5);
      ping.stream.listen((event) {
        print(event);
        if (event.error != null && In == false) {
          deviceList[index].setColorstatus(Color.fromRGBO(206, 68, 68, 100));
          deviceList[index].setStatus(false);
          In = true;
        } else if (event.error == null && In == false) {
          deviceList[index].setColorstatus(Color.fromRGBO(64, 230, 171, 100));
          deviceList[index].setStatus(true);
          In = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: deviceList.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if(!deviceList[index].getSelected()){
                deviceList[index].setSelected(true);
              }else{
                deviceList[index].setSelected(false);
              }
            });
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: deviceList[index].colorStatus,
                      blurRadius: 7,
                      offset: Offset(0, 0))
                ]),
            height: deviceList[index].getSelected() ? 100 : 190 ,
            padding: const EdgeInsets.only(left: 10, top: 10),
            margin:
                const EdgeInsets.only(bottom: 20, top: 20, left: 4, right: 4),
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
                          color: deviceList[index].colorStatus,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ],
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:0),
                      child: Text(
                        deviceList[index].nameDeivce,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(deviceList[index].ip,
                        style: TextStyle(fontSize: 20, color: Colors.grey)),
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      deviceList[index].status ? "online" : "offline",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Visibility(
                        visible: deviceList[index].getSelected() ? false : true,
                        child: AnimatedOpacity(
                          opacity: deviceList[index].getSelected() ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 0),
                          child:Row(
                            children: [

                            FilledButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(CircleBorder()),
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(172, 192, 220, 100))),
                            onPressed: () {
                              PingCheck(index);
                            },
                            child: Icon(Icons.edit , size: 20,),
                          ),

                            FilledButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(CircleBorder()),
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(206, 68, 68, 100))),
                            onPressed: () {
                              setState(() {
                                deviceList.removeAt(index);
                              });
                            },
                            child: Text(
                              "X",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          ],)
                          
                        ))
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
