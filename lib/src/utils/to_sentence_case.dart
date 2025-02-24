
import 'package:wond3rcard/src/utils/size_constants.dart';

String? toSentenceCase(String? input) {
  if (input == null || input.isEmpty) return input;
  return input[SpacingConstants.int0].toUpperCase() + input.substring(SpacingConstants.int1).toLowerCase();
}
