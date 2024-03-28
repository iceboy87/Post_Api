import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Classes/PostApi.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {

  Future<Post>? _future;

  TextEditingController textcat = TextEditingController();
  TextEditingController text = TextEditingController();

  Future<Post> AddNewCategory(String cate, String desc) async {
    var resp = await http.post(Uri.parse(
        "http://catodotest.elevadosoftwares.com/category/insertcategory"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "categoryId": 706,
          "category": "test",
          "description": "Dress",
          "deletedOn": null,
          "removedRemarks": null,
          "createdBy": "1"
        })
    );
    var data = jsonDecode(resp.body);
    return Post.fromJson(data);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'new Post Api',
      home: Scaffold(
        body: Container(
          child: (_future == null) ? buildColum() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColum() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: textcat,
          decoration: InputDecoration(hintText: "enter the Category"),
        ),
        TextFormField(
          controller: text,
          decoration: InputDecoration(hintText: "enter the Category"),
        ),
        ElevatedButton(onPressed: () {
          setState(() {
            _future = AddNewCategory(textcat.text, text.text);
          });
        }, child: Text("Click"))

      ],
    );
  }
  FutureBuilder<Post> buildFutureBuilder(){
    return
      FutureBuilder<Post>(
        future: _future, builder: (context,snapshot){
      if (snapshot.hasData){
        if(snapshot.data!.success == true){
          return Text("Added Successfully");
        }
        else{
          return Text("Not Added");
        }
      }
      else if(snapshot.hasError){
        return Text("${snapshot.error}");

      }
      return const CircularProgressIndicator();
    });
  }
}

