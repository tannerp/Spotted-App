import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:validators/validators.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: CreatePostForm(),
          ),
        ),
      ),
    );
  }
}


class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {

  String _title ;
  String _content;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title'
      ),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _title = value;
      },
    )

    );
  }
  
  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.all(8.0),
      //padding: EdgeInsets.only(bottom: 40.0),
      child:TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Content',
      ),
      maxLength: 300,
      maxLines: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Post Body is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _content= value;
      },
    )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("createPost")),
      body: 
      Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(),
              _buildContent(),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'post',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  print(_title);
                  print(_content);

                  _createPostGetRequest();  
                  //API interaction
                  _createPostPostRequest(_title, _content);  
                   Navigator.pushNamed(context, '/createProfile');                     
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

_createPostGetRequest() async {
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

_createPostPostRequest(String title, String content) async {
  // set up POST request arguments

  //url should be updated with our api route
  String url = 'https://jsonplaceholder.typicode.com/posts';
  Map<String, String> arg = {"Content-type": "application/json"};
  String json = '{"userId": "$title", "title": "$content"}';

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