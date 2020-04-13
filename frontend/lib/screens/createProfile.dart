import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';


class CreateProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => CreateProfileScreen(),
      },
    );
  }
}

class CreateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: CreateProfileForm(),
          ),
        ),
      ),
    );
  }
}


class CreateProfileForm extends StatefulWidget {
  @override
  _CreateProfileFormState createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {

  String _firstName;
  String _lastName;
  String _email;

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
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CreateProfile")),
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
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'CreateProfile',
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

                  _createProfileGetRequest();  
                  //API interaction
                  _createProfilePostRequest(_firstName, _lastName, _email);      
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

_createProfileGetRequest() async {
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

_createProfilePostRequest(String firstName, String lastName, String email) async {
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