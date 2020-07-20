// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mahasiswa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MahasiswaAdapter extends TypeAdapter<Mahasiswa> {
  @override
  final typeId = 0;

  @override
  Mahasiswa read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mahasiswa(
      nim: fields[0] as int,
      nama: fields[1] as String,
      jurusan: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mahasiswa obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nim)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.jurusan);
  }
}
