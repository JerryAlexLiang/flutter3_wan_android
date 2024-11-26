import 'package:dio/dio.dart';
import 'package:flutter3_wan_android/http/request_api.dart';

/// 该拦截器用来检查是否是不同域名的请求，如果不是同一域名，则不适用于初始化时配置的BaseUrl
class BaseUrlRequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? baseUrl = options.extra['newBaseUrl'];
    if (baseUrl != null && baseUrl.isNotEmpty) {
      options.baseUrl = baseUrl;

      // if (baseUrl.startsWith("https://www.mxnzp.com")) {
      if (baseUrl.startsWith(RequestApi.mxnzpBaseUrl)) {
        options.headers = {
          // "project_token": "D54170CB6AA84AA8AFFD2DFC02AC51F5",
          "app_id": "beo7shkjoobvhzmh",
          "app_secret": "WDN2S2pKbmY5Qll1QkM5M1h2Y3Axdz09",
        };
      }
    }
    handler.next(options);
  }
}
