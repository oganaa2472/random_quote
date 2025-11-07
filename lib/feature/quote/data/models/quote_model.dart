// The model reflects the raw JSON structure from the API
import 'package:random_quote/feature/quote/domain/entities/quote_model.dart';

class QuoteModel {
  final String q; // The quote text
  final String a; // The author

  QuoteModel({required this.q, required this.a});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      q: json['q'] as String,
      a: json['a'] as String,
    );
  }

  // Mapper function to convert Model to Entity
  QuoteEntity toEntity() {
    return QuoteEntity(
      text: q,
      author: a,
    );
  }
}