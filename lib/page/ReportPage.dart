import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:projectbuddytravel/PageOther/classListPage.dart';
import 'package:projectbuddytravel/option/Responsesive.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool selected =false;
  int _selectedIndex = 1;
  List<String> id = [];
  List<String> img = [];
  List<String> name = [];
  List<String> type = [];
  List<String> address = [];
  List<String> places = [];
  String str = "Please Selected.";
  List<String> filterChipName = [
    'คาเฟ่',
    'ร้านเหล้า',
    'สวนสนุก',
    'ฟาร์ม',
    'ห้างสรพพสินค้า',
    'สถานศึกษา',
    'ร้านซ่อมรถ',
    'ร้านอาหาร'
  ];

  //var sent=TextEditingController();

  initState() {
    getPlaces();
    findplace();
    super.initState();
  }

  Future<String> getPlaces() async {
    Uri url = Uri.parse('http://buddytravel.cocopatch.com/GetPlace.php');
    var response = await http.get(url);
    var data1 = json.decode(response.body);
    //print(data1[1]['p_Name'].toString().length);
    try {
      for (int i = 0; i < data1.toString().length; i++) {
        setState(() {
          id.add(data1[i]['p_ID'].toString());
          img.add(data1[i]['p_Image'].toString());
          name.add(data1[i]['p_Name'].toString());
          type.add(data1[i]['p_Type'].toString());
          address.add(data1[i]['p_Address'].toString());
        });
      }
    } catch (error) {}
    print(id);
    return data1.toString();
  }

  void findplace() async {
    Uri url = Uri.parse(
        'https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province.json');
    var response = await http.get(url);
    var data = json.decode(response.body);
    try {
      for (int i = 0; i < data.toString().length; i++) {
        setState(() {
          places.add(data[i]['name_th'].toString());
        });
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    double w = displayWidth(context);
    double h = displayWidth(context) -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
        appBar: AppBar(
          title: Text('สถานที่'),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListCreatePlace()));
            }, icon: Icon(Icons.add)),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return places.where((String option) {
                    return option.contains(textEditingValue.text);
                  });
                },
                onSelected: (String selection) {
                  debugPrint('You just selected $selection');
                  setState(() {
                    str = selection;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                    ),

                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 18),
                  );
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text('ประเภทสถานที่',
                  style: TextStyle(fontSize: 20),),
              ),
            ),
            Container(
              height: h * 0.6,
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: [
                  for (int i = 0; i < filterChipName.length; i++)
                    buildFilterChip(filterChipName[i]),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: name.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.lightBlueAccent.shade100,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Image.network(
                                img[index],
                                fit: BoxFit.cover,
                              ),
                              ListTile(
                                title: Text(name[index]),
                                subtitle: Text(
                                  'Secondary Text',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Text(
                                  address[index],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Row(
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                        textColor: const Color(0xFF6200EE),
                                        onPressed: () {},
                                        child: const Text('เยี่ยมชม'),
                                      ),
                                    ],
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.bookmark_border),
                                        color: const Color(0xFF6200EE),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ));
  }

  buildFilterChip(String ftName) {
    return FilterChip(
      label: Text(ftName),
      selected: selected,
      onSelected: (bool value) {
        selected = value;
        setState(() {});
      },
    );
  }
}
