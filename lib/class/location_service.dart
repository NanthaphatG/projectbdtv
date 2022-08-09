import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class LocationService {
  final String Key = "AIzaSyC6USqS7InyHldOFJgZb9LRjHf0w_mrZPo";

  Future<String> getPlaceId(String input) async {
    final String Url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$Key';

    var response = await http.get(Uri.parse(Url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    print(response);
    print(placeId);
    return placeId;
  }

  Future<Map<String,dynamic>> getPlace(String input) async{
    final placeId =await getPlaceId(input);
    final String Url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$Key';

    final response = await http.get(Uri.parse(Url));
    var json = convert.jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;

    print(result);
    return result;
  }

}

