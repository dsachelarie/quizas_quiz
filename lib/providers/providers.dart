import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/topic.dart';
import '../models/question.dart';

final questionProvider =
    StateProvider<Question>((_) => Question(0, 0, "", [], ""));

final topicsProvider = StateProvider<List<Topic>>((_) => []);

final correctnessProvider = StateProvider<int>((_) => -1);

final genericPracticeProvider = StateProvider<bool>((_) => false);
