import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsList(),
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<dynamic> articles = [];

  Future<void> getNews() async {
    String apiKey = '9ae0052af30f45efa244f1297d84d34c'; 
    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        articles = jsonData['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: articles[index]['urlToImage'] != null
                ? Image.network(
                    articles[index]['urlToImage'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.image),
            title: Text(articles[index]['title']),
            subtitle: Text(articles[index]['description'] ?? ''),
            onTap: () {
            
            },
          );
        },
      ),
    );
  }
}