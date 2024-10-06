import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/articles.dart';

class ArticlePageController extends GetxController {
  //TODO: Implement ArticlePageController

  final article_id = 0.obs;
  final article_md = ''.obs;
  fetchArticle() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/articles.json');
    var article = articleFromJson(jsonString)[article_id.value];
    return article;
  }

  final article = Article(id: 0, title: '', imageUrl: '', articlePath: '').obs;

  final count = 0.obs;
  @override
  void onInit() async{
    article_id.value = Get.arguments['id'];
    article.value = await fetchArticle();
    article_md.value = await rootBundle.loadString(article.value.articlePath);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
