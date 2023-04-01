import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/modal/social_data.dart';
import 'package:password_manager/special/floatingButton.dart';
import 'package:password_manager/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDirectory.path);
  Hive.registerAdapter(SocialDataAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passwords',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Passwords",
            style: TextStyle(color: Colors.grey[300]),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey[850],
        ),
        floatingActionButton: MyFloatingButton(),
        body: FutureBuilder(
          future: Hive.openBox('passwords'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(
                  snapshot.error.toString(),
                );
              else
                return Home();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('passwords').compact();
    Hive.close();
    super.dispose();
  }
}
