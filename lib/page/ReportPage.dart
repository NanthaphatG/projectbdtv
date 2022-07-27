import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:projectbuddytravel/option/Responsesive.dart';
class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int _selectedIndex = 1;
  List <String> id=[];
  List <String> img=[];
  List <String> name=[];
  List <String> type=[];
  List <String> address=[];
  //var sent=TextEditingController();

  initState() {
    getPlaces();
    super.initState();
  }

  Future <String> getPlaces() async{
    Uri url = Uri.parse('http://buddytravel.cocopatch.com/GetPlace.php');
    var response = await http.get(url);
    var data1 = json.decode(response.body);
    //print(data1[1]['p_Name'].toString().length);
    try {
      for (int i=0;i<data1.toString().length;i++)
      {
        setState(() {
          id.add(data1[i]['p_ID'].toString());
          img.add(data1[i]['p_Image'].toString());
          name.add(data1[i]['p_Name'].toString());
          type.add(data1[i]['p_Type'].toString());
          address.add(data1[i]['p_Address'].toString());
        });

      }
    }
    catch (error){

    }
    print(id);
    return data1.toString();
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
        title: Text('สถานที่'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add)),
        ],
      ),
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 0.85*w,
              height: 0.27*h,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic
                    ),
                    decoration: InputDecoration(

                        border: OutlineInputBorder()
                    )
                ),

                suggestionsCallback: (String pattern) async {
                  return await findplace(pattern);
                },
                itemBuilder: (BuildContext context, dynamic suggestion) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(suggestion['name']),
                    subtitle: Text('${suggestion['address']}'),
                  );
                },
                onSuggestionSelected: (suggestion) {},
              ),
            ),
          ),
          Expanded(child:
          ListView.builder(
              itemCount: name.length,
              itemBuilder: (BuildContext buildContext, int index){
                /*return ListTile(
                  leading: Image.network(img[index].toString()),
                  title: Text(name[index]+" ("+type[index]+")"),
                  subtitle: Text(address[index]),
                  onTap: (){},
                );*/
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        border: Border(
                          top: BorderSide(width: 2.0, color: Color(0xFF81D4FA)),
                          left: BorderSide(width: 2.0, color: Color(0xFF81D4FA)),
                          right: BorderSide(width: 2.0, color: Color(0xFF81D4FA)),
                          bottom: BorderSide(width: 2.0, color: Color(0xFF81D4FA)),
                        ),
                        color: Color(0xFF81D4FA),
                      ),
                      height: 0.9*h,
                      child: Expanded(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                            ClipRRect(
                              child:  Image.network(img[index].toString(),
                                height: 0.5*h,
                                width: 0.85*w,
                                fit:BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            Row(
                              children: [
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: new Text(
                                        name[index],
                                        style: TextStyle(fontSize: 17,fontWeight: FontWeight. bold,color: Colors.teal[800]),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Icon(Icons.star,color: Colors.yellow,size: 0.045*w),
                                          Icon(Icons.star,color: Colors.yellow,size: 0.045*w),
                                          Icon(Icons.star,color: Colors.yellow,size: 0.045*w),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                );
              }
          )
          ),
        ],
      )
    );
  }
  Future<List<dynamic>> findplace(String pattern) async {
    List<dynamic> places = [];
    var googlePlace = GooglePlace('AIzaSyDPgyrn1yvDTIm9yETOpj_TyxH1jQVhryg');
    TextSearchResponse? suggestion = await googlePlace.search.getTextSearch(
      pattern,
      language: 'th',
    );
    if (suggestion != null && suggestion.results != null) {
      for (var item in suggestion.results!) {
        var place;
        if (item.geometry!.location != null) {
          place = {
            'name': item.name,
            'lat': item.geometry!.location!.lat,
            'lng': item.geometry!.location!.lng,
            'address': item.formattedAddress
          };
          //name1=jsonEncode(place['name']);
          log(jsonEncode(place));
          places.add(place);
        }
        else{
          place={};
          places.add(place);
        }
      }
    }
    if (places.length > 5) return places.sublist(0, 4);
    return places;
  }
}
