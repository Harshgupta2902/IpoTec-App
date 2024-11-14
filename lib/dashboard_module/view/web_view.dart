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
              supportZoom: true,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadStart: (controller, url) async {
            debugPrint("onLoadStart:::::::::$url");
            if (url.toString() != widget.url) {
              MyNavigator.pop();
            }
            if (currentUrl != null && currentUrl.toString().contains("moneycontrol")) {
              evaluateScript(controller);
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
            if (currentUrl != null && currentUrl.toString().contains("moneycontrol")) {
              evaluateScript(controller);
            }
            if (url.toString() != widget.url) {
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
      ),
    );
  }
}

void evaluateScript(InAppWebViewController controller) async {
  await controller.evaluateJavascript(source: """
              document.querySelectorAll('a').forEach(function(link) {
                link.onclick = function(event) {
                  event.preventDefault();
                };
              });
            // document.querySelector('.h12Wrapper.backgroundPrimary.h12BotBorder').remove();
            // document.querySelector('.foot21ExploreHead').remove();
            // document.querySelector('.foot21MoreAbout').remove();
            // document.querySelector('.valign-wrapper.foot21Div').remove();
            // document.querySelector('.foot21Box').remove();
            // document.querySelector('.bfc43CategoryContainer').remove();
            // document.querySelector('.bfc43Title.bodyXLargeHeavy').remove();
            // document.querySelector('.bs91SidebarLinks').remove();
            // document.querySelector('.bmp88Disclaimer').remove();

            """);
}
