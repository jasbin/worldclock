import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;
  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Kathmandu', location: 'Nepal', flag: 'nepal.png'),
    WorldTime(url: 'America/Chicago', location: 'Nepal', flag: 'usa.png'),
    WorldTime(
        url: 'America/Mexico_City', location: 'Mexico', flag: 'mexico.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'london.png'),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future updateTime(index) async {
    WorldTime worldTime = locations[index];
    await worldTime.getTime();
    Navigator.pop(context, {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDaytime': worldTime.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose a Location"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  subtitle: Text(locations[index].url),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
