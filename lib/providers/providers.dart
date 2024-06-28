import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';

final questionProvider =
    StateProvider<Question>((_) => Question(0, 0, "", [], ""));

//final countProvider = StateProvider<int>((_) => 0);
