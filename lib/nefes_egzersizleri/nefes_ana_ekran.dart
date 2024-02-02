import 'package:flutter/material.dart';
import 'dart:async';

class NefesEgzersiziSayfasi extends StatefulWidget {
  const NefesEgzersiziSayfasi({super.key});

  @override
  _NefesEgzersiziSayfasiState createState() => _NefesEgzersiziSayfasiState();
}

class _NefesEgzersiziSayfasiState extends State<NefesEgzersiziSayfasi> {
  bool egzersizBasladi = false;
  int sureSaniye = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nefes Egzersizi'),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Arka plan resmi
          Image.asset(
            'assets/images/nefes_arka.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nefes Egzersizi',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    shadows: <Shadow> [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black.withOpacity(1.0),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Rahat bir konumda oturun ve derin nefes alın. '
                      'Her nefesi içsel olarak sayın. Nefes alırken 4 saniye, nefes verirken 4 saniye. '
                      '5-10 dakika boyunca bu ritmi koruyun. Gözlerinizi kapatın ve sadece nefesinize odaklanın.',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    shadows: <Shadow> [
                      Shadow(
                        blurRadius: 35.0,
                        color: Colors.red.withOpacity(1.0),
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    elevation: 10.0,
                    side: const BorderSide(color: Colors.red, width: 5.0),
                  ),
                  onPressed: () {
                    setState(() {
                      egzersizBasladi = true;
                      sureSaniye = 5 * 60; // 5 dakika süre.
                    });
                    baslatNefesEgzersizi();
                  },
                  child: const Text(
                    'Egzersizi Başlat',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                egzersizBasladi
                    ? Text('Kalan Süre: ${sureSaniye ~/ 60}:${sureSaniye % 60}', style: const TextStyle(color: Colors.white))
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void baslatNefesEgzersizi() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (sureSaniye == 0) {
        timer.cancel();
        setState(() {
          egzersizBasladi = false;
        });
      } else {
        setState(() {
          sureSaniye--;
        });
      }
    });
  }
}
