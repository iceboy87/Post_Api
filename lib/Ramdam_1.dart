import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Classes/Ramndam.dart';

class Randam extends StatefulWidget {
  const Randam({super.key});

  @override
  State<Randam> createState() => _RandamState();
}

class _RandamState extends State<Randam> {

  Future<List<Results>> Fatch()async{
    var resp =await http.get(Uri.parse("https://randomuser.me/api"));
    var data=jsonDecode(resp.body)["results"];
    return (data as List).map((e) => Results.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Fatch(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            List<Results>filter = snapshot.data!;
            return ListView.builder(
                itemCount: filter!.length,
                itemBuilder: (BuildContext context,  index){
                  return Column(
                    children: [
                      // Text(filter[index]!.name.toString()),
                      // Text(filter[index]!.location.toString()),
                      Text("-----------"),
                      Text(filter[index]!.name!.first.toString()),
                      Text(filter[index]!.name!.title.toString()),
                      Text(filter[index]!.name!.last.toString()),
                      Text(filter[index]!.picture.toString()),
                      Text(filter[index]!.email.toString()),
                      Text(filter[index]!.dob.toString()),


                    ],
                  );
                }

            );

          }
          else if (snapshot.hasError)
            return Text('${snapshot.error}');
          return CircularProgressIndicator();

        },
      ),
    );
  }
}
