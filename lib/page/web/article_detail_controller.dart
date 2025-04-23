import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 创建日期: 2025/04/23 13:54
/// 作者: Jerry
/// 描述: 文章详情web页

class ArticleDetailController extends BaseGetXController {
  /// 收藏动画显示与否
  final _collectAnimation = false.obs;

  get collectAnimation => _collectAnimation.value;

  set collectAnimation(value) => _collectAnimation.value = value;

  /// 取消收藏动画显示与否
  final _unCollectAnimation = false.obs;

  get unCollectAnimation => _unCollectAnimation.value;

  set unCollectAnimation(value) => _unCollectAnimation.value = value;

  late WebViewController webViewController;

  /////进度条
  final _webProgress = 0.0.obs;

  get webProgress => _webProgress.value;

  set webProgress(value) => _webProgress.value = value;

  /// 第一次进入WebView显示加载页面
  final _isFirstInitWeb = true.obs;

  get isFirstInitWeb => _isFirstInitWeb.value;

  set isFirstInitWeb(value) => _isFirstInitWeb.value = value;

  /// 当前网页Title
  String? currentTitle;

  // 当前页面链接
  var currentPageUrl = "";

  // 收藏、取消收藏接口路径
  late String requestURL;

  late Future future;

  @override
  void onInit() {
    super.onInit();
    initializeWebView();
  }

  void initializeWebView() {
    webViewController = WebViewController()
      ..enableZoom(true)
      // 默认禁止js
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          onPageStarted(url);
        },
        onProgress: (progress) {
          updateWebProgress(progress);
        },
        onPageFinished: (url) {
          onPageFinished(url);
        },
        onWebResourceError: (WebResourceError error) {
          onWebResourceError(error);
        },
        onUrlChange: (change) => currentPageUrl = change.url ?? '',
      ))
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  void loadUrl(String url) {
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }
    webViewController.loadRequest(Uri.parse(url));
  }

  /// 刷新页面
  void reloadWebView() {
    webViewController.reload();
  }

  void onPageStarted(String url) {
    webCanBack();
    // 显示加载动画页面
    unCollectAnimation = true;
  }

  void onPageFinished(String url) {
    webCanBack();
    // 关闭加载动画页面
    unCollectAnimation = false;
    // 当前页面链接
    currentPageUrl = url;
  }

  void onWebResourceError(WebResourceError error) {
    webCanBack();
    // 关闭加载动画页面
    unCollectAnimation = false;
  }

  /// WebView加载页面进度
  void updateWebProgress(int progress) {
    webProgress = (progress / 100).toDouble();
    webCanBack();
  }

  Future<void> webCanBack() async {
    currentTitle = await webViewController.getTitle();

    if (await webViewController.canGoBack()) {
      // Web页面可以返回，非首页
      isFirstInitWeb = false;
    } else {
      // Web页面不可以返回，首页
      isFirstInitWeb = true;
    }
  }

  Future<bool> onWillPop() async {
    //点击返回键时回调
    if (await webViewController.canGoBack()) {
      //如果WebView可以返回
      webViewController.goBack();
      //WebView返回，界面不返回
      return false;
    } else {
      //否则界面返回，且恢复第一次进入标志
      isFirstInitWeb = true;
      return true;
    }
  }
}
