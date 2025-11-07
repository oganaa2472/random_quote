import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> fetchRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;
  QuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<QuoteModel> fetchRandomQuote() async {
    final response = await client.get(
      Uri.parse('https://zenquotes.io/api/random'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // The API returns a list containing one object
      final List<dynamic> jsonList = json.decode(response.body);
      return QuoteModel.fromJson(jsonList[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}