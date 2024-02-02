import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/GirisEkrani.dart';
import 'package:flutter/services.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/VeritabaniYonetimi.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/ana_ekran.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var x = VeritabaniYonetimi();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return MaterialApp(
      title: 'Ruh Durağı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //TEMA AYARLARIM
        primarySwatch: Colors.blue,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[100],
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24.0,
            color: Colors.white,
          ),
        )
      ),
      home: const AnaEkran(),
    );
  }
}
