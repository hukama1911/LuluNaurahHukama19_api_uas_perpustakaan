import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'perpustakaan_form.dart';
import 'package:http/http.dart' as http;

class PerpustakaanDetail extends StatelessWidget {
  final dynamic data;
  const PerpustakaanDetail({super.key, required this.data});

  Future<void> hapusData(BuildContext context) async {
    final res = await http.delete(
      Uri.parse("http://192.168.120.252:8000/api/perpustakaan/${data['id']}"),
    );
    if (res.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil dihapus")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(
      double.parse(data['latitude']),
      double.parse(data['longitude']),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(data['nama_perpustakaan']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PerpustakaanForm(data: data)),
              );
              Navigator.pop(context); // kembali ke list dan trigger fetch
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => hapusData(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Alamat: ${data['alamat']}"),
            subtitle: Text("No Telp: ${data['no_telepon']}\nTipe: ${data['tipe']}"),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Lokasi:", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('lokasi'),
                  position: location,
                  infoWindow: InfoWindow(title: data['nama_perpustakaan']),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}