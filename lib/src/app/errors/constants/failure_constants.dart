import '../../failure/failure.dart';

class OtherFailure extends Failure {
  final String errorCode;

  const OtherFailure({
    this.errorCode = 'other_error',
    super.message = 'Something went wrong',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class Code400Failure extends Failure {
  final String? errorMessage;

  const Code400Failure({this.errorMessage});

  @override
  String get message => "Некорректный запрос";

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class Code404Failure extends Failure {
  final String? errorMessage;

  const Code404Failure({this.errorMessage});

  @override
  String get message => "Произошла ошибка";

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class Code500Failure extends Failure {
  final String? errorMessage;

  const Code500Failure({this.errorMessage});

  @override
  String get message => "Произошла ошибка";

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}
