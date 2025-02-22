import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DonationAlertsWidgetWebview extends StatefulWidget {
  const DonationAlertsWidgetWebview({super.key});

  @override
  State<DonationAlertsWidgetWebview> createState() =>
      _DonationAlertsWidgetWebviewState();
}

class _DonationAlertsWidgetWebviewState
    extends State<DonationAlertsWidgetWebview> {
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

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: InAppWebView(
          key: _webViewKey,
          initialUrlRequest: URLRequest(
            url: WebUri(
              "https://www.donationalerts.com/widget/lastdonations?alert_type=1,4,6,13,15,11,19,18,17,16,14,32,12&limit=25&token=MzxsVc0dOQRsHf6RGWvW",
            ),
          ),
          initialSettings: _settings,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) async {
            _webViewController = controller;
          },
          onLoadStart: (controller, url) {},
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

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
          onLoadStop: (controller, url) {
            pullToRefreshController?.endRefreshing();
          },
          onReceivedError: (controller, request, error) {
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }
          },
          onUpdateVisitedHistory: (controller, url, isReload) {},
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ),
      );
}
