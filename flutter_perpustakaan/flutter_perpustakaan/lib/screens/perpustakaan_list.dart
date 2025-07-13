import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'perpustakaan_detail.dart';
import 'perpustakaan_form.dart';

class PerpustakaanList extends StatefulWidget {
  const PerpustakaanList({super.key});

  @override
  State<PerpustakaanList> createState() => _PerpustakaanListState();
}

class _PerpustakaanListState extends State<PerpustakaanList> {
  List data = [];

  Future<void> fetchData() async {
    final res = await http.get(Uri.parse("http://192.168.120.252:8000/api/perpustakaan"));
    if (res.statusCode == 200) {
      setState(() => data = json.decode(res.body));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void refreshAfterBack() => fetchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Perpustakaan")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          final item = data[i];
          return ListTile(
            title: Text(item['nama_perpustakaan']),
            subtitle: Text(item['alamat']),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PerpustakaanDetail(data: item),
                ),
              );
              refreshAfterBack();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PerpustakaanForm()),
          );
          refreshAfterBack();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}