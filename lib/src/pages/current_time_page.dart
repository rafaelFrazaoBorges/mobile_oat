
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';


class CurrentTime extends StatefulWidget {
  const CurrentTime({super.key});

  @override
  CurrentTimeState createState() => CurrentTimeState();
}

class CurrentTimeState extends State<CurrentTime> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentTime();
  }

  void _fetchCurrentTime() async {
    var url = Uri.parse('http://worldtimeapi.org/api/timezone/America/Sao_Paulo');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dateTime = DateTime.parse(data['datetime']);
      var formatter = DateFormat('HH:mm:ss');
      setState(() {
        currentTime = formatter.format(dateTime);
      });
    } else {
      setState(() {
        currentTime = 'Erro ao obter a hora atual';
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _fetchCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hora Atual em São Paulo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hora atual em São Paulo, Brasil:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              currentTime,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
