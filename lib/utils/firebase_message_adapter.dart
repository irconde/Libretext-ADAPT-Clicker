import 'package:hive/hive.dart';
import 'firebase_message.dart';

class FirebaseMessageAdapter extends TypeAdapter<FirebaseMessage> {
  @override
  final typeId = 0; // Should be unique across your application

  @override
  FirebaseMessage read(BinaryReader reader) {
    return FirebaseMessage(
      title: reader.readString(),
      body: reader.readString(),
      route: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, FirebaseMessage obj) {
    writer.writeString(obj.title!);
    writer.writeString(obj.body!);
    writer.writeString(obj.route ?? '');
  }
}
