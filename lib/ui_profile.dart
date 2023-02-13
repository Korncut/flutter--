import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:week7_n/ui_productlist.dart';

class PageProfile extends StatefulWidget {
  PageProfile({Key? key}) : super(key: key);

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  TextEditingController input_email = TextEditingController();
  TextEditingController input_password = TextEditingController();

  Future<String> getProfile() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json"
    };
    var uri = Uri.parse("http://192.168.88.80:81/webapp64/api/login.php"); //ดึงมาจากphp

    Map<String, String> data_post = {
      "email": input_email.text,       
      "password": input_password.text
    };

    var response = await http.post(
      uri,
      headers: headers,   
      body: json.encode(data_post),
      encoding: Encoding.getByName("utf-8"), //โพสแมน
    );

    Map resp_json = json.decode(response.body);
    print(resp_json["result"]);
    if (resp_json["result"] == 1) {
      print("Login comlete");  //กำหนดรี

     Navigator.of(context).push(MaterialPageRoute( //ย้ายหน้า
                builder: (context) => PageProductlist()));

    } else {
      print("Login Falied");
    }

    return "success";
  }

  void initState() {
    getProfile();
  }

  Widget Login() {
    return Container(
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 0, 255, 0.8)),
        ),
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
    );
  }

  Widget InputEmail() {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: TextFormField(
        controller: input_email,
        decoration: InputDecoration(
            labelText: "E-mail",
            hintText: "อีเมล",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
    );
  }

  Widget InputPassword() {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: TextFormField(
        controller: input_password,
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "รหัสผ่าน",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
    );
  }

  Widget ButtonLogin() {
    return Container(
      child: Center(
        child: RaisedButton(
          color: Colors.blue[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Text(
            "Login",
            style: TextStyle(
                fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          onPressed: () {
            setState(() {
              getProfile();
            });
          },
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [Login(), InputEmail(), InputPassword(), ButtonLogin()],
          ),
        ),
      ),
    );
  }
}
