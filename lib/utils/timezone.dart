class Timezone {
  String value, text;

  Timezone(this.value, this.text);

  void setText(String val) => (this.text = val);
  void setValue(String val) => (this.value = val);

  @override
  String toString() {
    return this.text; //returns just the text
  }
}

class TimezonesContainer {
  List<Timezone> timezones;
  List<String> textzones = [''];

  TimezonesContainer(this.timezones) {
    setText();
  }

  void add(Timezone value) {
    timezones.add(value);
  }

  void remove(Timezone value) {
    timezones.remove(value);
  }

  String getValue(String? val) {
    if (val == null) return '';

    int index = 0;
    for (var s in textzones) {
      if (s == val) break;
      ++index;
    }

    if (index < timezones.length && index > -1)
      return timezones.elementAt(index).value;
    else
      return 'Invalid Index';
  }

  String getText(String? val) {
    for (var s in timezones) {
      if (s.value == val) return s.text;
    }

    return 'Invalid Value';
  }

  void setText() {
    textzones.clear();
    for (Timezone i in timezones) {
      textzones.add(i.text);
    }
  }

  void setTimezones(List<Timezone> value) {
    this.timezones = value;
  }
}
