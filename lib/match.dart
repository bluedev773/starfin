import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//TODO: Make list items selectable

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  bool card1Status = false;
  bool card2Status = false;
  bool card3Status = false;
  bool card4Status = false;
  bool card5Status = false;
  bool card6Status = false;
  bool card7Status = false;
  bool card8Status = false;
  bool card9Status = false;
  bool card10Status = false;

  //TODO: need to make card selection unique, all are set to card1status. Look in to listbuilder.
  getLocationItems(AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.docs
        .map((doc) => new ListTile (
            leading: Icon(Icons.album),
            title: new Text(doc["name"]),
            subtitle: new Text(doc["description"]),
            enabled: true,
            selected: card1Status,
            selectedTileColor: Colors.red,
            onTap: () {
              setState(() {
                if(card1Status == false){
                  card1Status = true;
                }else
                  card1Status = false;
              });
              debugPrint("card clicked");
            },

      )
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference locations = FirebaseFirestore.instance.collection('locations');

    return StreamBuilder<QuerySnapshot>(
      stream: locations.snapshots(),
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) return new Text("There is no data");
        //return new ListView(children: getLocationItems(snapshot));
        return Scaffold(
          body:Container(
            padding: const EdgeInsets.all(32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your Matches!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                      textAlign: TextAlign.center
                  ),
                  new Expanded(
                    child: ListView(
                      children: getLocationItems(snapshot)
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      //getLocations();
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => MatchPage()),
                      //);
                    },
                    child: Text("MAP IT!", style: TextStyle(fontSize: 18.0)),
                  )
                ]
            )
          )
        );
    });
  }
}