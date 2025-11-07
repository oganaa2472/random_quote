import 'package:hive/hive.dart';
import 'package:random_quote/feature/quote/data/models/quote_model.dart' show QuoteModel;
class CacheException implements Exception {}
abstract class QuoteLocalDataSource {
  Future<QuoteModel> getLastQuote();
  Future<void> cacheQuote(QuoteModel quote);
}

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  // Dependency: The specific Hive Box we use for quotes
  final Box<QuoteModel> quoteBox; 

  QuoteLocalDataSourceImpl({required this.quoteBox});

  @override
  Future<QuoteModel> getLastQuote() async {
    // Hive read is synchronous, but we wrap it in Future for consistency
    final cachedQuote = quoteBox.get('lastQuote'); 

    if (cachedQuote != null) {
      return cachedQuote;
    } else {
      // Throw the specific exception the Repository expects to catch
      throw CacheException(); 
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quote) async {
    // Hive write is synchronous
    await quoteBox.put('lastQuote', quote);
  }
}