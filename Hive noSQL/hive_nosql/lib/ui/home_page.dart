import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_nosql/main.dart';
import 'package:hive_nosql/model/mahasiswa.dart';
import 'package:hive_nosql/ui/widget/add_update_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Mahasiswa> _mahasiswaBox;

  @override
  void initState() {
    _mahasiswaBox = Hive.box(boxName);
    super.initState();
  }

  @override
  void dispose() {
    _mahasiswaBox.compact();
    _mahasiswaBox.close();
    super.dispose();
  }

  void _showBottomSheet(int index, Mahasiswa mahasiswa) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      )),
      builder: (ctx) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddUpdateData(
          index: index,
          mahasiswa: mahasiswa,
          addData: _addData,
          updateData: _updateData,
        ),
      ),
    );
  }

  void _addData(Mahasiswa mahasiswa) {
    if (mahasiswa.nim == null ||
        (0 <= mahasiswa.nim && mahasiswa.nim < 8) ||
        mahasiswa.nama == null ||
        mahasiswa.nama == "" ||
        mahasiswa.jurusan == null ||
        mahasiswa.jurusan == "") {
      return;
    }

    _mahasiswaBox.add(mahasiswa);
  }

  void _updateData(int index, Mahasiswa mahasiswa) {
    _mahasiswaBox.putAt(index, mahasiswa);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Mahasiswa",
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: _mahasiswaBox.listenable(),
          builder: (ctx, Box<Mahasiswa> box, _) {
            List<int> keys = box.keys.cast<int>().toList();

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              physics: BouncingScrollPhysics(),
              itemCount: keys.length,
              itemBuilder: (ctx, index) {
                final key = keys[index];
                final mahasiswa = box.get(key);

                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: () {
                        box.deleteAt(index);
                      },
                    ),
                  ],
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      mahasiswa.nama,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          mahasiswa.nim.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          mahasiswa.jurusan,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showBottomSheet(index, mahasiswa),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _showBottomSheet(null, null),
        ),
      ),
    );
  }
}
