import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notes_provider.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  List<String> Notes = ['Hello', 'Okay', 'Yes'];

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                String contentText = "Content of Dialog";
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text("Title of Dialog"),
                      content: Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City Name',
                            hintText: 'Enter Your City Name',
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              context
                                  .read<NotesProvider>()
                                  .setNotes(textEditingController.text.trim());

                              ///
                            });
                          },
                          child: Text("Add"),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                children: List.generate(
                    context.read<NotesProvider>().notes.length, (index) {
                  return Center(
                    child: Container(
                      color: Colors.teal,
                      height: 100,
                      width: 200,
                      child: Center(
                        child: Text(
                          context.watch<NotesProvider>().notes[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }))));
  }
}
