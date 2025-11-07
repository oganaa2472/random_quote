import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote/feature/quote/domain/usecases/get_random_quote_usecase.dart';
import 'package:random_quote/feature/quote/presentation/cubit/quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final GetRandomQuoteUseCase getQuote;

  QuoteCubit({required this.getQuote}) : super(QuoteInitial());

  Future<void> fetchQuote() async {
    if (state is QuoteLoading) return;
    
    emit(QuoteLoading());
    
    // The Use Case returns an Either
    final result = await getQuote.call(); 

    // Use .fold() to handle the result functionally: 
    // The first parameter (l) handles the Left (Failure)
    // The second parameter (r) handles the Right (Success/Entity)
    result.fold(
      (failure) => emit(QuoteError(failure.message)), // L: Failure
      (quoteEntity) => emit(QuoteLoaded(quoteEntity)), // R: Success
    );
  }
}