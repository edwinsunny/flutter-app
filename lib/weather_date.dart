import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class Weather {
  String main;
  String description;

  Weather({required this.main, required this.description});
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  String main="";
  String description="";
  double lat=0;
  double long=0;
  String city="";
  bool showResults=false;
  String temp="";
  Future weatherData() async {
    var request = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=49a280a14e84a6f2c21ccb3f1fa50ce3'));
    // var request =  http.Request('GET', Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=islamabad&appid=49a280a14e84a6f2c21ccb3f1fa50ce3')
    // );

// var result=jsonDecode(request.body);

if(request.statusCode==200){
  print("getting result is ${request.body}");
  var result = jsonDecode(request.body);
  print(result['weather'][0]['main'].toString());
  main=result['weather'][0]['main'].toString();
  description=result['weather'][0]['description'].toString();
  temp=result['main']['temp'].toString();
}
else{
  Alert(
    context: context,
    type: AlertType.error,
    title: "ALERT",
    desc: "Selected City Doesnt exist.",
    buttons: [
      DialogButton(
        child: Text(
          "COOL",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
    // setState(() {
    //
    //   // lat=result['coord'][0]['lat'];
    //   // long=result['coord'][0]['lon'];
    //
    // });
    // http.StreamedResponse response = await request.send();

    // if (request.statusCode == 200) {
    //   print(response);
    //   // var result=jsonDecode(response);
    //   // print(await response.stream.bytesToString());
    // }
    // else {
    //   print(response.reasonPhrase);
    // }
    return true;
  }

  TextEditingController cityController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // weatherData();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/w.jpeg',
                ),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City Name',
                    hintText: 'Enter Your City Name',
                  ),
                ),
              ),
              ElevatedButton(onPressed: () async{
                setState(() {
                  city=cityController.text.trim();
                  showResults=true;
                });



              }, child: Text('Check Weather')),

              showResults?FutureBuilder(
                builder: (ctx, snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data;
                      return SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Weather: ${main}',
                                style: TextStyle(fontSize: 18,
                                color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Detail Weather: ${description}',
                                style: TextStyle(fontSize: 18,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Temperature: ${temp}',
                                style: TextStyle(fontSize: 18,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },

                // Future that needs to be resolved
                // inorder to display something on the Canvas
                future: weatherData(),
              ):Container(),

              // ElevatedButton(onPressed: () async{
              //   await weatherData();
              //
              // }, child: Text('get Data'))
            ],
          ),
        ),
      ),
    );
  }
}
