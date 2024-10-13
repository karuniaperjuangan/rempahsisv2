import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rempahsisv2/app/models/articles.dart';

class ArticleListController extends GetxController {

  Future<List<Article>> fetchArticleList() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/articles.json');
    return articleFromJson(jsonString);
  }

  void goToArticlePage(int index) {
    //final ArticlePageController articlePageController = Get.find();
    //articlePageController.article_id.value = index;
    Get.toNamed('/article-page', arguments: {'id': index});
  }

  final listArticle = <Article>[].obs;
  @override
  void onInit() async {
    listArticle.value = await fetchArticleList();
    super.onInit();
  }

}
