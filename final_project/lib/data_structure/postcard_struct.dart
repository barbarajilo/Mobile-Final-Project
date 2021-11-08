//import 'package:final_project/postdetails.dart';

class PostCardStruct {
  String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String author;
  bool favorite;

  PostCardStruct({
    this.id = "",
    this.title = "",
    this.description = "",
    this.imageUrl = "",
    this.date = "",
    this.author = "",
    this.favorite = false,
  });
}
