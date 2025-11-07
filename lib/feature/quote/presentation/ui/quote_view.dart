import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote/feature/quote/presentation/cubit/quote_cubit.dart';
import 'package:random_quote/feature/quote/presentation/cubit/quote_state.dart';
class QuotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is where you initialize the Cubit, often done via a Provider/DI setup
    // For this example, assume the Cubit is already available via BlocProvider.of(context)
    
    final quoteCubit = context.read<QuoteCubit>(); 
    // Trigger the first fetch
    quoteCubit.fetchQuote(); 

    return Scaffold(
      appBar: AppBar(title: const Text('Clean Quote Generator')),
      body: Center(
        child: BlocBuilder<QuoteCubit, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading) {
              return const CircularProgressIndicator();
            } else if (state is QuoteLoaded) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '"${state.quote.text}"',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '- ${state.quote.author}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            } else if (state is QuoteError) {
              return Text('Error: ${state.message}');
            }
            return const Text('Press the button to load a quote.');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => quoteCubit.fetchQuote(), // UI tells Cubit to fetch again
        child: const Icon(Icons.refresh),
      ),
    );
  }
}