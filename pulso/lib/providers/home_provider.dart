import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/data/home_repository_impl.dart';
import '../features/home/domain/entities/daily_summary.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../services/database_service.dart';

final databaseProvider = Provider<DatabaseService>((ref) => DatabaseService.instance);

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(databaseProvider));
});

final todaySummaryProvider = FutureProvider<DailySummary>((ref) {
  return ref.watch(homeRepositoryProvider).getTodaySummary();
});
