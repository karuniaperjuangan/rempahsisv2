
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/models/articles.dart';
import 'package:myapp/app/models/rempah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  HomeController():super();
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  var listRempah = <Rempah>[].obs;
  
  Future<List<Article>> fetchArticleList() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/articles.json');
    return articleFromJson(jsonString);
  }

    Future<List<Rempah>> loadRempahJSON(String path) async{
    final asset = await rootBundle.loadString(path);
    return rempahFromJson(asset);
    }
    
  final listArticle = <Article>[].obs;
  
  void onTabTapped(int index){
    print(index);
    currentIndex.value = index;
  }

  void goToArticlePage(int index){
    //final ArticlePageController articlePageController = Get.find();
    //articlePageController.article_id.value = index;
    print(index);
    Get.toNamed('/article-page', arguments: {'id': index});
  }
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    final lastAccessedRempahNames = prefs.getStringList('lastAccessedRempahNames') ?? [];
    listArticle.value = await fetchArticleList();
    final listFetchedRempahs = (await loadRempahJSON('assets/rempah.json'));
    listRempah.value = lastAccessedRempahNames.map((e) => listFetchedRempahs.firstWhere((element) => element.namaRempah == e)).toList();
    super.onInit();
  }


  @override
  void onClose() {}
}
