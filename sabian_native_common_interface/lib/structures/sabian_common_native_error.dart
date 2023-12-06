import 'package:flutter/services.dart';

class SabianCommonNativeError implements Exception {
  String? title;
  String message = "";
  String? code;
  StackTrace? trace;
  Exception? throwable;

  SabianCommonNativeError([this.message = ""]);

  SabianCommonNativeError.withTitle([this.title, this.message = ""]);

  SabianCommonNativeError.withTitleAndCode(
      [this.title, this.message = "", this.code]);

  SabianCommonNativeError.withError(this.throwable) {
    message = throwable.toString();
  }

  SabianCommonNativeError.withTrace(this.trace);

  String _buildOutput() {
    List<String> builder = [];
    if (title != null) {
      builder.add(title!);
    }
    builder.add(message);
    return builder.join(" : ");
  }

  @override
  String toString() {
    return _buildOutput();
  }
}

extension PlatformExceptionToNative on PlatformException {
  SabianCommonNativeError get toNativeError {
    SabianCommonNativeError err = SabianCommonNativeError(message ?? "");
    err.code = code;
    err.title = "Error";
    return err;
  }
}

extension ExceptionToNative on Exception {
  SabianCommonNativeError get toNativeError {
    SabianCommonNativeError err = SabianCommonNativeError(toString());
    err.title = "Error";
    return err;
  }
}
