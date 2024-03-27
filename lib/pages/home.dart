import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? data = {};

  @override
  Widget build(BuildContext context) {
    data = data!.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map?;
    // print(data);

    //set background
    String bgImage = data?['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data?['isDaytime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
          child: SafeArea(
              child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag']
                    };
                  });
                },
                child: const Icon(
                  Icons.edit_location,
                  color: Color.fromARGB(255, 222, 220, 220),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data?['location'],
                    style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                data?['time'],
                style: TextStyle(fontSize: 66.0, color: Colors.white),
              )
            ],
          )),
        ),
      ),
    );
  }
}
