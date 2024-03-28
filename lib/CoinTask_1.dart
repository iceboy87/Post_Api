import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:new_api/Classes/CoinTask.dart';

class coin extends StatefulWidget {
  const coin({super.key});

  @override
  State<coin> createState() => _coinState();
}

class _coinState extends State<coin> {
  Future <CoinTask>? _future;
  Future <CoinTask> Fach() async{
    var resp = await http.get(Uri.parse(
        "https://api.coindesk.com/v1/bpi/currentprice.json"));
    var data = jsonDecode(resp.body);
    return CoinTask.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future =Fach();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CoinTask>(
        future: _future,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return Column(
              children: [
                Text(jsonEncode(snapshot.data!).toString()),
              ],
            );
          } else if (snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return Text("Loading");
        },
      ),
    );
  }
}
