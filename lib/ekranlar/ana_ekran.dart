import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/GirisEkrani.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/KayitOlmaEkrani.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/ekranlar/MeditasyonlarSayfasi.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotlarEkranlar/NotlarAnaEkran.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/nefes_egzersizleri/nefes_ana_ekran.dart';
import 'package:flutter_test/flutter_test.dart';


class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});


  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> with TickerProviderStateMixin {
  late AnimationController _arkaplanController;
  late AnimationController _yaziController;
  late Animation<double> _arkaplanZoomAnimasyonu;
  late Animation<double> _yaziGecisAnimasyonu;




  @override
  void initState() {
    super.initState();


    _arkaplanController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _yaziController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _arkaplanZoomAnimasyonu = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _arkaplanController,
        curve: Curves.easeInOut,
      ),
    );

    _yaziGecisAnimasyonu = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _yaziController,
        curve: Curves.easeInOut,
      ),
    );

    _arkaplanController.forward();
    _yaziController.forward();
  }

  @override
  void dispose() {
    _arkaplanController.dispose();
    _yaziController.dispose();
    super.dispose();
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
      drawer: Drawer(
        backgroundColor: Colors.blue[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text("Merhaba,"),
              accountEmail: Text('Hoş Geldiniz!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                Shadow(
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
              ),
              ],
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
            ),
            ),
            ListTile(
              title: const Text('Giriş Yap'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GirisEkrani()
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Kayıt Ol'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KayitOl()
                )
                );
              },
            ),
            ListTile(
              title: const Text('Notlar'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotlarAnaEkran()
                ),);
                },
            ),
            ListTile(
              title: const Text('Nefes Egzersizleri'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const NefesEgzersiziSayfasi()
                ),);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //arkaplan resmi

          AnimatedBuilder(
            animation: _arkaplanController,
            builder: (context, child) {
              return Transform.scale(
                scale: _arkaplanZoomAnimasyonu.value,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/arkaplan.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeTransition(
                  opacity: _yaziGecisAnimasyonu,
                  child: Text(
                    'Hoş Geldiniz!',
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow> [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                    animation: _yaziController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _yaziGecisAnimasyonu.value,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                   const MeditasyonlarSayfasi()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                          ),
                          child: const Text('Meditasyonlara Başla!',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      );
                    }
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}