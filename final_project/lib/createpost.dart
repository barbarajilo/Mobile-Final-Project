import 'dart:convert';

import 'package:final_project/homepage.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final titleTextField = TextEditingController();
  final descriptionTextField = TextEditingController();
  final imgUrlTextField = TextEditingController();

  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  void signInProcess() {
    channel.sink.add('{"type": "sign_in", "data": {"name" : "barb"}}');
  }

  createPostRequest() {
    String titleFieldCheck = titleTextField.text;
    String descriptionFieldCheck = descriptionTextField.text;
    String imageFieldCheck = imgUrlTextField.text;

    if (titleFieldCheck == '' ||
        descriptionFieldCheck == '' ||
        imageFieldCheck == '') {
      final snackBar = SnackBar(
        content: const Text("Fill in all details!"),
        action: SnackBarAction(label: 'X', onPressed: () {}),
      );

      print("Empty field");
    } else {
      channel.stream.listen((event) {
        final decodedMessage = jsonDecode(event);
        print(decodedMessage);

        channel.sink.close();
      });

      channel.sink.add(
          '{"type": "create_post", "data": {"title": "$titleFieldCheck", "description": "$descriptionFieldCheck", "image": "$imageFieldCheck"}}');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyMainHomePage()));
    }
  }

  @override
  void initState() {
    super.initState();
    signInProcess();
  }

  /*@override
  void dispose() {
    titleTextField.dispose();
    descriptionTextField.dispose();
    imgUrlTextField.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create PostCard Page'),
        ),
        //backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [Text('Title : ')]),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  height: 50,
                  width: 350,
                  child: TextField(
                    controller: titleTextField,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()),
                  ),
                ),
                Row(
                  children: [
                    Text('Description : '),
                  ],
                ),
                Container(
                  height: 80,
                  width: 400,
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  child: TextField(
                    controller: descriptionTextField,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()),
                  ),
                ),
                Row(
                  children: [
                    Text('Image URL : '),
                  ],
                ),
                Container(
                  height: 80,
                  padding: EdgeInsets.only(top: 5),
                  child: TextField(
                    controller: imgUrlTextField,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createPostRequest();
                        },
                        child: Text('Post'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyMainHomePage()));
                          },
                          child: Text('Cancel')
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
