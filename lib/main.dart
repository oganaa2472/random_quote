import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_quote/core/services/injection_container.dart';
import 'package:random_quote/core/services/injection_container.dart' as di;
import 'package:random_quote/feature/quote/data/models/quote_model.dart';
import 'package:random_quote/feature/quote/data/models/quote_model_adapter.dart';
import 'package:random_quote/feature/quote/presentation/cubit/quote_cubit.dart' show QuoteCubit;
import 'package:random_quote/feature/quote/presentation/ui/quote_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter();
  // Register the Hive TypeAdapter for QuoteModel (generated)
  // If you haven't generated the adapter yet run:
  // flutter pub run build_runner build --delete-conflicting-outputs
  Hive.registerAdapter(QuoteModelAdapter());
  // 1. Dependency Injection Setup
  // This function registers all Repositories, Use Cases, Data Sources, etc., 
  // with a service locator (like get_it or a manual factory).
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quate Generator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
     home: BlocProvider(
        create: (context) => di.sl<QuoteCubit>(),
        child:  QuotePage(),
      ),
    );
  }
}
