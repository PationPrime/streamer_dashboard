import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../../app/constants/constants.dart';
import '../../../app/storage/storage.dart';
import '../../../app/tools/tools.dart';

class TwitchChatWebView extends StatefulWidget {
  final String url;

  const TwitchChatWebView({
    super.key,
    required this.url,
  });

  @override
  State<TwitchChatWebView> createState() => _TwitchChatWebViewState();
}

class _TwitchChatWebViewState extends State<TwitchChatWebView> {
  String? _errorMessage;

  late final _appLogger = AppLogger(where: '$this');

  bool _isLoading = true;

  final GlobalKey _webViewKey = GlobalKey();
  final InAppWebViewSettings _settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
  );

  InAppWebViewController? _webViewController;
  PullToRefreshController? pullToRefreshController;

  void _pageLoaded() => setState(
        () => _isLoading = false,
      );

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

    _pageLoaded();
  }

  Future<void> _setTwitchCookie() async {
    try {
      final twitchToken = await AppSecureStorage.instance.getTwitchToken();

      if (twitchToken?.authTokenCookieValue is! String) {
        _appLogger.logError(
          'authTokenCookieValue is! String',
          lexicalScope: '_setTwitchCookie method',
        );

        throw Exception('authTokenCookieValue is! String');
      }

      final cookieManager = CookieManager();

      final cookiesUrl = WebUri(
        TwitchConstants.twitchTVUrl,
      );

      await cookieManager.deleteCookies(
        url: cookiesUrl,
        domain: TwitchConstants.cookieDomain,
      );

      await cookieManager.setCookie(
        url: cookiesUrl,
        name: TwitchConstants.authTokenCookieKey,
        value: twitchToken!.authTokenCookieValue!,
        domain: TwitchConstants.cookieDomain,
        isSecure: true,
        isHttpOnly: false,
      );

      _appLogger.logMessage(
        'Cookie setted: auth-token=${twitchToken.accessToken}',
        sign: '✅',
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'set Twitch auth-token cookie error: $error',
        stackTrace: stackTrace,
      );

      _errorMessage = 'Something went wrong!';

      setState(
        () => _isLoading = false,
      );
    }
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
    await _setTwitchCookie();
    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: [
              if (_errorMessage is! String)
                InAppWebView(
                  key: _webViewKey,
                  initialUrlRequest: URLRequest(
                    url: WebUri(
                      widget.url,
                    ),
                  ),
                  initialSettings: _settings,
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: _onWebViewCreated,
                  onLoadStop: _onLoadStop,
                  onReceivedError: (controller, request, error) {
                    pullToRefreshController?.endRefreshing();
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {},
                  onConsoleMessage: (controller, consoleMessage) {},
                )
              else
                Positioned.fill(
                  child: Container(
                    color: context.color.background,
                    child: Center(
                      child: Text(
                        _errorMessage!,
                        style: context.text.headline3Bold,
                      ),
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
      );
}
