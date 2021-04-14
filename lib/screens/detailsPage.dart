import 'package:flutter/material.dart';
import 'package:echo_v3/screens/mapScreen.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    List detailsList = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            detailsList[1],
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Image.network(detailsList[3]),
          SizedBox(
            height: 20.0,
          ),
          Text(
            detailsList[2],
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
          ),
          Row(
            children: <Widget>[
              BackButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                },
              ),
              Text(
                "Back to Map",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
