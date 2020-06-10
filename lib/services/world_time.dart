import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag; //url to asset flag icon
  String url; //location url for api endpoints
  bool isDaytime; //is day time or not
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTimeByIp() async {
    try {
      Response response = await get("http://worldtimeapi.org/api/ip");
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsethrs = data['utc_offset'].substring(0, 3);
      String offsetmin = data["utc_offset"].substring(4, 6);
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offsethrs), minutes: int.parse(offsetmin)));
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 5 && now.hour < 20 ? true : false;
    } catch (error) {
      print('error: $error');
      time = "Service down...";
    }
  }

  Future<void> getTime() async {
    try {
      Response response =
          await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsethrs = data['utc_offset'].substring(1, 3);
      String offsetmin = data["utc_offset"].substring(4, 6);
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offsethrs), minutes: int.parse(offsetmin)));
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 5 && now.hour < 20 ? true : false;
    } catch (e) {
      time = 'could not get time';
    }
  }
}
