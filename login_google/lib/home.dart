import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key,required dynamic this.user_data});

  final dynamic user_data;
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(backgroundColor:Colors.blue,title: Text("Abhinav MIS"),leading: IconButton(icon: Icon(Icons.menu),onPressed: (){_scaffoldkey.currentState?.openDrawer();},),),
      body: SafeArea(
        child: Column(children: <Widget>[
          Text("")
        ],),
      ),
      drawer: Drawer(child: SafeArea(
        child: Column(children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(widget.user_data.photo_URL),)
        ],),
      ),),
    );
  }
}