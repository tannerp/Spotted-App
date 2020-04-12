import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';
//import 'dart:convert';



class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => RegisterScreen(),
      },
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _confirmPassword;

  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
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
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
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

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      controller: passwordController,
      validator: (String value) {       
        Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regex = new RegExp(pattern);
        if (value.isEmpty) {
        return 'Please enter a password';
        } else {
        if (value.length < 8){
        return 'Password must contain at least 8 characters';
        }
        //can be broken down to give more graceful messages
        if (!regex.hasMatch(value))
        return ('Enter valid password \nPassword must conatine at least one\n' + 
               ' 1.Upper Case character\n' +
               ' 2.Lower Case character\n' +
               ' 3.Special character\n' +
               ' 4.Number character');
        else
        return null;
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value != passwordController.text ) {
          return 'Password doesn\'t match';
        }
        return null;
      },
      onSaved: (String value) {
        _confirmPassword = value;
      },
    );
  }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFirstName(),
              _buildLastName(),
              _buildEmail(),
              _buildPassword(),
              _buildConfirmPassword(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  print(_firstName);
                  print(_lastName);
                  print(_email); 
                  print(_password); //not practical 
                  print(_confirmPassword);

                  _registerGetRequest();  
                  //API interaction
                  _registerPostRequest(_firstName, _lastName, _email);      
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

_registerGetRequest() async {
  print('Hello');
  String url = 'https://jsonplaceholder.typicode.com/posts';

  Map<String, String> arg = {"Accept": "application/json"};

  http.Response response = await http.get(url, headers: arg);

  // sample info available in response
  int statusCode = response.statusCode;
  
  //Needs work: needs to be cast to a user Model
  //Map<String, dynamic> data = json.decode(response.body);
  print('Get succedful $statusCode \n Response is as follows: \n');
  print(response.body);
  
  //List data2 = JSON.decode(response.body);
 
  //print(data['title']);
}

_registerPostRequest(String firstName, String lastName, String email) async {
  // set up POST request arguments

  //url should be updated with our api route
  String url = 'https://jsonplaceholder.typicode.com/posts';
  Map<String, String> arg = {"Content-type": "application/json"};
  String json = '{"userId": "$firstName", "title": "$lastName", "body": "$email"}';

  // make POST request
  // use SSL to encrytp body
  http.Response response = await http.post(url, headers: arg, body: json);
  // check the status code for the result

  int statusCode = response.statusCode;

  if (statusCode > 400){
    return('http post failed status Code: $statusCode');
  }
  else {
    print('post request succesfull status Code: $statusCode');
  }
}