import 'package:dartz/dartz.dart';
import 'package:random_quote/core/error/failures.dart';
import 'package:random_quote/feature/quote/domain/entities/quote_model.dart';
import 'package:random_quote/feature/quote/domain/repositories/quote_repo.dart';

class GetRandomQuoteUseCase {
  final QuoteRepository repository;

  GetRandomQuoteUseCase(this.repository);

  // The call signature matches the Repository interface
  Future<Either<Failure, QuoteEntity>> call() async {
    return await repository.getRandomQuote();
  }
}