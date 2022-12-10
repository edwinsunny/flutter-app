import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier{
  List<String> _notes=['Hello',
  'yes',
    'no'
  ];

  List<String> get notes=>_notes;

  setNotes(String not){
    _notes.add(not);
    notifyListeners();
  }


}