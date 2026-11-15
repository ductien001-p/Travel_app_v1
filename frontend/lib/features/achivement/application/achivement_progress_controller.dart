import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/achivement_models.dart';
import '../provider/achivement_provider.dart';

final achivementProgressControllerProvider =
    AsyncNotifierProvider.autoDispose<
      AchivementProgressController,
      AchivementProgressPage
    >(AchivementProgressController.new);

class AchivementProgressController
    extends AsyncNotifier<AchivementProgressPage> {
  @override
  Future<AchivementProgressPage> build() =>
      ref.read(achivementRepositoryProvider).getProgress();

  Future<void> refresh() async {
    final previous = state.asData?.value;
    state = await AsyncValue.guard(
      () => ref.read(achivementRepositoryProvider).getProgress(),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
    }
  }
}
