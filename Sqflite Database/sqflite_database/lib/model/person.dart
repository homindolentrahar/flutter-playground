class Person {
  int _id;
  String _name;
  int _age;

  Person(this._name, this._age);

  int get id => _id;

  String get name => _name;

  int get age => _age;

  set name(String value) {
    _name = value;
  }

  set age(int value) {
    _age = value;
  }

  Person.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._age = map['age'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'age': _age,
    };
  }
}
