  import 'package:flutter/services.dart';
import 'package:myapp/app/models/rempah.dart';

Future<List<Rempah>> loadRempahJSON(String path) async{
    final asset = await rootBundle.loadString(path);
    return rempahFromJson(asset);
}