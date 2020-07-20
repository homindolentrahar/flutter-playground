import 'package:hive/hive.dart';

part 'mahasiswa.g.dart';

@HiveType(typeId: 0)
class Mahasiswa {
  @HiveField(0)
  int nim;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String jurusan;

  Mahasiswa({this.nim, this.nama, this.jurusan});
}
