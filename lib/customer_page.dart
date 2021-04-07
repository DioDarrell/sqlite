import 'package:flutter/material.dart';
import 'package:sqlite/dbhelper.dart';
import 'package:sqlite/entry_form_customer.dart';
import 'package:sqlite/item_customer.dart'; //pendukung program asinkron
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper(); //panggil class dbhelper
  int count = 0;
  List<ItemCustomer> itemList;

@override
void initState(){
  super.initState();
  updateListView();
}

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<ItemCustomer>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Item'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Customer"),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                //TODO 2 Panggil Fungsi untuk Insert ke DB
                if (item != null) {
                  int result = await dbHelper.insertC(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<ItemCustomer> navigateToEntryForm(BuildContext context, ItemCustomer item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList[index].name,
              style: textStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alamat: ' + this.itemList[index].alamat),
                Text('Kode: ' + this.itemList[index].kode),
                Text('Jumlah: ' + this.itemList[index].jmlh.toString()),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int id = this.itemList[index].id;
                int result = await dbHelper.delete(id);
                itemList.removeAt(index);
                updateListView(); //update list item
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList[index]);
//TODO 4 Panggil Fungsi untuk Edit data
              if (item != null) {
                int result = await dbHelper.updateC(item);
                if (result > 0) {
                  updateListView(); //update list iten
                }
              }
            },
          ),
        );
      },
    );
  }

//update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
//TODO 1 Select data dari DB
      Future<List<ItemCustomer>> itemListFuture = dbHelper.getItemCustomList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}