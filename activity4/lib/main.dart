import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:activity4/DataList.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<List<DataList>> ReadJsonData() async {
  final jsondata = await rootBundle.rootBundle
      .loadString('assets/JSON/MOCK_DATA for Flutter layouting.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => DataList.fromJson(e)).toList();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<DataList>;
            return ListView.builder(itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                          width: 50,
                          height: 50,
                          image: NetworkImage(
                            items[index].avatar == null
                                ? 'https://static.thenounproject.com/png/3134331-200.png'
                                : items[index].avatar.toString(),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                          items[index].first_name.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: Text(
                                          items[index].last_name.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Text(items[index].username.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                      items[index].status == null
                                          ? 'No Status Inserted'
                                          : items[index].status.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                ),
                              ],
                            ),
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Text(items[index].last_seen_time.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 30.0,
                                height: 25.0,
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                right: 4,
                                child: Container(
                                  height: 15.0,
                                  width: 15.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    child: Text(
                                        items[index].messages == null
                                            ? '0'
                                            : items[index].messages.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
