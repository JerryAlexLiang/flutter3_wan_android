import 'package:connectivity_plus/connectivity_plus.dart';

/// 类名: connectivity_utils.dart
/// 创建日期: 11/11/21 on 2:57 PM
/// 描述: 检查当前网络连接状态
/// 作者: 杨亮

enum ConnectivityState { mobile, ethernet, wifi, none }

class ConnectivityUtils {
  /// 检查当前状态
  static Future<ConnectivityState> checkConnectivity() async {
    late ConnectivityState state;

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    for (var value in connectivityResult) {
      if (value == ConnectivityResult.mobile) {
        /// Mobile: Device connected to cellular network
        state = ConnectivityState.mobile;
      } else if (value == ConnectivityResult.ethernet) {
        /// Ethernet: Device connected to ethernet network
        state = ConnectivityState.ethernet;
      } else if (value == ConnectivityResult.wifi) {
        /// WiFi: Device connected via Wi-Fi
        state = ConnectivityState.wifi;
      } else if (value == ConnectivityResult.none) {
        /// None: Device not connected to any network
        state = ConnectivityState.none;
      }
    }
    return state;
  }
}
