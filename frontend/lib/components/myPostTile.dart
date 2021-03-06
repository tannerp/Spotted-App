import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotted/models/models.dart';
import 'package:expandable/expandable.dart';

class MyPostTileWidget extends StatelessWidget {
  MyPostTileWidget({this.post, this.userImage, this.onPressed, this.userResponseList});

  final Post post;

  final ImageProvider userImage;

  final VoidCallback  onPressed;

  final List<User> userResponseList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: makePost(
        post: post,
        userImage: userImage,
        userResponseList: userResponseList,
      ),
    );
  }
}

 Widget makePost({Post post, ImageProvider userImage, String userName, TimeOfDay postTime, List<User> userResponseList}) {
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
                      Text(post.title, style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      SizedBox(height: 3,),
                      Text(TimeOfDay.now().toString(), style: TextStyle(fontSize: 15, color: Colors.grey),),
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
                  Text("200", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ],
              ),
              Text("400 Helps", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeHelpButton(isActive: true),
            ],
          ),
          ExpandablePanel(
            header: Text('See Who Responsed'),
            collapsed: Text('See Who Responded'),
            expanded: makeResponseList(responseUserList: userResponseList),
            tapHeaderToExpand: true,
            hasIcon: true,
          ),
        ],
      ),
    );
  }

  Widget makeHelp() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white)
      ),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
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

  Widget makeResponseList({List<User> responseUserList}) {
    //must receive user list  
    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.face),
          title: Text(responseUserList[index].firstName.toString()),
          trailing: Icon(Icons.message),
        );
      });

    return listView;
  }
  