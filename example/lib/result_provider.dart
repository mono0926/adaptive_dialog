import 'package:example/util/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultProvider =
    StateNotifierProvider<ResultNotifier, dynamic>((ref) => ResultNotifier());

class ResultNotifier extends StateNotifier<dynamic> {
  ResultNotifier() : super(null);
  // ignore: use_setters_to_change_properties
  void set(dynamic text) {
    state = text;
  }

  void clear() => set('');

  @override
  set state(dynamic value) {
    super.state = value;
    logger.info(state);
  }
}
