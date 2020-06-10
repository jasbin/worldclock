import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue[400] : Colors.blue[200];
    Color textColor = data['isDaytime'] ? Colors.white : Colors.grey[200];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/$bgImage'), fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: FlatButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag']
                    };
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[200],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[200]),
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                data['location'],
                style: TextStyle(
                    fontSize: 28, letterSpacing: 2.0, color: textColor),
              ),
            ),
            SizedBox(height: 20),
            Text(
              data['time'],
              style: TextStyle(fontSize: 66, color: textColor),
            )
          ],
        ),
      )),
    );
  }
}
