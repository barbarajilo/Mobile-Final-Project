//import 'package:final_project/data_structure/postcard_struct.dart';
import 'package:flutter/material.dart';

class PostCardDetails extends StatefulWidget {
  const PostCardDetails({Key? key, required this.title, required this.description, required this.image}) : super(key: key);
  final String title;
  final String description;
  final String image;

  @override
  _PostCardDetailsState createState() => _PostCardDetailsState();
}

class _PostCardDetailsState extends State<PostCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image(
              image: NetworkImage(widget.image)
              ),
          ),
        
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 5),
            child: Text(
              'Title : ' + widget.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 5),
            child: Text('Description : ' + widget.description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey,
            )),
          ),
        ),
      ],
    ),
    );
  }
}