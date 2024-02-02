import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotModelleri/Not_modeli.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotVeritabani/notveritabani.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotlarEkranlar/NotlarAnaEkran.dart';


class NotlariGoster extends StatelessWidget {
  final NotModeli notModeli;

  const NotlariGoster({Key? key, required this.notModeli}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notunuz"),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(icon: const Icon(Icons.delete),
            onPressed: (){
            NotVeritabani.notdb.notuSil(notModeli.baslik);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotlarAnaEkran())
            );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notModeli.baslik ?? '',
                  style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    notModeli.body ?? '',
                    style: const TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
