class Timezone {
  String value, text;

  Timezone(this.value, this.text);

  void setText(String val) => (text = val);
  void setValue(String val) => (value = val);

  @override
  String toString() {
    return text; //returns just the text
  }
}

class TimezonesContainer {
  List<Timezone> timeZones;
  List<String> textZones = [''];

  TimezonesContainer(this.timeZones) {
    setText();
  }

  void add(Timezone value) {
    timeZones.add(value);
  }

  void remove(Timezone value) {
    timeZones.remove(value);
  }

  String getValue(String? val) {
    if (val == null) return '';
    int index = 0;
    for (var s in textZones) {
      if (s == val) break;
      ++index;
    }

    if (index < timeZones.length && index > -1) {
      return timeZones.elementAt(index).value;
    } else {
      return 'Invalid Index';
    }
  }

  String getText(String? val) {
    for (var s in timeZones) {
      if (s.value == val) return s.text;
    }

    return 'Invalid Value';
  }

  void setText() {
    textZones.clear();
    for (Timezone i in timeZones) {
      textZones.add(i.text);
    }
  }

  void setTimezones(List<Timezone> value) {
    timeZones = value;
  }
}
