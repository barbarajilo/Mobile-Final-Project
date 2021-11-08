//import 'dart:async';
import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:final_project/postdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/signin_cubit.dart';
import 'package:web_socket_channel/io.dart';

import 'aboutpage.dart';

class MyMainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (context) => SignInCubit(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
  late final signInBloc;
  List _items = [];

  void readAPI() async {
    channel.stream.listen((event) {
      final decodedMessage = jsonDecode(event);
      final posts = decodedMessage['data']['posts'];
      List tempList = [];
      posts.forEach((data) => {tempList.add(data)});

      setState(() {
        _items = tempList;
      });
      print(_items);
    });
    channel.sink
        .add('{"type": "get_posts", "data": {"lastId": "", "sortBy": "date"}}');
  }

  @override
  void initState() {
    super.initState();
    readAPI();
    signInBloc = BlocProvider.of<SignInCubit>(context);
    signInBloc.generatePost();
    signInBloc.getPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BeSquare Feed')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('About'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                              elevation: 10,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child: Image(
                                            image: NetworkImage(
                                                _items[index]["image"]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 8),
                                                  child: Text(
                                                    _items[index]["title"],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 8),
                                                  child: Text(
                                                    _items[index]
                                                        ["description"],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 8),
                                                  child: Text(
                                                    _items[index]["date"],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: FavoriteButton(
                                                  iconSize: 40.0,
                                                  isFavorite: false,
                                                  // iconDisabledColor: Colors.white,
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite : $_isFavorite');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]))),
                          onTap: () {
                            final textTitle = _items[index]["title"];
                            final textDescription = _items[index]["description"];
                            final textImage = _items[index]["image"];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PostCardDetails(title: textTitle, description: textDescription, image: textImage)));
                          },
                        );
                      }))
              : Container()
        ],
      ),
    );
  }
}
