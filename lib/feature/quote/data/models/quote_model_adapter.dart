// Manually written Hive TypeAdapter for QuoteModel
// This avoids requiring build_runner if you prefer a quick, explicit adapter.
import 'package:hive/hive.dart';
import 'quote_model.dart' show QuoteModel;

class QuoteModelAdapter extends TypeAdapter<QuoteModel> {
  @override
  final int typeId = 0;

  @override
  QuoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return QuoteModel(
      q: fields[0] as String,
      a: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.q)
      ..writeByte(1)
      ..write(obj.a);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) || other is QuoteModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
