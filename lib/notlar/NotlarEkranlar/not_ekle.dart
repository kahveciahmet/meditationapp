import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotModelleri/Not_modeli.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotVeritabani/notveritabani.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotlarEkranlar/NotlarAnaEkran.dart';

class NotEkle extends StatefulWidget {
  const NotEkle({super.key});

  @override
  State<NotEkle> createState() => _NotEkleState();
}

class _NotEkleState extends State<NotEkle> {


  String? baslik;
  String? body;
  DateTime? olusturma_zamani;

  TextEditingController baslikController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  NotEkle(NotModeli notModeli){
    NotVeritabani.notdb.yeniNotEkle(notModeli);
    print("Not başarıyla eklendi");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni bir not ekle"),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: baslikController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Not Başlığı",
              ),
              style: const TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
                  controller: bodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Notunuz",
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            baslik = baslikController.text;
            body = bodyController.text;
            olusturma_zamani = DateTime.now(); // Şu anki zamanı temsil eden DateTime nesnesi
          });

          NotModeli notModeli = NotModeli(
            baslik: baslik,
            body: body,
            olusturma_zamani: olusturma_zamani.toString(), // DateTime'ı String'e dönüştürdük
          );

          NotVeritabani.notdb.yeniNotEkle(notModeli);
          print("Not başarıyla eklendi");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotlarAnaEkran()),
          );
        },
        label: const Text("Notu Kaydet"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
