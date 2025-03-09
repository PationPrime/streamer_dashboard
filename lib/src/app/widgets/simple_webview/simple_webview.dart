import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class SimpleWebView extends StatefulWidget {
  final String url;

  const SimpleWebView({
    super.key,
    required this.url,
  });

  @override
  State<SimpleWebView> createState() => _SimpleWebViewState();
}

class _SimpleWebViewState extends State<SimpleWebView> {
  bool _isLoading = true;

  void _pageLoaded() => setState(
        () => _isLoading = false,
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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: [
              InAppWebView(
                key: _webViewKey,
                initialUrlRequest: URLRequest(
                  url: WebUri(
                    widget.url,
                  ),
                ),
                initialSettings: _settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) async {
                  _webViewController = controller;
                },
                onLoadStart: (controller, url) {},
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    // if (await canLaunchUrl(uri)) {
                    //   // Launch the App
                    //   await launchUrl(
                    //     uri,
                    //   );
                    //   // and cancel the request
                    //   return NavigationActionPolicy.CANCEL;
                    // }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
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
