import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/modal/social_data.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  SocialData socialData = SocialData();

  void addData() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Data saved Title: ${socialData.title}, Username: ${socialData.username}'),
      ),
    );

    var passwordBox = Hive.box('passwords');
    passwordBox.add(socialData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              onSaved: (String value) {
                socialData.title = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Username',
              ),
              onSaved: (String value) {
                socialData.username = value;
              },
            ),
            TextFormField(
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              onSaved: (String value) {
                socialData.password = value;
              },
            ),
            SizedBox(height: 20.0),
            FlatButton(
              color: Colors.grey[800],
              onPressed: () {
                _formKey.currentState.save();
                addData();
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
