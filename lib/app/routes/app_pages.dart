import 'package:get/get.dart';

import '../modules/article_page/bindings/article_page_binding.dart';
import '../modules/article_page/views/article_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_rempah/bindings/list_rempah_binding.dart';
import '../modules/list_rempah/views/list_rempah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIST_REMPAH,
      page: () => const ListRempahView(),
      binding: ListRempahBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_PAGE,
      page: () => const ArticlePageView(),
      binding: ArticlePageBinding(),
    ),
  ];
}
