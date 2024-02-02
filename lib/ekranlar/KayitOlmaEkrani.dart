import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class KayitOl extends StatefulWidget {
  const KayitOl({super.key});

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _isimController = TextEditingController();
  final TextEditingController _soyIsimController = TextEditingController();

  Future<bool> kontrolEt(String kullaniciAdi, String email) async {
    Database db = await openDatabase('meditasyon_veritabani.db');

    List<Map<String, dynamic>> sonuclar = await db.rawQuery(
        'SELECT COUNT(*) FROM kullanicilar WHERE kullaniciAdi = ? OR email = ?',
        [kullaniciAdi, email]
    );

    int sayi = Sqflite.firstIntValue(sonuclar) ?? 0;

    return sayi > 0;
  }


  void _hataDialogGoster(String hataMesaji) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: Text(hataMesaji),
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



  Future<void> _kayitOl() async {
    String kullaniciAdi = _kullaniciAdiController.text;
    String sifre = _sifreController.text;
    String email = _emailController.text;
    String isim = _isimController.text;
    String soyIsim = _soyIsimController.text;
    bool hata = await kontrolEt(kullaniciAdi, email);

    if (hata) {
      _hataDialogGoster('Bu kullanıcı adı veya e-posta zaten kullanımda.');
    } else {

      Database db = await openDatabase('meditasyon_veritabani.db');
      await db.insert('kullanicilar', {
        'kullaniciAdi': kullaniciAdi,
        'sifre': sifre,
        'email': email,
        'isim': isim,
        'soyIsim': soyIsim,
      });

      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Ol"),
        backgroundColor: Colors.blue[500],
        elevation: 10.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children:<Widget> [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _kullaniciAdiController,
              decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  prefixIcon: Icon(Icons.person)
              ),

            ),
            TextFormField(
              controller: _isimController,
              decoration: const InputDecoration(
                  labelText: 'İsminiz',
                  prefixIcon: Icon(Icons.group)
              ),
            ),
            TextFormField(
              controller: _soyIsimController,
              decoration: const InputDecoration(
                  labelText: 'Soy İsminiz',
                  prefixIcon: Icon(Icons.group)
              ),
            ),
            TextFormField(
              controller: _sifreController,
              decoration: const InputDecoration(
                  labelText: 'Şifreniz',
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Mail Adresiniz',
                  prefixIcon: Icon(Icons.email)
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kayitOl,
              child:  Text("Kayıt Ol!"),
            ),
          ],
        ),
      ],
      ),

    );
  }
}

