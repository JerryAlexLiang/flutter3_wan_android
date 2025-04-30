import 'package:flutter3_wan_android/res/strings.dart';

class Language {
  String? name;
  String? language;
  String? country;
  bool? isSelect;

  Language({this.name, this.language, this.country, this.isSelect = false});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'];
    country = json['country'];
    isSelect = json['isSelect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['language'] = language;
    data['country'] = country;
    data['isSelect'] = isSelect;
    return data;
  }
}

///新增语言要在此处手动增加
final supportLanguageList = [
  Language(name: StringsConstant.systemMode, language: '', country: ''),
  Language(
      name: StringsConstant.simplifiedChinese, language: 'zh', country: 'CN'),
  Language(
      name: StringsConstant.traditionalChineseHongKong,
      language: 'zh',
      country: 'HK'),
  Language(name: StringsConstant.usEnglish, language: 'en', country: 'US'),
];
