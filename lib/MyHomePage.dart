
import 'package:flutter/material.dart';
import 'LocalStorage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static Future<void> show(message, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //properties
  var username;
  var password;
  var musername ="user"; 
  var mpassword = "password";
  var texts = new List<String>();
  var values = new List<String>();

  //initialize the values of the widget.
  @override
  void initState() {
    super.initState();
    setState(() {
      LocalStorage.readContent().then((value) {
        setState(() {
          this.musername = value;
          texts.add("text 1");
          texts.add("text 2");
          texts.add("text 3");
          texts.add("text 4");
        });
      });     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      //added scrollable view on widget
      body: SingleChildScrollView(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
            <Widget>[

              //iterate the value of texts and create multiple TextFormFields according to the texts list.
            Column(children: texts.map((value) => new Padding(
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: value,
                ),
                onChanged: (text) {
                  setState(() {
                    values.add(text);
                  });
                },
            ))).toList()),
            Padding(      
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),

                //used to update the of a variable within the widget.
                onChanged: (text) {
                  setState(() {
                    this.username = text;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ), 
            ),
            Padding(    
                   
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',
                ),
                onChanged: (text) {
                  setState(() {
                    this.password = text;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ), 
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 25, 5),
                    child: RaisedButton(
                      child: Text("Submit"),
                      //added onPressed function on the button, check if the value matches.
                      onPressed: () {
                        if(username == musername && password == mpassword) {
                          MyHomePage.show("User Matched!", context);
                        } else {
                          MyHomePage.show("User Not Found!", context);
                        }
                      },
                    ),
                  ),
                ),  
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 25, 5),
                    child: RaisedButton(
                      child: Text("Save"),

                      //allows to overwrite the value within the local storage
                      onPressed: () {
                        print(values);

                        //call local storage class.
                        LocalStorage.writeContent(username);
                        musername = username;
                      },
                    ),
                  ),
                ),           
              ],
            ),
          ],
        ),
      ),
    );
  }
}

