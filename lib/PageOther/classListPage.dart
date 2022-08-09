import 'package:flutter/material.dart';
import 'package:projectbuddytravel/PageOther/classAdd.dart';

class ListCreatePlace extends StatefulWidget {
  const ListCreatePlace({Key? key}) : super(key: key);

  @override
  State<ListCreatePlace> createState() => _ListCreatePlaceState();
}

class _ListCreatePlaceState extends State<ListCreatePlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('ประวัติการเพิ่ม'),
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ClassCreate()));
        }, icon: Icon(Icons.add_location_alt_outlined))
      ],
    ),
    );
  }
}
