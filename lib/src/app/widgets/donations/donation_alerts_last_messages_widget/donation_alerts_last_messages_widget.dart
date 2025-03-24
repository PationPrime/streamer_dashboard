import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';

import '../../../../modules/donations/controllers/controllers.dart';

class DonationAlertsLastMessagesWidget extends StatefulWidget {
  final VoidCallback? setCookieCallback;

  const DonationAlertsLastMessagesWidget({
    super.key,
    this.setCookieCallback,
  });

  @override
  State<DonationAlertsLastMessagesWidget> createState() =>
      _DonationAlertsLastMessagesWidgetState();
}

class _DonationAlertsLastMessagesWidgetState
    extends State<DonationAlertsLastMessagesWidget> {
  String? _errorMessage;

  bool _showErrorLink = false;

  bool _showError = false;

  bool _isLoading = true;

  void _changeErrorState(bool value) => setState(
        () {
          _showError = value;

          if (!value) {
            _errorMessage = null;
          }
        },
      );

  void _changeLoadingState(bool value) => setState(
        () => _isLoading = value,
      );

  void _toggleShowErrorLink() => setState(
        () => _showErrorLink = !_showErrorLink,
      );

  final GlobalKey _webViewKey = GlobalKey();
  final InAppWebViewSettings _settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
  );

  InAppWebViewController? _webViewController;
  PullToRefreshController? pullToRefreshController;

  void _initWebView() {
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.redAccent,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                _webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                _webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await _webViewController?.getUrl(),
                  ),
                );
              }
            },
          );
  }

  Future<void> _loadUrl(
    String url,
  ) async {
    _changeLoadingState(
      true,
    );

    _changeErrorState(
      false,
    );

    try {
      final uri = Uri.parse(url);
      final host = uri.host;
      final pathSegments = uri.pathSegments;

      if (!pathSegments.contains('widget') ||
          !pathSegments.contains('lastdonations') ||
          host != DonationConstants.donationAlertsHost) {
        _changeErrorState(true);
        _changeLoadingState(false);
      }

      if (host != DonationConstants.donationAlertsHost) {
        _errorMessage =
            LocaleKeys.donations_donation_alerts_errors_invalid_link.tr();
        return;
      } else if (!pathSegments.contains('widget') ||
          !pathSegments.contains('lastdonations')) {
        _errorMessage = LocaleKeys
            .donations_donation_alerts_errors_invalid_last_alerts_widget_link
            .tr();
        return;
      }
    } catch (_) {}

    await _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          url,
        ),
      ),
    );
  }

  String colorToHex(Color color) {
    int red = color.red;
    int green = color.green;
    int blue = color.blue;

    final hexWithoutAlpha = '#${red.toInt().toRadixString(16).padLeft(2, '0')}'
        '${green.toInt().toRadixString(16).padLeft(2, '0')}'
        '${blue.toInt().toRadixString(16).padLeft(2, '0')}';

    return hexWithoutAlpha;
  }

  Future<void> _setBackgroundColor(
    String elementName, {
    Color color = Colors.transparent,
  }) async {
    final hexColor = colorToHex(color);

    await _webViewController?.evaluateJavascript(source: '''
      var style = document.createElement('style');
      style.innerHTML = '$elementName { background-color: $hexColor !important; }';
      document.head.appendChild(style);
    ''');
  }

  Future<void> _onLoadStop(
    InAppWebViewController controller,
    WebUri? uri,
  ) async {
    pullToRefreshController?.endRefreshing();

    await _setBackgroundColor(
      '.lastevents-container',
      color: context.color.background,
    );

    _changeLoadingState(
      false,
    );
  }

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }

  void _onWebViewCreated(controller) async {
    widget.setCookieCallback?.call();
    _webViewController = controller;
  }

  String _errorLinkText(Uri link) {
    final scheme = link.scheme;
    final host = link.host;

    return !_showErrorLink
        ? '$scheme://$host${'*' * ('$link'.length - host.length)}'
        : '$link';
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DonationsController, DonationsState>(
        listenWhen: (previous, current) =>
            previous.donationAlertsModel != current.donationAlertsModel &&
            current.donationAlertsModel != null,
        listener: (context, donationsState) {
          _loadUrl(
            donationsState.donationAlertsModel!.widgetWebViewUrl,
          );
        },
        builder: (context, donationsState) => Scaffold(
          body: Center(
            child: Stack(
              children: [
                if (donationsState.donationAlertsModel?.widgetWebViewUrl
                        is String &&
                    !_showError)
                  InAppWebView(
                    key: _webViewKey,
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        donationsState.donationAlertsModel!.widgetWebViewUrl,
                      ),
                    ),
                    initialSettings: _settings,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: _onWebViewCreated,
                    onLoadStart: (controller, url) {},
                    onLoadStop: _onLoadStop,
                    onReceivedError: (controller, request, error) {
                      pullToRefreshController?.endRefreshing();

                      _changeErrorState(true);
                      _changeLoadingState(false);
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController?.endRefreshing();
                      }
                    },
                    onUpdateVisitedHistory: (controller, url, isReload) {},
                    onConsoleMessage: (controller, consoleMessage) {},
                  ),
                if (_showError)
                  Positioned.fill(
                    child: Center(
                      child: _errorMessage is String
                          ? Text(
                              _errorMessage!,
                              style: context.text.headline4Medium,
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Cannot load page: ',
                                  ),
                                  if (donationsState.donationAlertsModel
                                      ?.widgetWebViewUrl is String)
                                    TextSpan(
                                      text: _errorLinkText(
                                        Uri.parse(
                                          donationsState.donationAlertsModel!
                                              .widgetWebViewUrl,
                                        ),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _toggleShowErrorLink,
                                    )
                                  else
                                    TextSpan(
                                      text: 'unknown page link',
                                    )
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: context.text.headline5Bold,
                            ),
                    ),
                  ),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      color: context.color.background,
                      child: Center(
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
