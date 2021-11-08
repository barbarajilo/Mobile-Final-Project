import 'package:final_project/homepage.dart';
import 'package:final_project/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (context) => SignInCubit(),
        child: MyHomePage(title: 'BeSquare App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _usernameValue = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _usernameValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/besquare_logo.png",
                  height: 180,
                  width: 180,
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _usernameValue,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'USERNAME',
                        labelStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                        errorText: _validate ? 'Field cannot be empty' : null),
                  ),
                ),

                ElevatedButton(
                    onPressed: () => {
                          context
                              .read<SignInCubit>()
                              .connection(_usernameValue.text),

                          setState(() {
                          _usernameValue.text.isEmpty ? _validate = true : _validate = false;
                          }), //field checking to avoid empty field

                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainHomePage()),
                          ), //navigate to another page
                        },
                    child: Text('Login to Besquare')),
              ]),
        ));
  }
}
