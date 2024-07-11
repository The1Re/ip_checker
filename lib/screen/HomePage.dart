import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Color blue = Color.fromRGBO(75, 116, 173, 0.612);
Color light_purple = Color.fromRGBO(163, 147, 209, 100);
Color dark_purple = Color.fromRGBO(144,111, 241, 100);
Color green_online = Color.fromRGBO(0,255,163, 100);
Color red_offline = Color.fromRGBO(255,0,92, 100);

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
        
        
            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  margin: EdgeInsets.all(0),
                  child: Text("My Device",style: TextStyle(fontSize: 36 , fontWeight: FontWeight.bold),),),
            ],),

            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                  margin: EdgeInsets.all(0),
                child: Text("Check the condition of the equipment",style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 105, 105, 105)),),),
            ],),
        
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(
                width: 380,
                padding: EdgeInsets.fromLTRB(0,10,0,10),
                margin: EdgeInsets.fromLTRB(0,10,0,10),
                child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'Device $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          })
              )
            ],),

          //Device List here;

          Column(children: [
            Row(children: [
              Container(
                height: 550,
                child: addDevice(),)
          ],)

          ],),

          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Column(children: [
              Container(
                width: 130,
                height: 45,
                child: FilledButton(onPressed: (){},
                child: Text("+",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(blue)),),
              )
            ],)
          ],)

          ],),
        ),
      ),
    );
  }
}




class addDevice extends StatefulWidget {
  const addDevice({super.key});

  @override
  State<addDevice> createState() => _addDeviceState();
}

class _addDeviceState extends State<addDevice> {
  List data = ["Router","Router","Router","Router","Router","Hello"];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
          Column(children: [
            Container(
              width: 300,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                
                boxShadow: [BoxShadow(
                  color: Colors.red,
                  blurRadius: 4,
                  offset: Offset(4, 8),   
                )]
              ),
              child: Text("Text"),
            )
          ],)
        ],),
    );
  }
}