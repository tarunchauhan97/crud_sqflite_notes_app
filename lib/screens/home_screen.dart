import 'package:crud_sqflite_notes_app/database/database.dart';
import 'package:crud_sqflite_notes_app/models/note_model.dart';
import 'package:crud_sqflite_notes_app/screens/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> _noteList;
  final DateFormat _dateFormatter = DateFormat('MMM dd,yyyy');
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _updateNoteList();
  }

  _updateNoteList() {
    _noteList = DatabaseHelper.instance.getNoteList();
  }

  Widget _buildNote(Note note) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              note.title!,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: note.status == 0 ? TextDecoration.none : TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text(
              '${_dateFormatter.format(note.date!)} - ${note.priority}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: note.status == 0 ? TextDecoration.none : TextDecoration.lineThrough,
              ),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                note.status == value! ? 1 : 0;
                DatabaseHelper.instance.updateNote(note);
                _updateNoteList();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              activeColor: Theme.of(context).primaryColor,
              value: note.status == 1 ? true : false,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddNoteScreen(
                    // updateNoteList: _updateNoteList(),
                    // note:note,
                    ),
              ),
            ),
          ),
          Divider(height: 1, thickness: 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: _noteList,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final int completedNoteCount =
                snapshot.data.where((Note note) => note.status == 1).toList().length;

            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 80),
                itemCount: int.parse(snapshot.data.length.toString()) + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Notes',
                              style: TextStyle(color: Colors.deepPurple, fontSize: 40.0)),
                          SizedBox(height: 10.0),
                          Text('${completedNoteCount} of ${snapshot.data.length}',
                              style: TextStyle(color: Colors.deepPurple, fontSize: 30.0)),
                        ],
                      ),
                    );
                  }
                  return _buildNote(snapshot.data[index - 1]);
                });
          }),
    );
  }
}
