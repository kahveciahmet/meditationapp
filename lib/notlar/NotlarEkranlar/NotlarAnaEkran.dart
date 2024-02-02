import 'package:flutter/material.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotModelleri/Not_modeli.dart';
import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotVeritabani/notveritabani.dart';
import 'not_ekle.dart';
import 'notlari_goruntule.dart';

class NotlarAnaEkran extends StatefulWidget {
  const NotlarAnaEkran({Key? key}) : super(key: key);

  @override
  State<NotlarAnaEkran> createState() => _NotlarAnaEkranState();
}

class _NotlarAnaEkranState extends State<NotlarAnaEkran> {
  Future<List<Map<String, dynamic>>> notlariGetir() async {
    final List<Map<String, dynamic>> notlar = await NotVeritabani.notdb.notlariGetir();
    return notlar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notlarınız"),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notlariGetir(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> notVeri) {
          switch(notVeri.connectionState){
            case ConnectionState.waiting :
              {
                return const Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if(notVeri.data == null){
                  return const Center(child: Text("Henüz notunuz yok, yeni oluştur!"),);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: notVeri.data!.length,
                      itemBuilder: (context, index){
                        String baslik = notVeri.data![index]['baslik'];
                        String body = notVeri.data![index]['body'];
                        String olusturmaZamani = notVeri.data![index]['olusturma_zamani'];
                        int notid = notVeri.data![index]['notid'];
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              Map<String, dynamic> rowData = notVeri.data![index];
                              NotModeli notModeli = NotModeli(
                                baslik: rowData['baslik'],
                                body: rowData['body'],
                                olusturma_zamani: rowData['olusturma_zamani'],
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotlariGoster(notModeli: notModeli)),
                              );
                            },
                            title: Text(baslik),
                            subtitle: Text(body),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
            case ConnectionState.none:
              {
                return const Center(child: Text("Beklenmeyen bir durum oluştu."),);
              }
            case ConnectionState.active:
              return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotEkle()));
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}

