import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/articles.dart';

class ArticlePageController extends GetxController {
  final articleID = 0.obs;
  final articleMarkdown = ''.obs;
  fetchArticle() async {
    // Load from local assets assets/articles.json
    String jsonString = await rootBundle.loadString('assets/articles.json');
    var article = articleFromJson(jsonString)[articleID.value];
    return article;
  }

  final article = Article(id: 0, title: '', imageUrl: '', articlePath: '').obs;

  final count = 0.obs;
  @override
  void onInit() async {
    articleID.value = Get.arguments['id'];
    article.value = await fetchArticle();
    articleMarkdown.value =
        await rootBundle.loadString(article.value.articlePath);
    super.onInit();
  }

  void increment() => count.value++;
}
