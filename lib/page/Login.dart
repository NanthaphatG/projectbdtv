import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectbuddytravel/option/Responsesive.dart';
import 'package:projectbuddytravel/page/Register.dart';
import 'package:projectbuddytravel/pageroute/menuTap.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller=new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = displayWidth(context);
    double h = displayWidth(context) - MediaQuery
        .of(context)
        .padding
        .top - kToolbarHeight;
    Widget TextFieldLogin(String input){
      String htext="";
      if(input == 'email')
      {
        htext='อีเมล';
      }
      else{
        htext='รหัสผ่าน';
      }
      return Container(
          child: TextField(
              style: TextStyle(color: Colors.lightBlue),
              controller: _controller,
              decoration: InputDecoration(
                  hintText: htext,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.5,color: Colors.lightBlue),
                  )
              )
          )
      );
    }
    return MaterialApp(
      title: 'Buddy Travel Project',
      home: Scaffold(
          body:ListView(
            children: [
              new Container(
                width: 1*w,
                height: 1*h,
                //color: Colors.greenAccent,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Image.asset('img/Buddy.png'),
              ),
              new Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: 0.9*w,
                    height: 0.3*h,
                    child: TextFieldLogin('email'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: 0.9*w,
                    height: 0.3*h,
                    child: TextFieldLogin('password'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: (){},
                      child: Text('ลืมรหัสผ่าน?'),
                    ),
                  ),
                  new Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0,0)),
                      ButtonTheme(
                        minWidth: 0.9*w,
                        height: 0.155*h,
                        buttonColor: Colors.lightGreen,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => MenuTap()));
                          },
                          child: Text("เข้าสู่ระบบ",style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0,0)),
                      ButtonTheme(
                        minWidth: 0.9*w,
                        height: 0.155*h,
                        buttonColor: Colors.blueAccent,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text("เชื่อมต่อโดยใช้ Facebook",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0,0)),
                      ButtonTheme(
                        minWidth: 0.9*w,
                        height: 0.155*h,
                        buttonColor: Colors.black,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                          },
                          child: Text("สมัครสมาชิก",style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}
