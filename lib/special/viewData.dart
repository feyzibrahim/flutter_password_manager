import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/modal/social_data.dart';

class ViewData extends StatefulWidget {
  final SocialData socialData;
  final index;

  ViewData(
    this.socialData,
    this.index,
  );
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  SocialData socialData = SocialData();

  void deleteData() {
    var passwordBox = Hive.box('passwords');
    passwordBox.deleteAt(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[600],
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.socialData.title,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                      onSaved: (String value) {
                        socialData.title = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Enter a value';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.socialData.username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      onSaved: (String value) {
                        socialData.username = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Enter a value';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.socialData.password,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Enter a value';
                        else
                          return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                      onPressed: () {
                        _formKey.currentState.save();
                        deleteData();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
