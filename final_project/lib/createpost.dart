import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';


class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _titleTextField = TextEditingController();
  final _descriptionTextField = TextEditingController();
  final _imgUrlTextField = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleTextField.dispose();
    _descriptionTextField.dispose();
    _imgUrlTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PostCard Page'),
      ),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              const Text('Title'),
              TextFormField(
                controller: _titleTextField,
                maxLines: 1,
              ),
              const Text('Description'),
              TextFormField(
                controller: _descriptionTextField,
                maxLines: 10,
              ),
              const Text('Image Url'),
              TextFormField(
                controller: _imgUrlTextField,
                maxLines: 1,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
        ],
      )]));
  }
}