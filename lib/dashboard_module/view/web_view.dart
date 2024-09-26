import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? currentUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        currentUrl = widget.url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: CoreAppBar(
          showBackButton: true,
          showActions: false,
          title: widget.title,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(currentUrl ?? widget.url)),
          onWebViewCreated: (InAppWebViewController controller) {},
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadStart: (controller, url) async {
            debugPrint("onLoadStart:::::::::$url");
            if (url.toString() != widget.url) {
              MyNavigator.pop();
            }
          },
          onLoadError: (controller, url, code, message) async {
            debugPrint("onLoadError:::::::::$url");
            if (url.toString() != widget.url) {
              MyNavigator.pop();
            }
          },
          onLoadStop: (controller, url) async {
            debugPrint("onLoadStop:::::::::$url");

            await controller.evaluateJavascript(source: """
              document.querySelectorAll('a').forEach(function(link) {
                link.onclick = function(event) {
                  event.preventDefault();
                };
              });
            """);

            if (url.toString() != widget.url) {
              MyNavigator.pop();
            }
          },
          onProgressChanged: (controller, progress) async {
            debugPrint("onProgressChanged:::::::::$progress");
          },
        ),
      ),
    );
  }
}
