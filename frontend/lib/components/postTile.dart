import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotted/models/models.dart';

class PostTileWidget extends StatefulWidget {
  PostTileWidget({this.post, this.userImage, this.onPressed});

  final Post post;

  final ImageProvider userImage;

  final VoidCallback onPressed;

  @override
  _PostTileWidgetState createState() => _PostTileWidgetState(this.onPressed);
}

class _PostTileWidgetState extends State<PostTileWidget> {
  bool buttonChecked = false;
  final VoidCallback _onPressed;

  _PostTileWidgetState(this._onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: makePost(
        post: widget.post,
        userImage: widget.userImage,
      )
    );
  }

  Widget makePost({Post post, ImageProvider userImage, VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: userImage,
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.title.toString(), style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      SizedBox(height: 3,),
                      Text(post.postedAt.toString(), style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(post.body, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
          SizedBox(height: 20,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  makeHelp(checked: buttonChecked),
                  SizedBox(width: 5,),
                  //Text("200", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ],
              ),
              //Text("400 Helps", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),
          /*
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeHelpButton(isActive: true),
            ],
          )*/
        ],
      ),
    );
  }

  Widget makeHelp({bool checked}) {
    if (checked) {
    return Container(
      child: Center(
        child: IconButton(
          icon: new Icon(Icons.thumb_up), 
          color: Colors.blue,
          onPressed: () => setState(() {
            buttonChecked = true;
            _onPressed();
          }),
          ),
      ),
    );
  } else {
    return Container(
      child: Center(
        child: IconButton(
          icon: new Icon(Icons.thumb_up), 
          color: Colors.grey[500],
          onPressed: () => setState(() {
            buttonChecked = true;
          }),
          ),
      ),
    );
  }
  }

   Widget makeHelpButton({isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.thumb_up, color: isActive ? Colors.blue : Colors.grey, size: 18,),
            SizedBox(width: 5,),
            Text("Help", style: TextStyle(color: isActive ? Colors.blue : Colors.grey),)
          ],
        ),
      ),
    );
  }
}

 Widget makePost({Post post, ImageProvider userImage, VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: userImage,
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.title.toString(), style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      SizedBox(height: 3,),
                      Text(post.postedAt.toString(), style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(post.body, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
          SizedBox(height: 20,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  makeHelp(),
                  SizedBox(width: 5,),
                  //Text("200", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ],
              ),
              //Text("400 Helps", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),
          /*
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeHelpButton(isActive: true),
            ],
          )*/
        ],
      ),
    );
  }

  Widget makeHelp({VoidCallback onTap}) {
    return Container(
      /*width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white)
      ),*/
      child: Center(
        child: IconButton(
          icon: new Icon(Icons.thumb_up), 
          color: Colors.white,
          onPressed: () => onTap,
          ),
      ),
    );
  }

   Widget makeHelpButton({isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.thumb_up, color: isActive ? Colors.blue : Colors.grey, size: 18,),
            SizedBox(width: 5,),
            Text("Help", style: TextStyle(color: isActive ? Colors.blue : Colors.grey),)
          ],
        ),
      ),
    );
  }