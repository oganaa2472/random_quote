import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:random_quote/feature/quote/data/datasources/quote_remote_data_source.dart';
import 'package:random_quote/feature/quote/data/datasources/quote_local_data_source.dart';
import 'package:random_quote/feature/quote/data/models/quote_model.dart';
import 'package:random_quote/feature/quote/data/repositories/quote_repository_impl.dart';
import 'package:random_quote/feature/quote/domain/repositories/quote_repo.dart' show QuoteRepository;
import 'package:random_quote/feature/quote/domain/usecases/get_random_quote_usecase.dart';
import 'package:random_quote/feature/quote/presentation/cubit/quote_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // Cubit / Bloc
  final Box<QuoteModel> quoteBox = await Hive.openBox<QuoteModel>('quoteBox');
  sl.registerFactory(() => QuoteCubit(getQuote: sl()));
  sl.registerLazySingleton<Box<QuoteModel>>(() => quoteBox);
  // Use cases
  sl.registerLazySingleton(() => GetRandomQuoteUseCase(sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
    ),
  );
  // Data sources
    sl.registerLazySingleton<QuoteLocalDataSource>(
    () => QuoteLocalDataSourceImpl(quoteBox: sl()),
  );
  // Register local data source (uses the Hive box registered above)

  sl.registerLazySingleton<QuoteRemoteDataSource>(
      () => QuoteRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}