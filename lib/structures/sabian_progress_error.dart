import 'package:sabian_native_common/structures/sabian_progress.dart';

class SabianProgressError extends SabianProgress {
  SabianProgressError(String message, {String? title, bool? isHidden})
      : super(message, title: title, isHidden: isHidden);

  factory SabianProgressError.fromParams(Map<String, dynamic> args) {
    return SabianProgressError(args["message"],
        title: args["title"], isHidden: args["isHidden"]);
  }
}
