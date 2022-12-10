import 'package:apiproject/calculator.dart';
import 'package:apiproject/note_app.dart';
import 'package:apiproject/weather_date.dart';
import 'package:flutter/material.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  WeatherPage()),
                    );

                  },
                  child: Container(
                    color: Colors.blue,
                    height: 150,
                    width: 150,
                    child: Center(child: Text('Weather')),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Calculator()),
                  );

                },
                child: Container(
                  color: Colors.blue,
                  height: 150,
                  width: 150,
                  child: Center(child: Text('Calculator')),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoteApp()),
                );

              },
              child: Container(
                color: Colors.blue,
                height: 150,
                width: 150,
                child: Center(child: Text('Notes')),
              ),
            ),
            // Row(
            //   children: [
            //
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //
            //
            //   ],
            // ),
          ],
        ),

      ),
    );
  }
}
