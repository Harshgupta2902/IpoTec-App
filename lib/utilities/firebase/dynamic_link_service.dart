// ignore_for_file: deprecated_member_use

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class CoreDynamicLinksService {
  static init() async {
    final instance = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instance != null) {
      try {
        final Map<String, dynamic> queryParameters = instance.link.queryParameters;
        CoreGlobalRouteHandler.routeHandler(queryParameters: queryParameters);
      } catch (e) {
        debugPrint("dynamic_link_services :::::: Line=15 :::::$e");
      }
    }
  }

  static dynamicLinkListener() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;

      debugPrint("Error receiving dynamic link: deepLink $deepLink");

      final Map<String, dynamic> queryParameters = deepLink.queryParameters;

      CoreGlobalRouteHandler.routeHandler(queryParameters: queryParameters);
    }).onError((error) {
      debugPrint("Error receiving dynamic link: $error");
    });
  }
}

class CoreGlobalRouteHandler {
  static routeHandler({required Map<String, dynamic> queryParameters}) {
    // TODO : ROUTE HANDLER
  }
}
