import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quote_app/Myfavpage.dart';
import 'package:quote_app/Quotemodel.dart';
import 'package:quote_app/database/quotesdatabase.dart';

import 'database/quotesdbmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;


String? authorname;
String? quote;
String? tage;
  Future<List<Quote>?> getQuotes() async {
    List<Quote>? list;
    final response =
    await http.get(Uri.parse(
        'https://6411c6eb37c88aa434a151e5.mockapi.io/quotes/api/quotes'),
     );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<Quote>((json) => Quote.fromJson(json)).toList();
      print("List Size: ${list.length}");
      print(list[0].quotes);
      print(list[0].author_name);
      return list;
    }
    return null;
  }

 Future addNote() async {
    final note = Note(
      title: authorname.toString(),
      isImportant: true,
      createdTime: DateTime.now(),
      tag:tage.toString(),
      quotes:quote.toString(),
    );

    await QuotesDatabase.instance.create(note);

  }

 @override
  void initState() {
    getQuotes();
    super.initState();
  }

  Widget QuotesList(List<Quote> quotes){
    return PageView.builder(
        itemCount: quotes.length,
        controller: PageController(viewportFraction: 1),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return Transform.scale(
              scale: i == _index ? 1 : 0.9,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child:Card(

                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(top:10,left: 10,right: 5,bottom: 40),
                    title:Text("Author : "+quotes[i].author_name.toString()),
                    subtitle:Padding(
                      padding: EdgeInsets.only(top:30),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[Text("Quote : "+quotes[i].quotes.toString()),
                        Text("Tag : "+quotes[i].tag.toString()),]),
                    ),
                    trailing: ElevatedButton(child:Icon(Icons.save_alt),onPressed: () async{ setState(() {

                      authorname=quotes[i].author_name;
                      quote=quotes[i].quotes ;
                      tage=quotes[i].tag;
                    });
                     await addNote();
                   if(!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorite')),
                    );
          },),
                  ),

                ),

              ));
        });

  }
  buildList(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getQuotes(),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? QuotesList(snapshot.data as List<Quote>)
                  : Center(child: CircularProgressIndicator());
            }));
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children:[ SizedBox(
    height: 200, // card height
    child:buildList(context)),
      ElevatedButton(onPressed: () async{
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FavPage()),
        );
      }, child: Text("My Fav"))])));
    }
}
