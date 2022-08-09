import 'package:flutter/material.dart';
import 'package:projectbuddytravel/option/Responsesive.dart';

class ClassCreate extends StatefulWidget {
  const ClassCreate({Key? key}) : super(key: key);

  @override
  State<ClassCreate> createState() => _ClassCreateState();
}

class _ClassCreateState extends State<ClassCreate> {
  String addSelect = "";
  final List<String> items = [
    'เพิ่มสถานที่',
    'เพิ่มประเภท',
    'เพิ่มเทศกาล',
  ];
  String? selectedValue;

  TextEditingController placeName =new TextEditingController();

  Widget _entryField(String title, TextEditingController type,
      {bool isPassword = false}) {
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
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Container(
              height: 0.175 * h,
              width: 0.85 * w,
              child: TextField(
                  controller: type,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      hintText: title,
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.003 * w, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular((25))
                      ),
                      filled: true)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = displayWidth(context);
    double h = displayWidth(context) - MediaQuery
        .of(context)
        .padding
        .top - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้าง' + addSelect),
      ),
      /*body: ListView(
          children: [
          _entryField("ชื่อ", placeName),

      ]
    ),*/

    );
  }
}
