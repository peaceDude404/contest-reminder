import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contest_data.dart';

class hackerearth extends StatelessWidget {
  const hackerearth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isloaded = false;
    List<ContestData>? data;
    Future<List<ContestData>?> cfcall() async {
      http.Response response;
      response =
          await http.get(Uri.parse("https://kontests.net/api/v1/hacker_earth"));
      if (response.statusCode == 200) {
        return contestDataFromJson(response.body);
      }
    }

    Future<String> getData() async {
      data = await cfcall();
      if (data != null) {
        isloaded = true;
        print(isloaded);
      }
      return "";
    }

    String isearly(String in24) {
      if (in24 == "Yes") {
        return "Within 24 hours!!";
      } else {
        return "After 24 hours";
      }
    }

Widget value(){
      return FutureBuilder<String>(
  future: getData(), // a Future<String> or null
  builder: (context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none: return new Text('Press button to start');
      case ConnectionState.waiting: return new Text('Awaiting result...');
      default:
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        else
          return Visibility(
          visible: isloaded,
          child: ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Contest : ${data![index].name}", style: TextStyle(color: Colors.white),),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Start Time : ${data![index].startTime}", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Duration : ${double.parse(data![index].duration) / (3200 )} hour", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                    Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(isearly(data![index].in24Hours), style: TextStyle(color: Colors.white),),
                    ),
                  ],
                )
              ),
            );
          }),
          // replacement: const Center(child: CircularProgressIndicator(),),
        );
    }
  },
);
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('HackerEarth', style: TextStyle(color: Colors.white)),
        ),
        body: value(),
      )
    );
  }
}
