import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Parcial3 extends StatefulWidget {
  const Parcial3({Key? key}) : super(key: key);

  @override
  _Parcial3State createState() => _Parcial3State();
}

class _Parcial3State extends State<Parcial3> {
  late Future<List<Apod>> apodList;

  @override
  void initState() {
    super.initState();
    apodList = _fetchApodList();
  }

  Future<List<Apod>> _fetchApodList() async {
    final response = await http.get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?count=30&api_key=Fu4fyndsKezf2DcNzklirWZJ9mi0brbtJnCvZ2E8'));
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => Apod.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load apod list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA APOD List'),
      ),
      body: Center(
        child: FutureBuilder<List<Apod>>(
          future: apodList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final apodList = snapshot.data!;
              return ListView.builder(
                itemCount: apodList.length,
                itemBuilder: (context, index) {
                  final apod = apodList[index];
                  return _buildApodListItem(apod);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildApodListItem(Apod apod) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _buildApodImage(apod.url),
          SizedBox(width: 10),
          _buildApodDetails(apod.title, apod.date),
        ],
      ),
    );
  }

  Widget _buildApodImage(String url) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildApodDetails(String title, String date) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Apod {
  final String url;
  final String title;
  final String date;

  Apod({
    required this.url,
    required this.title,
    required this.date,
  });

  factory Apod.fromJson(Map<String, dynamic> json) {
    return Apod(
      url: json['url'],
      title: json['title'],
      date: json['date'],
    );
  }
}
