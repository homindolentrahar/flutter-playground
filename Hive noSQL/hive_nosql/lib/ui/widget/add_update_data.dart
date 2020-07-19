import 'package:flutter/material.dart';
import 'package:hive_nosql/model/mahasiswa.dart';

class AddUpdateData extends StatefulWidget {
  final int index;
  final Mahasiswa mahasiswa;
  final Function addData;
  final Function updateData;

  AddUpdateData({this.index, this.mahasiswa, this.addData, this.updateData});

  @override
  _AddUpdateDataState createState() => _AddUpdateDataState();
}

class _AddUpdateDataState extends State<AddUpdateData> {
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();

  @override
  void initState() {
    if (widget.mahasiswa != null) {
      _nimController.text = widget.mahasiswa.nim.toString();
      _namaController.text = widget.mahasiswa.nama;
      _jurusanController.text = widget.mahasiswa.jurusan;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonTheme(
              minWidth: 60,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                elevation: 0,
                child: Icon(
                  widget.mahasiswa == null ? Icons.save : Icons.update,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (widget.mahasiswa == null) {
                    final mahasiswa = Mahasiswa(
                      nim: int.parse(_nimController.text),
                      nama: _namaController.text,
                      jurusan: _jurusanController.text,
                    );

                    widget.addData(mahasiswa);
                  } else {
                    widget.mahasiswa.nim = int.parse(_nimController.text);
                    widget.mahasiswa.nama = _namaController.text;
                    widget.mahasiswa.jurusan = _jurusanController.text;

                    widget.updateData(widget.index, widget.mahasiswa);
                  }

                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: "NIM",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _jurusanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Jurusan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
