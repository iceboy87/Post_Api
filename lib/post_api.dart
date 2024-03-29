import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class post_api extends StatefulWidget {
  const post_api({super.key});

  @override
  State<post_api> createState() => _post_apiState();
}

class _post_apiState extends State<post_api> {


  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  Future<bool>? _success;
  Future<bool> addcategory(String catname, String desc) async {
    var res = await http.post(
      Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=utf-8'
      },
      body: jsonEncode(<String, dynamic>{
        "categoryId": 0,
        "category": catname,
        "description": desc,
        "createdBy": 1
      })
    );
    return jsonDecode(res.body)["success"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (_success == null ? buildColumn() : buildFuturebuilder()),
          )
        ],
      ),
    );
  }

  Column buildColumn(){
    return Column(
      children: [
        TextFormField(
          controller: category,
          decoration: InputDecoration(
            label: Text("enter category"),
          ),
        ),
        TextFormField(
          controller: description,
          decoration: InputDecoration(
            label: Text("enter category"),
          ),
        ),
        ElevatedButton(
            onPressed: (){
              setState(() {
                _success = addcategory(category.text,description.text);
              });
            },
            child: Text("save"),
        )
      ],
    );
  }


  FutureBuilder buildFuturebuilder(){
    return FutureBuilder(
        future: _success,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Text("added succesfully");
          } else if(snapshot.hasError){
            return Text("${snapshot.error}");
          } return CircularProgressIndicator();
        }
    );
  }
}
