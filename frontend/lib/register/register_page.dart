import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          //width: 400,
          child: Card(
            child: VerifyForm(),
          ),
        ),
      ),
    );
  }
}


class VerifyForm extends StatefulWidget {
  @override
  _VerifyFormState createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  String _firstName;
  String _lastName;
  String _email;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }
  
  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last Name'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        if (!contains(value, 'spu.edu')) {
          return 'Please enter a SPU email Address';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
        backgroundColor: Colors.black,
        ),
      body:Center(
        child: Container( 
        margin: EdgeInsets.all(24),
        alignment: Alignment.center,
             height: 400,
             width: 400,
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(
                border: Border.all(
                color: Colors.black,
               ),
                borderRadius: BorderRadius.circular(10.0),
            ),
            child: Form(
            key: _formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFirstName(),
              _buildLastName(),
              _buildEmail(),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Submit',
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  //API interaction
                  _verifyEmailPostRequest(_firstName, _lastName, _email, context);
                   Navigator.pushNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}

_verifyEmailPostRequest(String firstName, String lastName, String email, BuildContext context) async {
  // set up POST request arguments

  //url should be updated with our api route
  // String url = 'https://jsonplaceholder.typicode.com/posts';
  String url = 'http://localhost:8082/api/v0/users/regis';
  Map<String, String> arg = {"Content-type": "application/json"};
  
  String json = '{"fname": "$firstName", "lname": "$lastName", "email": "$email"}';

  print(url);
  // make POST request
  http.Response response = await http.post(url, headers: arg, body: json);
  // check the status code for the result

  int statusCode = response.statusCode;

  if (statusCode > 400){
    return('http post failed status Code: $statusCode');
  }
  else {
    print('post request succesfull status Code: $statusCode');
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thank you Joining Spotted"),
          content: new Text("Your information has been received. Please check your inbox and follow link to complete Registration"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new Center(
              child: FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
          ],
        );
      },
    );
      
}