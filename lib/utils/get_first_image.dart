import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

String getFirstImageSrc(String htmlString) {
  // Parse the HTML string
  Document document = html_parser.parse(htmlString);
  
  // Find the first <img> tag
  Element? imgElement = document.querySelector('img');
  
  // Return the value of the src attribute, or null if no image is found
  return imgElement?.attributes['src'] ?? 'No image found';
}