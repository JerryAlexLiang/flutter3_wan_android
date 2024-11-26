import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/model/article_test_bean.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// 加载状态
  final _loadState = LoadState.simpleShimmerLoading.obs;

  get loadState => _loadState.value;

  set loadState(value) => _loadState.value = value;

  /// 首页文章列表
  final homeArticleList = RxList<ArticleItemBean>();

  @override
  void onReady() {
    super.onReady();
    // 请求首页数据
    getHomeData();
  }

  Future<void> getHomeData() async {
    loadState = LoadState.simpleShimmerLoading;

    /// 当前页数
    int currentPage = 0;

    // https://www.wanandroid.com/article/list/0/json
    String requestUrl =
    RequestApi.homeArticleList.replaceFirst(RegExp('page'), '$currentPage');
    //
    // // 使用泛型基类BasePageListResponse<T> + PageList<T>去解析返回分页List数组类型的JOSN数据
    // BaseResponse response =
    //     await DioUtil().request(requestUrl, method: DioMethod.get);

    // https://www.wanandroid.com/project/list/1/json?cid=294
    var dio = Dio();
    // var request = await dio.request("https://www.wanandroid.com/article/list/0/json");
    var request = await dio.request("https://www.wanandroid.com/project/list/1/json?cid=294");

    var statusCode = request.statusCode;
    if (statusCode == 200) {
      loadState = LoadState.success;

      var articlePageBean = ArticleTestBean.fromJson(request.data);

      List<ArticleItemBean> datas = articlePageBean.data.datas;
      datas[0].fresh = true;
      datas[1].fresh = true;
      datas[2].fresh = true;
      datas[3].fresh = true;
      datas[4].fresh = true;
      datas[5].fresh = true;
      if (datas.isNotEmpty) {
        homeArticleList.addAll(datas);
      }

      LoggerUtil.d(tag: "DioRequest", "==============>1 $request");

      LoggerUtil.d(
          tag: "DioRequest", "==============>2 ${jsonEncode(request.data)}");

      LoggerUtil.d(
          tag: "DioRequest", "==============>3 ${jsonEncode(articlePageBean)}");
    } else {
      loadState = LoadState.fail;
    }

    // var success = response.success;

    // if (success != null) {
    //   if(success){
    //     loadState = LoadState.success;
    //
    //     var data = response.data;
    //     ArticlePageBean articlePageBean = ArticlePageBean.fromJson(data);
    //     List<ArticleItemBean>? datas = articlePageBean.datas;
    //     if (datas != null && datas.isNotEmpty) {
    //       homeArticleList.addAll(datas);
    //     }
    //
    //     LoggerUtil.d(
    //         tag: "DioRequest", "==============> ${jsonEncode(articlePageBean)}");
    //   }
    // }
  }
}
