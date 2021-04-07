import 'package:flutter/material.dart';
import 'package:sqlite/customer_page.dart';
import 'package:sqlite/item_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Store'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      new Icon(
                        Icons.people,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text("Customer",
                          style: TextStyle(fontSize: 27, color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeCustomer()), 
                  );
                },
                )),
                Card(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      new Icon(
                        Icons.assignment_turned_in_rounded,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text("Desain",
                          style: TextStyle(fontSize: 27, color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeItem()), 
                  );
                },
                )),
          ],
        ),
      ),
    );
  }
}
