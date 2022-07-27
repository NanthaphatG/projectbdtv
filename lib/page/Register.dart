import 'package:flutter/material.dart';
import 'package:projectbuddytravel/option/Responsesive.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  TextEditingController email =new TextEditingController();
  TextEditingController fName =new TextEditingController();
  TextEditingController lName =new TextEditingController();
  TextEditingController password =new TextEditingController();
  TextEditingController dateinput = TextEditingController();

  Widget _entryField(String title,TextEditingController type, {bool isPassword = false}) {
    double w = displayWidth(context);
    double h = displayWidth(context) - MediaQuery
        .of(context)
        .padding
        .top - kToolbarHeight;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Container(
              height: 0.175*h,
              width: 0.85*w,
              child: TextField(
                  controller: type,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: title,
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.003*w,color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular((25))
                      ),
                      filled: true)),
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    double w = displayWidth(context);
    double h = displayWidth(context) - MediaQuery
        .of(context)
        .padding
        .top - kToolbarHeight;
    return Scaffold(
    appBar: AppBar(
      title: Text('สมัครสมาชิก'),

    ),
      body: ListView(
        children: [
          _entryField("ชื่อ",fName),
          _entryField("นามสกุล",lName),
          _entryField("อีเมล",email),
          _entryField("รหัสผ่าน",password, isPassword: true),
        Padding(
          padding: const EdgeInsets.fromLTRB(25,10,40,0),
          child: TextField(
            controller: dateinput, //editing controller of this TextField
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today,color: Colors.blueAccent), //icon of text field
                labelText: "วันเกิด",//label text of field
                hintStyle: TextStyle(color: Colors.blueAccent)
                ,filled: true,
              labelStyle: TextStyle(color: Colors.blueAccent)
              ,enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.003*w,color: Colors.blueAccent),
                borderRadius: BorderRadius.circular((25))
            ),
            ),

            readOnly: true,  //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101)
              );

              if(pickedDate != null ){
                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateinput.text = formattedDate; //set output date to TextField value.
                });
              }else{
                print("Date is not selected");
              }
            },
          ),
        ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,25,30,25),
            child: ButtonTheme(
              minWidth: 0.9*w,
              height: 0.155*h,
              buttonColor: Colors.lightGreen,
              child: RaisedButton(
                onPressed: () {},
                child: Text("ยืนยันการสมัครสมาชิก",style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          Center(
            child: Text(
              'หรือ',
              style: TextStyle(fontSize: 0.055*w,color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,25,30,25),
            child: ButtonTheme(
              minWidth: 0.9*w,
              height: 0.155*h,
              buttonColor: Colors.blueAccent,
              child: RaisedButton(
                onPressed: () {},
                child: Text("เชื่อมต่อโดยใช้ Facebook",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
