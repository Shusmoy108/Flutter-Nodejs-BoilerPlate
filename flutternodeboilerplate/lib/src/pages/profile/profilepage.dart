import 'package:flutter/material.dart';
import 'package:blogapp/src/models/user.dart';


class Home extends StatefulWidget {
  User user;
  Home(this.user);
  @override
  State<StatefulWidget> createState() {
    return HomeState(user);
  }
}

class HomeState extends State<Home> {
  User user;
  HomeState(this.user);
  @override
  void initState() {
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
       child:
        //FutureBuilder(
//            future: course(),
//            builder: (BuildContext context, AsyncSnapshot snapshot) {
//              if (snapshot.hasData == false) {
//                return Container(
//                    color: Colors.white, child: CircularProgressIndicator());
//              } else {
//                return
               Scaffold(
                    appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.lightGreen,
                        title: Text("Class Attendant")),

                    body: Container(
                        color: Color.fromRGBO(234, 239, 241, 1.0),
                        child: ListView(
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 100,
                            ),
                            Divider(
                                color: Colors.blueGrey,
                                thickness: 1,
                                indent: 5),
                            SizedBox(height: 2),
                            Center(
                              child: Text(user.name,
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text(user.gender,
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic)),
                            ),
                            SizedBox(height: 2),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("Email",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic)),
                            ),
                            Divider(),
                            Card(
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                          title: Text(user.email),)
                                )),
                            SizedBox(height: 2),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("Address",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic)),
                            ),
                            Divider(),
                            Card(
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                  subtitle: Text(user.address),
                                  ),
                                )),
                            SizedBox(height: 2),




                          ],
                        )),


    ));
  }
}
