
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/models/articles.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  HomeController():super();
  
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  Future<List<Article>> fetchArticleList() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/articles.json');
    return articleFromJson(jsonString);
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
    listArticle.value = await fetchArticleList();
    super.onInit();
    
  }


  @override
  void onClose() {}
}
