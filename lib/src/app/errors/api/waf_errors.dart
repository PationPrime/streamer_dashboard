part of 'api_errors.dart';

class WAFError extends StateError {
  final int? responseCode;

  WAFError(
    super.message,
    this.responseCode,
  );
}

class WafFailure extends Failure {
  final String? errorCode;
  final String? errorMessage;

  const WafFailure({
    this.errorCode,
    this.errorMessage,
  });

  @override
  String get message => errorMessage ?? "Suspicious activity";
}
