import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/controllers/quote_controller.dart';
import 'package:quotes_app/models/quotes.dart';

class APICalls {
  static fetchQuote() async {
    var response = await http.get(Uri.https("zenquotes.io", "api/random"));
    print(response.body);
    var quote = quoteFromJson(response.body);
    print(quote.length);
    Get.find<QuoteController>().quote.value = quote[0];
  }
}
