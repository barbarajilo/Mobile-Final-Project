import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:final_project/data_structure/postcard_struct.dart';
import 'package:web_socket_channel/io.dart';


class SignInCubit extends Cubit<String> {
  SignInCubit() : super('');
  List<String> _newsFeed = [];

  //establish connection to the API server
  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  void connection(username) => {emit(username)};
  void loginRequest(String username) =>
      {channel.sink.add('{"type": "sign_in", "data":{"name" : $String}}')};
  void generatePost() => {
        channel.sink
            .add('{"type": "get_posts", "data": {"lastId": "", "sortBy": ""}}')
      };

  void getPost() => {
        channel.stream.listen((message) {
          final decodedMessage = jsonDecode(message);

          //this is checking if key type have value of all_post
          print(decodedMessage);
          List<PostCardStruct> postCardItems = [];
          if (decodedMessage["type"] == 'all_posts') {
            //with every forEach, need (incoming_data) => {*your operation here}
            decodedMessage["data"]["posts"].forEach((data) => {
                  postCardItems.add(PostCardStruct(
                      id: data["_id"],
                      title: data["title"],
                      description: data["description"],
                      imageUrl: data["imageUrl"],
                      date: data["date"],
                      author: data["author"]))
                });

            //verify example of first 10 data
            for (int i = 0; i < 20; i++) {
              print(postCardItems[i]);
            }
          }
          //channel.sink.close();
        }),
        print(_newsFeed)
      };
}
