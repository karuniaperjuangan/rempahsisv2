import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/models/rempah.dart';

class RempahDetailController extends GetxController {
  final rempahID = 0.obs;
  fetchRempah() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/rempah.json');
    var rempah = rempahFromJson(jsonString)
        .firstWhere((element) => element.id == rempahID.value);
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
  void onInit() async {
    rempahID.value = Get.arguments['id'];
    rempah.value = await fetchRempah();
    super.onInit();
  }
}
