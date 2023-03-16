import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/database/quotesdatabase.dart';
import 'package:quote_app/widget/note_card_widget.dart';

import 'database/quotesdbmodel.dart';


class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
   List<Note>? notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
print(notes);
    refreshNotes();
  }



  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await QuotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Fav Notes',
        style: TextStyle(fontSize: 24),
      ),
      actions: [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : notes!.isEmpty
          ? Text(
        'No Notes',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildNotes(),
    ),

  );

  Widget buildNotes() => ListView.builder(
    padding: EdgeInsets.all(8),
    itemCount: notes!.length,

    itemBuilder: (context, index) {
      final note = notes![index];

      return GestureDetector(
        onTap: () async {


          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );
}
