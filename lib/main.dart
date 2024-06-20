import 'package:love_cooking_app/src/app.dart';
import 'package:love_cooking_app/src/exceptions/async_error_logger.dart';
import 'package:love_cooking_app/src/exceptions/error_logger.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_sync_service.dart';
import 'package:love_cooking_app/src/features/collection/data/local/local_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/data/local/sembast_collection_repository.dart';
import 'package:love_cooking_app/src/features/filters/application/filtering_sync_service.dart';
import 'package:love_cooking_app/src/features/filters/data/local/category/local_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/local/category/sembast_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/local/diet/local_diet_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/local/diet/sembast_diet_filtering_repository.dart';

import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  final localCollectionRepository =
      await SembastCollectionRepository.makeDefault();
  final localCategoryFilteringRepository =
      await SembastCategoryFilteringRepository.makeDefault();
  final localDietFilteringRepository =
      await SembastDietFilteringRepository.makeDefault();
  // * Create ProviderContainer with any required overrides
  final container = ProviderContainer(
    overrides: [
      localCollectionRepositoryProvider
          .overrideWithValue(localCollectionRepository),
      localCategoryFilteringRepositoryProvider
          .overrideWithValue(localCategoryFilteringRepository),
      localDietFilteringRepositoryProvider
          .overrideWithValue(localDietFilteringRepository),
    ],
    observers: [AsyncErrorLogger()],
  );

  // * Initialize CollectionSyncService to start the listener
  container.read(collectionSyncServiceProvider);
  // * Initialize FilteringSyncService to start the listener
  container.read(filteringSyncServiceProvider);
  final errorLogger = container.read(errorLoggerProvider);
  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers(errorLogger);
  // * Entry point of the app
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
