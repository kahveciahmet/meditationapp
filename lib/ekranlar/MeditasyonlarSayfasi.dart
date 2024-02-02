import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/meditasyon_yonlendirme/derin_uyku.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/meditasyon_yonlendirme/nefes_odakli.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/meditasyon_yonlendirme/rahatlama.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/meditasyon_yonlendirme/sevgi_ve_iyilik.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/meditasyon_yonlendirme/sinir_yonetimi.dart';

class MeditasyonlarSayfasi extends StatelessWidget {
  const MeditasyonlarSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Ruh Durağı',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24.0,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 1.0,
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Kartlar(
            tiklama: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Nefes_Odakli()),
              );
              print('İlk kutuya tıklandı.');
            },
            imageAsset: 'assets/meditasyon_sayfasi/nefes_odakli.jpg',
          ),
          Kartlar(
            tiklama: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Rahatlama()),
              );
              print('İkinci kutuya tıklandı.');
            },
            imageAsset: 'assets/meditasyon_sayfasi/rahatlama.jpg',
          ),
          Kartlar(
            tiklama: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DerinUyku()),
              );
              print('Üçüncü kutuya tıklandı.');
            },
            imageAsset: 'assets/meditasyon_sayfasi/derin_uyku.jpg',
          ),
          Kartlar(
            tiklama: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SinirYonetimi()),
              );
              print('Dördüncü kutuya tıklandı.');
            },
            imageAsset: 'assets/meditasyon_sayfasi/sinir_yonetimi.jpg',
          ),
          Kartlar(
            tiklama: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SevgiveIyilik()),
              );
              print('Beşinci kutuya tıklandı.');
            },
            imageAsset: 'assets/meditasyon_sayfasi/sevgi_ve_iyilik.jpg',
          ),
        ],
      ),
    );
  }
}

class Kartlar extends StatelessWidget {
  final Function tiklama;
  final String imageAsset;

  const Kartlar({
    Key? key,
    required this.tiklama,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tiklama();
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imageAsset,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
