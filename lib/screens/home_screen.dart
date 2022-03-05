import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildNote(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Note Title'),
            subtitle: Text('Aug 16, 2021 -High'),
            trailing: Checkbox(
                onChanged: (value) {
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true),
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 80),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Notes', style: TextStyle(color: Colors.deepPurple, fontSize: 40.0)),
                    SizedBox(height: 10.0),
                    Text('0 - 10', style: TextStyle(color: Colors.deepPurple, fontSize: 30.0)),
                  ],
                ),
              );
            }
            return _buildNote(index);
          }),
    );
  }
}
