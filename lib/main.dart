import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_wan_android/config/config.dart';
import 'package:flutter3_wan_android/http/base_page_list_response.dart';
import 'package:flutter3_wan_android/routes/app_pages.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/util/keyboard_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'model/user.dart';

void main() {
  // 初始化
  Config.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return Scaffold(
              // Global GestureDetector that will dismiss the keyboard
              // 关闭键盘的全局手势检测器
              body: GestureDetector(
                child: child,
                onTap: () => KeyboardUtils.hideKeyboard(context),
              ),
            );
          },
          enableLog: true,
          smartManagement: SmartManagement.keepFactory,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return RefreshConfiguration(
//       hideFooterWhenNotFull: false,
//       child: ScreenUtilInit(
//         designSize: const Size(360, 690),
//         builder: (context, child) {
//           return OKToast(
//
//               /// 导致弹出系统粘贴时红屏原因为FlutterEasyLoading在materialApp上层，
//               /// 导致系统粘贴时的弹框找到顶层时widget不是material报错.修复方式为将FlutterEasyLoading改为build时引入
//               child: ScreenUtilInit(
//             designSize: const Size(360, 690),
//             builder: (context, child) => GetMaterialApp(
//               debugShowCheckedModeBanner: false,
//               builder: (context, child) {
//                 return FlutterEasyLoading(
//                     child: Scaffold(
//                   // Global GestureDetector that will dismiss the keyboard
//                   // 关闭键盘的全局手势检测器
//                   body: GestureDetector(
//                     child: child,
//                     onTap: () => KeyboardUtils.hideKeyboard(context),
//                   ),
//                 ));
//               },
//               enableLog: true,
//               smartManagement: SmartManagement.keepFactory,
//               themeMode: ThemeMode.light,
//               initialRoute: AppRoutes.splash,
//               getPages: AppPages.routes,
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

      //   const jsonString = '{"name": "Jerry","email": "Jerry@example.com"}';
      //
      //   // jsonDecode 解码:解析字符串并返回结果Json对象
      //   Map<String, dynamic> userMap = jsonDecode(jsonString);
      //   // final userMap = jsonDecode(jsonString);
      //
      //   if (kDebugMode) {
      //     print('\n =====================解析对象开始============================ \n ');
      //     // User jsonDecode  {name: Jerry, email: Jerry@example.com}
      //     print('User jsonDecode  $userMap');
      //   }
      //
      //   var user = User.fromJson(userMap);
      //   var user2 = User2.fromJson(userMap);
      //
      //   //jsonEncode(user)
      //   if (kDebugMode) {
      //     // User1 :  Instance of 'User'
      //     print('User1 :  $user');
      //     // User1 toString :  Instance of 'User'
      //     print('User1 toString :  ${user.toString()}');
      //     // User1 toJson :  {name: Jerry, email: Jerry@example.com}
      //     print('User1 toJson :  ${user.toJson()}');
      //     // User1 jsonEncode :  {"name":"Jerry","email":"Jerry@example.com"}
      //     print('User1 jsonEncode :  ${jsonEncode(user)}');
      //     // User1 name :  Jerry
      //     print('User1 name :  ${user.name}');
      //     // User1 email :  Jerry@example.com
      //     print('User1 email :  ${user.email}');
      //   }
      //   if (kDebugMode) {
      //     // User2 :  Instance of 'User2'
      //     print('User2 :  $user2');
      //     // User2 toString :   Instance of 'User2'
      //     print('User2 toString :   ${user2.toString()}');
      //     // User2 toJson :  {name: Jerry, email: Jerry@example.com}
      //     print('User2 toJson :  ${user2.toJson()}');
      //     // User2 jsonEncode :  {"name":"Jerry","email":"Jerry@example.com"}
      //     print('User2 jsonEncode :  ${jsonEncode(user2)}');
      //     // User2 name :  Jerry
      //     print('User2 name :  ${user2.name}');
      //     // User2 email :  Jerry@example.com
      //     print('User2 email :  ${user2.email}');
      //   }
      //
      //   if (kDebugMode) {
      //     print('\n =====================解析对象结束============================ \n ');
      //   }
    });

    decodeAssetJson();
  }

  Future decodeAssetJson() async {
    // 解析本地数据-List数组
    Map<String, dynamic> userListMap =
        await loadJsonAssets("assets/user_list.json");

    // if (kDebugMode) {
    //   print('\n =======================解析数组开始========================== \n ');
    //   // userListMap : {code: 0, message: Success, users: [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]}
    //   print('userListMap  : $userListMap');
    //   // userListMap toString : {code: 0, message: Success, users: [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]}
    //   print('userListMap toString : ${userListMap.toString()}');
    //   // userListMap jsonEncode :  {"code":0,"message":"Success","users":[{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]}
    //   print('userListMap jsonEncode :  ${jsonEncode(userListMap)}');
    // }

    // // 方法1 : 整个JSON串解析成Model对象
    // var userListBean = UserList.fromJson(userListMap);
    //
    // if (kDebugMode) {
    //   print('\n =======================解析数组开始1========================== \n ');
    //   // UserList toString : Instance of 'UserList'
    //   print('UserList toString : ${userListBean.toString()}');
    //   // UserList toJson : {code: 0, message: Success, users: [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]}
    //   print('UserList toJson : ${userListBean.toJson()}');
    //
    //   var users = userListBean.data;
    //
    //   if (users.isNotEmpty) {
    //     for (int i = 0; i < (users.length); i++) {
    //       // UserList  : => 0   [Instance of 'User', Instance of 'User', Instance of 'User']
    //       // UserList  : => 1   [Instance of 'User', Instance of 'User', Instance of 'User']
    //       // UserList  : => 2   [Instance of 'User', Instance of 'User', Instance of 'User']
    //       print('UserList  : => $i   $users');
    //       // UserList toString : => 0   Instance of 'User'
    //       // UserList toString : => 1   Instance of 'User'
    //       // UserList toString : => 2   Instance of 'User'
    //       print('UserList toString : => $i   ${users[i].toString()}');
    //       // UserList toJson : => 0   {name: Jerry, email: Jerry@example.com}
    //       // UserList toJson : => 1   {name: Alex, email: Alex@example.com}
    //       // UserList toJson : => 2   {name: Tom, email: Tom@example.com}
    //       print('UserList toJson : => $i   ${users[i].toJson()}');
    //       // UserList jsonEncode : => 0   {"name":"Jerry","email":"Jerry@example.com"}
    //       // UserList jsonEncode : => 1   {"name":"Alex","email":"Alex@example.com"}
    //       // UserList jsonEncode : => 2   {"name":"Tom","email":"Tom@example.com"}
    //       print('UserList jsonEncode : => $i   ${jsonEncode(users[i])}');
    //       // UserList name : => 0   Jerry
    //       // UserList name : => 1   Alex
    //       // UserList name : => 2   Tom
    //       print('UserList name : => $i   ${users[i].name}');
    //       // UserList email : => 0   Jerry@example.com
    //       // UserList email : => 1   Alex@example.com
    //       // UserList email : => 2   Tom@example.com
    //       print('UserList email : => $i   ${users[i].email}');
    //     }
    //   }
    //   print('\n =======================解析数组结束1========================== \n ');
    // }

    // // 方法2: 只获取返回对象中的List数组
    // if (kDebugMode) {
    //   var usersMap = userListMap["data"];
    //   print('\n =======================解析数组开始2========================== \n ');
    //   // usersMap :  [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]
    //   print('usersMap :  $usersMap');
    //   // usersMap toString:  [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]
    //   print('usersMap toString:  ${usersMap.toString()}');
    //
    //   // jsonEncode转换字符串
    //   String userMapJson = jsonEncode(usersMap);
    //
    //   // userMapJson jsonEncode:  [{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]
    //   print('userMapJson jsonEncode:  $userMapJson');
    //
    //   // 列表转换时一定要加一下强转List<dynamic>，否则会报错
    //   var list = usersMap.map((e) => User.fromJson(e)).toList();
    //
    //   // UserList-list :  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list :  $list');
    //   // UserList-list toString:  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list toString:  ${list.toString()}');
    //   print('UserList-list jsonEncode:  ${jsonEncode(list)}');
    //
    //   if (list.isNotEmpty) {
    //     for (int i = 0; i < (list.length); i++) {
    //       // UserList : => 0   Instance of 'User'
    //       print('UserList  : => $i   ${list[i].toString()}');
    //       // UserList toString : => 0   Instance of 'User'
    //       print('UserList toString : => $i   ${list[i].toString()}');
    //       // UserList toJson : => 0   {name: Jerry, email: Jerry@example.com}
    //       print('UserList toJson : => $i   ${list[i].toJson()}');
    //       // UserList jsonEncode : => 0   {"name":"Jerry","email":"Jerry@example.com"}
    //       print('UserList jsonEncode : => $i   ${jsonEncode(list[i])}');
    //       // UserList name : => 0   Jerry
    //       print('UserList name : => $i   ${list[i].name}');
    //       // UserList email : => 0   Jerry@example.com
    //       print('UserList email : => $i   ${list[i].email}');
    //     }
    //   }
    //   print('\n =======================解析数组结束2========================== \n ');
    // }

    // 方法3: 使用泛型

    // 数据类型1 解析本地数据-List数组
    // 硬编码String-JSON字符串
    // String jsonStr =
    //     '{"code":0,"message":"Success","data":[{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]}';
    // Map<String, dynamic> jsonMap = jsonDecode(jsonStr);

    // // 方法1-BaseResponse<T> 泛型 - 在一般情况下 data 是一个数组
    // // 列表转换时一定要加一下强转List<dynamic>，否则会报错:type 'List<dynamic>' is not a subtype of type 'List<User>'
    // BaseResponse<List<User>> userListMap2 = BaseResponse.fromJson(
    //     userListMap,
    //     (json) => (json as List<dynamic>)
    //         // .map((e) => User.fromJson(e as Map<String, dynamic>))
    //         .map((e) => User.fromJson(e))
    //         .toList());
    //
    // var usersMap = userListMap2.data;
    //
    // if (kDebugMode) {
    //   print('\n =======================使用泛型解析开始========================== \n ');
    //   //  userListMap2  : Instance of 'BaseResponse<List<User>>'
    //   print('userListMap2*  : $userListMap2');
    //   print('userListMap2* message : ${userListMap2.message}');
    //   print('userListMap2* code : ${userListMap2.code}');
    //   print('userListMap2* data : ${userListMap2.data}');
    //   // userListMap2 toString : Instance of 'BaseResponse<List<User>>'
    //   print('userListMap2* toString : ${userListMap2.toString()}');
    // }

    // if (kDebugMode) {
    //   print(
    //       '\n =======================解析数组开始3========================== \n ');
    //   // usersMap :  [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]
    //   print('usersMap :  $usersMap');
    //   // usersMap toString:  [{name: Jerry, email: Jerry@example.com}, {name: Alex, email: Alex@example.com}, {name: Tom, email: Tom@example.com}]
    //   print('usersMap toString:  ${usersMap.toString()}');
    //
    //   // jsonEncode转换字符串
    //   String userMapJson = jsonEncode(usersMap);
    //
    //   // userMapJson jsonEncode:  [{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]
    //   print('userMapJson jsonEncode:  $userMapJson');
    //
    //   List<User>? list = userListMap2.data;
    //
    //   // UserList-list :  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list :  $list');
    //   // UserList-list toString:  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list toString:  ${list.toString()}');
    //   print('UserList-list jsonEncode:  ${jsonEncode(list)}');
    //
    //   if (list != null && list.isNotEmpty) {
    //     for (int i = 0; i < (list.length); i++) {
    //       // UserList : => 0   Instance of 'User'
    //       print('UserList  : => $i   ${list[i].toString()}');
    //       // UserList toString : => 0   Instance of 'User'
    //       print('UserList toString : => $i   ${list[i].toString()}');
    //       // UserList toJson : => 0   {name: Jerry, email: Jerry@example.com}
    //       print('UserList toJson : => $i   ${list[i].toJson()}');
    //       // UserList jsonEncode : => 0   {"name":"Jerry","email":"Jerry@example.com"}
    //       print('UserList jsonEncode : => $i   ${jsonEncode(list[i])}');
    //       // UserList name : => 0   Jerry
    //       print('UserList name : => $i   ${list[i].name}');
    //       // UserList email : => 0   Jerry@example.com
    //       print('UserList email : => $i   ${list[i].email}');
    //     }
    //   }
    //   print(
    //       '\n =======================解析数组结束3========================== \n ');
    // }

    // 数据类型2-BaseResponse<T> + BaseList<T>  - 在分页相关接口，data 是一个对象
    // 解析方法1-生成data对应的Bean：user_page_bean.dart，然后结合base_response.dart
    // 解析本地数据-List数组
    Map<String, dynamic> json2Map =
        await loadJsonAssets("assets/user_list2.json");
    String jsonString =
        '{"data":{"curPage":1,"datas":[{"name":"肖战","email":"肖战@example.com"},{"name":"丁程鑫","email":"丁程鑫@example.com"},{"name":"贺峻霖","email":"贺峻霖@example.com"},{"name":"李天泽","email":"李天泽@example.com"},{"name":"刘耀文","email":"刘耀文@example.com"},{"name":"成毅","email":"成毅@example.com"}],"offset":0,"over":false,"pageCount":3,"size":20,"total":46},"code":0,"message":"Success"}';
    // var json2 = jsonDecode(jsonString);
    // var json2Encode = jsonEncode(jsonString);

    var json2Encode = jsonEncode(json2Map);

    // BaseResponse<UserPageBean> userListMap3 =
    //     BaseResponse.fromJson(json2Map, (json) => UserPageBean.fromJson(json));
    //
    // var datas = userListMap3.data?.datas;
    //
    // if (kDebugMode) {
    //   print('\n =======================使用泛型解析开始========================== \n ');
    //   print('json2*  : $json2Map');
    //   print('json2Encode*  : $json2Encode');
    //   print('userListMap3*  : $userListMap3');
    //   print('userListMap3* toString : ${userListMap3.toString()}');
    //   print('userListMap3* message : ${userListMap3.message}');
    //   print('userListMap3* code : ${userListMap3.code}');
    //   print('userListMap3* data : ${userListMap3.data}');
    //   print('userListMap3* datas jsonEncode: ${jsonEncode(datas)}');
    //
    //   print('\n ====================================================== \n ');
    //   print('usersMap2*  : $datas');
    //   print('usersMap2* toString : ${datas.toString()}');
    //   print('usersMap2* toList : ${datas?.toList()}');
    // }
    //
    // if (kDebugMode) {
    //   print('\n =======================解析数组开始4========================== \n ');
    //
    //   // jsonEncode转换字符串
    //   String userMapJson2 = jsonEncode(datas);
    //
    //   // userMapJson jsonEncode:  [{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]
    //   print('userMapJson2 jsonEncode:  $userMapJson2');
    //
    //   // UserList-list :  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list :  $datas');
    //   // UserList-list toString:  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list toString:  ${datas.toString()}');
    //
    //   if (datas != null && datas.isNotEmpty) {
    //     for (int i = 0; i < (datas.length); i++) {
    //       // UserList : => 0   Instance of 'User'
    //       print('UserList2  : => $i   ${datas[i].toString()}');
    //       // UserList toString : => 0   Instance of 'User'
    //       print('UserList2 toString : => $i   ${datas[i].toString()}');
    //       // UserList toJson : => 0   {name: Jerry, email: Jerry@example.com}
    //       print('UserList2 toJson : => $i   ${datas[i].toJson()}');
    //       // UserList jsonEncode : => 0   {"name":"Jerry","email":"Jerry@example.com"}
    //       print('UserList2 jsonEncode : => $i   ${jsonEncode(datas[i])}');
    //       // UserList name : => 0   Jerry
    //       print('UserList2 name : => $i   ${datas[i].name}');
    //       // UserList email : => 0   Jerry@example.com
    //       print('UserList2 email : => $i   ${datas[i].email}');
    //     }
    //   }
    //   print('\n =======================解析数组结束4========================== \n ');
    //   print('\n =======================使用泛型解析结束========================== \n ');
    // }

    // BaseResponse<BaseList<User>> userListMap3 = BaseResponse.fromJson(json2Map,
    //     (json) => BaseList.fromJson(json, (json) => User.fromJson(json)));
    //
    // BaseList<User>? baseUsers = userListMap3.data;
    // // var datas = baseUsers?.datas;
    // List<User>? usersMap3 = baseUsers?.datas;

    // if (kDebugMode) {
    //   print('\n =======================使用泛型解析开始========================== \n ');
    //
    //   print('\n ====================================================== \n ');
    //   print('userListMap3*  : $userListMap3');
    //   print('userListMap3* message : ${userListMap3.message}');
    //   print('userListMap3* code : ${userListMap3.code}');
    //   print('userListMap3* data : ${userListMap3.data}');
    //   print('userListMap3* toString : ${userListMap3.toString()}');
    //
    //   print('\n ====================================================== \n ');
    //   print('baseUsers*  : $baseUsers');
    //   print('baseUsers* datas : ${baseUsers?.datas}');
    //
    //   print('\n ====================================================== \n ');
    //   print('usersMap3*  : $usersMap3');
    //   print('usersMap3* toString : ${usersMap3.toString()}');
    //   print('usersMap3* toList : ${usersMap3?.toList()}');
    // }
    //
    // if (kDebugMode) {
    //   print('\n =======================解析数组开始5========================== \n ');
    //
    //   // jsonEncode转换字符串
    //   String userMapJson3 = jsonEncode(usersMap3);
    //
    //   // userMapJson jsonEncode:  [{"name":"Jerry","email":"Jerry@example.com"},{"name":"Alex","email":"Alex@example.com"},{"name":"Tom","email":"Tom@example.com"}]
    //   print('userMapJson3 jsonEncode:  $userMapJson3');
    //
    //   // UserList-list :  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list :  $usersMap3');
    //   // UserList-list toString:  [Instance of 'User', Instance of 'User', Instance of 'User']
    //   print('UserList-list toString:  ${usersMap3.toString()}');
    //
    //   if (usersMap3 != null && usersMap3.isNotEmpty) {
    //     for (int i = 0; i < (usersMap3.length); i++) {
    //       // UserList : => 0   Instance of 'User'
    //       print('UserList3  : => $i   ${usersMap3[i].toString()}');
    //       // UserList toString : => 0   Instance of 'User'
    //       print('UserList3 toString : => $i   ${usersMap3[i].toString()}');
    //       // UserList toJson : => 0   {name: Jerry, email: Jerry@example.com}
    //       print('UserList3 toJson : => $i   ${usersMap3[i].toJson()}');
    //       // UserList jsonEncode : => 0   {"name":"Jerry","email":"Jerry@example.com"}
    //       print('UserList3 jsonEncode : => $i   ${jsonEncode(usersMap3[i])}');
    //       // UserList name : => 0   Jerry
    //       print('UserList3 name : => $i   ${usersMap3[i].name}');
    //       // UserList email : => 0   Jerry@example.com
    //       print('UserList3 email : => $i   ${usersMap3[i].email}');
    //     }
    //   }
    //   print('\n =======================解析数组结束5========================== \n ');
    //   print('\n =======================使用泛型解析结束========================== \n ');
    // }

    // // 使用泛型基类BaseListResponse<T>去解析返回List数组类型的JOSN数据
    // BaseListResponse<User> result =
    //     BaseListResponse.fromJson(userListMap, (json) => User.fromJson(json));
    //
    // List<User> list = result.data;
    //
    // if (kDebugMode) {
    //   print('\n ===============BaseListResponse解析数组开始================== \n ');
    //
    //   print('result : $result');
    //   print('result toString : ${result.toString()}');
    //
    //   if (list.isNotEmpty) {
    //     for (int i = 0; i < (list.length); i++) {
    //       print('result list $i : ${list[i].name}');
    //       print('result list $i : ${list[i].email}');
    //     }
    //   }
    //
    //   print('\n ===============BaseListResponse解析数组结束================== \n ');
    // }

    // 使用泛型基类BasePageListResponse<T> + PageList<T>去解析返回分页List数组类型的JOSN数据
    BasePageListResponse<User> result2 =
        BasePageListResponse.fromJson(json2Map, (json) => User.fromJson(json));

    // PageList<User> data = result2.data;
    var data = result2.data;
    // List<User> list2 = data.datas;
    var list2 = data.datas;

    if (kDebugMode) {
      print(
          '\n ===============BasePageListResponse解析数组开始================== \n ');

      print('result : $result2');
      print('result toString : ${result2.toString()}');
      print('result code : ${result2.code}');
      print('result message : ${result2.message}');
      print('result data : ${result2.data}');
      print('result datas : ${result2.data.datas}');
      print('result data curPage: ${result2.data.curPage}');
      print('result datas jsonEncode: ${jsonEncode(result2.data.datas)}');

      if (list2.isNotEmpty) {
        for (int i = 0; i < (list2.length); i++) {
          print('result list $i : ${list2[i].name}');
          print('result list $i : ${list2[i].email}');
        }
      }

      print(
          '\n ===============BasePageListResponse解析数组结束================== \n ');
    }
  }

  // 加载本地数据
  dynamic loadJsonAssets(String asset) async {
    // 通过rootBundle.loadString()解析并返回
    var data = await rootBundle.loadString(asset);
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
