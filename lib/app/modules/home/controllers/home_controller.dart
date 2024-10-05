import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/app/models/articles.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final listArticle = <Article>[].obs;
  final currentIndex = 0.obs;
  var isLoading = false.obs;
  Future<List<Article>> fetchArticleList() async {
    var response = await http.get(Uri.parse(
        'https://www.clapeyronmedia.com/wp-json/wp/v2/posts?per_page=3'));
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return articleFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void onTabTapped(int index){
    currentIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    // fetch articles JSON from API https://www.clapeyronmedia.com/wp-json/wp/v2/posts?per_page=3
    // and store it in listArticle
    listArticle.value = await fetchArticleList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
