import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/modal/social_data.dart';
import 'package:password_manager/special/viewData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        children: [
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('passwords').listenable(),
      builder: (BuildContext context, box, widget) {
        if (box.length != 0) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 70.0),
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final socialData = box.getAt(index) as SocialData;
              return FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ViewData(socialData, index),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              socialData.title,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              socialData.username,
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      copyButton(socialData.password),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'Add data by clicking below add button',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget copyButton(pass) {
    return RawMaterialButton(
      padding: EdgeInsets.all(0.0),
      child: Icon(
        Icons.content_copy,
        color: Colors.grey[500],
      ),
      splashColor: Colors.white,
      shape: CircleBorder(),
      onPressed: () => {
        Clipboard.setData(
          ClipboardData(text: pass),
        ).then(
          (_) => Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Passsword Copied to ClipBoard "),
            ),
          ),
        ),
      },
    );
  }
}
