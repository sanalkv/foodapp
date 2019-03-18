import 'package:flutter/material.dart';
import 'signupclass.dart';
import 'foodclass.dart';
import 'fooddatabase.dart';

class Foodinfo extends StatefulWidget {
  @override
  _FoodinfoState createState() => _FoodinfoState();
}

Future<List<Food>> fetchdetails() async {
  var dbhelper = Dbhelper();
  //dbhelper.savedetails();
  Future<List<Food>> list = dbhelper.displaydetails();
  print(list);
  return list;
}

class _FoodinfoState extends State<Foodinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder<List<Food>>(
        future: fetchdetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTileTheme(
                    
                    contentPadding: EdgeInsets.all(8),
                   
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      color: Colors.lightBlueAccent,                      
                                          child: ListTile(
                        title: Text(snapshot.data[index].name,
                            style: TextStyle(
                                fontSize: 14, color:Colors.white,fontFamily: "Times New Roman")),
                        leading: Icon(Icons.restaurant),
                                                trailing: Text("Status : "+snapshot.data[index].status,
                            style: TextStyle(
                                fontSize: 14, fontFamily: "Times New Roman")),
                        onTap: () {
                          print("selected");
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("error");
            }
          } else {
            return Center(
                child: Container(
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
    ));
  }
}
