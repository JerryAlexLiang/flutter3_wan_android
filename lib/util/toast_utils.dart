import 'package:oktoast/oktoast.dart';

class ToastUtils {
  static showToastBottom(String content) {
    showToast(content, position: ToastPosition.bottom);
  }
}
