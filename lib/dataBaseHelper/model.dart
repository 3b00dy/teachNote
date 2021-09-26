class Model {
  String _noteTitle, _noteContent;
  int _id, _sid;
  Model(dynamic obj) {
    _id = obj['ID'];
    _noteTitle = obj['NoteTitle'];
    _noteContent = obj['NoteContent'];
    _sid = obj['SID'];
  }
  Model.fromMap(Map<String, dynamic> data) {
    _id = data['ID'];
    _noteTitle = data['NoteTitle'];
    _noteContent = data['NoteContent'];
    _sid = data['SID'];
  }
  Map<String, dynamic> toMap() => {
        'ID': _id,
        'NoteTitle': _noteTitle,
        'NoteContent': _noteContent,
        'SID': _sid
      };
  int get id => _id;
  String get noteTitle => _noteTitle;
  String get noteContent => _noteContent;
  int get sid => _sid;
}
