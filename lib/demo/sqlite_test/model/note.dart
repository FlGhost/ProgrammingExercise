//class to represent database table

class Note {
  // underscore '_' means private
  int? _id;
  String _title = '';
  String? _desc;
  String _date = '';
  int _priority = 0;

  //standard constructor
  Note(
      {int? id,
      required String title,
      String? desc,
      required int priority,
      required String date})
      : _id = id,
        _title = title,
        _desc = desc,
        _priority = priority,
        _date = date;

  //constructor with only id - named constructor
  //Note.withId(this._id, this._title, this._date, this._priority, [this._desc]);

  //getter
  int get priority => _priority;

  String get date => _date;

  String? get desc => _desc;

  String get title => _title;

  int? get id => _id;

  //setter
  //id cannot be changed
  set priority(int value) {
    if (value >= 1 && value <= 2) {
      _priority = value;
    }
  }

  set date(String value) {
    _date = value;
  }

  set desc(String? value) {
    if (value == null || value.length <= 255) {
      _desc = value;
    }
  }

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

  //function def to convert note obj -> map (sqlite)
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['desc'] = _desc;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //extract note obj from map obj
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _desc = map['desc'];
    _priority = map['priority'];
    _date = map['date'];
  }
}
