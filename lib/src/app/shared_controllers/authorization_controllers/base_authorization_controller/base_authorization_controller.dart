import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/storage/storage.dart';

import '../../../failure/failure.dart';

part 'base_authorization_state.dart';

abstract class BaseAuthorizationController
    extends Cubit<BaseAuthorizationState> {
  final LocalStorageInterface localStorageInterface;

  BaseAuthorizationController({
    required this.localStorageInterface,
  }) : super(
          BaseAuthorizationInitialState(),
        );

  FutureOr<void> chechAuthorizationState();

  FutureOr<void> signOut();
}
