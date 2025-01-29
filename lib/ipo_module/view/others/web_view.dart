import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
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
  bool isLoading = true;

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
          centerTitle: false,
          title: widget.title,
          openBrowser: GestureDetector(
            onTap: () async {
              await openUrlInBrowser(widget.url);
            },
            child: const Icon(Icons.open_in_browser),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(currentUrl ?? widget.url)),
              onWebViewCreated: (InAppWebViewController controller) {},
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  supportZoom: true,
                  allowFileAccessFromFileURLs: false,
                ),
              ),
              onLoadStart: (controller, url) async {
                debugPrint("onLoadStart:::::::::$url");
                setState(() {
                  isLoading = true;
                });
                if (url.toString().replaceAll("#goog_rewarded", "") != widget.url) {
                  MyNavigator.pop();
                }
                if (currentUrl != null && currentUrl.toString().contains("moneycontrol")) {
                  evaluateScript(controller);
                }
              },
              onLoadError: (controller, url, code, message) async {
                debugPrint("onLoadError:::::::::$url");
                if (url.toString().replaceAll("#goog_rewarded", "") != widget.url) {
                  MyNavigator.pop();
                }
                MyNavigator.pop();
                setState(() {
                  isLoading = false;
                });
              },
              onLoadStop: (controller, url) async {
                debugPrint("onLoadStop:::::::::$url");
                setState(() {
                  isLoading = false;
                });
                if (currentUrl != null && currentUrl.toString().contains("moneycontrol")) {
                  evaluateScript(controller);
                }
                if (url.toString().replaceAll("#goog_rewarded", "") != widget.url) {
                  MyNavigator.pop();
                }
              },
              onProgressChanged: (controller, progress) async {
                debugPrint("onProgressChanged:::::::::$progress");
                if (currentUrl != null && currentUrl.toString().contains("moneycontrol")) {
                  evaluateScript(controller);
                }
              },
            ),
            if (isLoading)
              Positioned(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}

void evaluateScript(InAppWebViewController controller) async {
  await controller.evaluateJavascript(
    source: """
      document.querySelectorAll('a').forEach(function(link) {
        link.onclick = function(event) {
          event.preventDefault();
        };
      });
      document.querySelector('.header')?.remove();
      document.querySelector('nav.navbar')?.remove(); // Ensures navbar removal
    """,
  );
}
