import 'package:random_quote/feature/quote/domain/entities/quote_model.dart';

abstract class QuoteState {}
class QuoteInitial extends QuoteState {}
class QuoteLoading extends QuoteState {}
class QuoteLoaded extends QuoteState {
  final QuoteEntity quote;
  QuoteLoaded(this.quote);
}
class QuoteError extends QuoteState {
  final String message;
  QuoteError(this.message);
}