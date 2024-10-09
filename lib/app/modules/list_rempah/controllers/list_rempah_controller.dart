import 'package:myapp/app/models/rempah.dart';
import 'package:myapp/utils/fetch_rempah.dart';
import 'package:get/get.dart';

class ListRempahController extends GetxController {
  final count = 0.obs;
  late Future future;

  var isInitialized = false.obs;
  final lastAccessedRempahs = <Rempah>[].obs;
  var dataRempah = <Rempah>[].obs;

  var dataFilter = <Rempah>[].obs;
  @override
  void onInit() async{
    dataRempah.value = await loadRempahJSON('assets/rempah.json');
    dataFilter = dataRempah;
    super.onInit();
    isInitialized.value = true;
  }

  var hasil = <Rempah>[].obs;
  void filter(String kata) {
    if(kata.isEmpty){
      hasil.value =dataRempah;
    }
    else{
      hasil.value = dataRempah.where((x) => x.namaRempah.toLowerCase().contains(kata)).toList();
    }
    
    dataFilter = hasil;
    print(dataFilter);
  }
  void increment() => count.value++;

}
