import 'package:dartz/dartz.dart';
import 'package:random_quote/feature/quote/domain/entities/quote_model.dart'; // Import dartz
import 'package:random_quote/core/error/failures.dart';
abstract class QuoteRepository {
  // Signature changes from Future<QuoteEntity> to Future<Either<Failure, QuoteEntity>>
  Future<Either<Failure, QuoteEntity>> getRandomQuote();
}