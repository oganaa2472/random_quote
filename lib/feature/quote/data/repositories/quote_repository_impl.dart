import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:random_quote/core/error/failures.dart';
import 'package:random_quote/feature/quote/data/datasources/quote_local_data_source.dart';
import 'package:random_quote/feature/quote/data/datasources/quote_remote_data_source.dart';
import 'package:random_quote/feature/quote/domain/entities/quote_model.dart';
import 'package:random_quote/feature/quote/domain/repositories/quote_repo.dart';
 // For catching http-related errors

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;

  QuoteRepositoryImpl({required this.remoteDataSource,required this.localDataSource,});

  @override
  Future<Either<Failure, QuoteEntity>> getRandomQuote() async {
    try {
      // 1. Try to fetch from REMOTE data source (Network First)
      final quoteModel = await remoteDataSource.fetchRandomQuote();

      // 2. If successful, cache the new data locally (Fire and Forget)
      try {
        await localDataSource.cacheQuote(quoteModel);
      } catch (_) {
        // ignore caching errors; we still return the remote result
      }

      // Print source for debugging
      // Use console / Logcat to see this output when running the app
      print('Source: remote');

      // 3. Return the fresh data
      return Right(quoteModel.toEntity());
    } on Exception catch (e) {
      // 4. NETWORK FAILED: Try to retrieve from LOCAL cache
      try {
  final localModel = await localDataSource.getLastQuote();
  print('Source: local (cache)');
        // Return cached data with a notification that it's stale (optional)
        return Right(localModel.toEntity()); 
      } on Exception {
        // 5. LOCAL FAILED: If both fail, return a generic Server/Network failure.
        if (e is ClientException) { 
          return const Left(ServerFailure(message: 'No network and no local cache found.'));
        }
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }
}