import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location; //Location name for UI
  String? time; //Time in that location
  String flag; //URL to asset flag icon
  String url; //Location URL for API endpoint
  bool? isDaytime; //true of false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //   print(data);
      //   print(data['title']);
      // }

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print(datetime);
      // print(offset);
      // print(dayOfWeek);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour> 6 && now.hour< 20 ? true : false;
      time = DateFormat.jm().format(now);

      // print(now);
    } catch (e) {
      print('Error found $e');
      time = 'Could not get time data';
    }
  }
}
