
class NotModeli{
  int? notid;
  String? baslik;
  String? body;
  String? olusturma_zamani;

  NotModeli({this.notid, this.baslik, this.body, this.olusturma_zamani});

  Map<String, dynamic> toMap(){
    return({
      "Notid":notid,
      "baslik":baslik,
      "body":body,
      "olusturma_zamani":olusturma_zamani.toString()
    });
  }
}