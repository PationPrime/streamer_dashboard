import 'package:dartz/dartz.dart';
import 'package:external_webview_window/external_webview_window.dart';
import 'package:external_webview_window/external_webview_window_platform_interface.dart';
import 'package:external_webview_window/models/models.dart';
import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/errors/api/api_errors.dart';
import 'package:streamer_dashboard/src/app/errors/authentication_errors/authentication_errors.dart';

import '../../api_client/client/concrete_client.dart';
import '../../constants/constants.dart';
import '../../dto/dto.dart';
import '../../failure/failure.dart';
import '../../models/models.dart';
import '../base_repository_interface.dart';

part 'authentication_repository.dart';

abstract interface class AuthenticationRepositoryInterface
    implements BaseRepositoryInterface {
  ExternalWebviewWindow get externalWebviewWindowPlugin;

  void subscribeToWebViewEvents({
    GenericEventCallback<Uri>? onLoadStart,
    GenericEventCallback<Uri>? onLoadEnd,
    GenericEventCallback<Uri>? onURLChanged,
    GenericEventCallback<Uri>? onLoadError,
  });

  void cancelWebViewEventsSubscription();

  Future<void> closeCEFWebViewWindow();

  Future<Cookies> getCookiesForUrl({required String url});

  Future<Either<Failure, bool>> loginOAuth2Twitch({
    required TwitchLoginDto twitchLoginDto,
    required GenericEventCallback<Uri> onLoadEnd,
  });

  Future<Either<Failure, TwitchTokenModel>> loginTwitch({
    required TwitchLoginDto twitchLoginDto,
  });
}
