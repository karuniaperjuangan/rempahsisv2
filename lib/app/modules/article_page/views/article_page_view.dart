import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:get/get.dart';
import 'package:rempahsisv2/app/components/appbar/rempah_sis_appbar.dart';
import 'package:rempahsisv2/utils/launch_url.dart';

import '../controllers/article_page_controller.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  const ArticlePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RempahSISAppbar(),
      body: Center(
        child: Obx(() => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Markdown(
                  data: controller.articleMarkdown.value,
                  onTapLink: (text, href, title) {
                    launchLink(href!);
                  },
                  styleSheet: MarkdownStyleSheet(
                    textAlign: WrapAlignment.spaceEvenly,
                    h3Align: WrapAlignment.center,
                    listBullet: TextStyle(fontSize: 16),
                    unorderedListAlign: WrapAlignment.start,
                    h3: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
