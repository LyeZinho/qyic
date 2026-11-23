import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../progress/data/progress_repository.dart';

/// Size of the local database in bytes.
final storageUsedProvider = FutureProvider.autoDispose<int>((ref) {
  // Re-measure when progress changes, i.e. after every review.
  ref.watch(progressProvider);
  return ref.watch(databaseProvider).sizeInBytes();
});
