import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/models/rempah.dart';
import 'package:url_launcher/url_launcher.dart';

class RempahDetailController extends GetxController {
  //TODO: Implement RempahDetailController

  Future<void> launchLink(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }}
  final rempahID = 0.obs;
  fetchRempah() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/rempah.json');
    var rempah = rempahFromJson(jsonString).firstWhere((element) => element.id == rempahID.value);
    return rempah;
  }

  final rempah = Rempah(
    id: 0,
    namaRempah: '',
    namaIlmiah: '',
    gambar: '',
    ikhtisar: '',
    morfologi: '',
    ciri: '',
    khasiat: '',
    kegunaan: '',
    potensi: '',
    referensiMorfologi: '',
    referensiCiri: '',
    referensiKhasiat: '',
    referensiKegunaan: '',
    referensiPotensi: '',
  ).obs;

  final count = 0.obs;
  @override
  void onInit() async{
    rempahID.value = Get.arguments['id'];
    rempah.value = await fetchRempah();
    super.onInit();
  }
}
