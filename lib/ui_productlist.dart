import 'package:flutter/material.dart';
import 'package:week7_n/ui_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class PageProductlist extends StatefulWidget {
  PageProductlist({Key? key}) : super(key: key);

  @override
  State<PageProductlist> createState() => _PageProductlistState();
}

class _PageProductlistState extends State<PageProductlist> {
  List<dynamic> data = ["default"];
  Map<dynamic, dynamic> resp_json = {
    "id": "default",
    "name": "default",
    "price": "default",
    "num": "default",
    "image": "default",
  };

  Future<String> getProductList() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json"
    };

    var uri =
        Uri.parse("http://192.168.88.80:81/webapp64/api/product_list.php");
    var response = await http.post(uri,
      headers: headers,
      body: null,
      encoding: Encoding.getByName("utf-8"),
    );
    setState(() {
      resp_json = json.decode(response.body);
      if (resp_json["reault"] == 1) {
        data = resp_json["product_list"];
      } else {
        print("no load data");
      }
    });
    return "success";
  }

  Widget displayList() {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: (data.isEmpty) ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        print(data[index]["name"]);
        print(data[index]["price"]);
        print(data[index]["image"]);
        return cardlist(
            data[index]["name"], data[index]["price"], data[index]["image"]);
      },
    );
  }

  Widget headerbar() {
    return Container(
      height: 40,
      color: Colors.deepOrange,
      child: Center(
        child: Text(
          "headerbar",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget cardlist(String name, price, image) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        color: Color.fromARGB(255, 223, 223, 223),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 8,
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10), //ระยะห่าง
                  child: Image.network(image),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Text(name),
                      SizedBox(
                        height: 10,
                      ),
                      Text(price),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        color: Color.fromARGB(255, 255, 72, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text("Buy"),
                        onPressed: () {
                          print("Recived Cike");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget footerbar() {
    return Container(
      height: 40,
      color: Colors.deepOrange,
      child: Center(
        child: Text(
          "Footer",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void initState() {
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            headerbar(),
            displayList(),
            footerbar(),
          ],
        ),
      ),
    );
  }
}
