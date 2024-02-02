import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/ana_ekran.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/KayitOlmaEkrani.dart';
import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/VeritabaniYonetimi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});
  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}


class _GirisEkraniState extends State<GirisEkrani>{
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  final VeritabaniYonetimi _veritabaniYonetimi = VeritabaniYonetimi();


  Future<bool> girisKontrolEt(String kullaniciAdi, String sifre) async {
    Database db = await openDatabase('meditasyon_veritabani.db');
    List<Map<String, dynamic>> sonuc = await db.rawQuery(
        'SELECT COUNT(*) FROM kullanicilar WHERE kullaniciAdi = ? AND sifre = ?', [kullaniciAdi, sifre]);

    int? sayi = Sqflite.firstIntValue(sonuc);
    return sayi != null && sayi > 0;
  }

  void _girisHataDialogGoster(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: const Text('Geçersiz kullanıcı adı veya şifre.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }



  Future<void> _girisYap(BuildContext context) async {
    String kullaniciAdi = _kullaniciAdiController.text.trim();
    String sifre = _sifreController.text.trim();

    //setstorage

    bool gecerliKullanici = await girisKontrolEt(kullaniciAdi, sifre);

    if (gecerliKullanici) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  AnaEkran())
      );
    } else {
      _girisHataDialogGoster(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          'Ruh Durağı',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24.0,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        shadowColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextFormField(
                 controller: _kullaniciAdiController,
                decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                ),
              ),
               TextFormField(
                 controller: _sifreController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                ),
              ),
               const SizedBox(height: 20),
              ElevatedButton(
                  onPressed:() async {
                    await _girisYap(context);
                  },
                  child: const Text('Giriş yap',
                    style: TextStyle(color: Colors.blueAccent),
                  )
              ),


              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const KayitOl())
                  );
                },
                child: const Text('Hesabınız yok mu? Kayıt Ol',
                  style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
