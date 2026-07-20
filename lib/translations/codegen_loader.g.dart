// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "q1": "حدد التعبير الذي تشعر به إذا كنت ستزور طبيب الأسنان غدا؟",
  "q2": "حدد التعبير الذي تشعر به إذا تم فحص أسنانك من قبل طبيب الأسنان؟",
  "q3": "حدد التعبير الذي تشعر به إذا تم تنظيف وتلميع أسنانك؟",
  "q4": "حدد التعبير الذي تشعر به إذا كان لديك حقنة صغيرة في اللثة؟",
  "q5": "حدد التعبير الذي تشعر به إذا كنت تحصل على حشوة في سنك؟",
  "q6": "حدد التعبير الذي تشعر به إذا كنت تعاني من خلع سن؟",
  "q7": "حدد التعبير الذي تشعر به إذا كنت تنام من أجل علاج أسنانك؟",
  "q8": "حدد التعبير الذي تشعر به إذا كان لديك مزيج من الغازات والهواء ، مما سيساعدك على الشعور بالراحة للعلاج ولكن لا يمكنه أن ينام؟"
};
static const Map<String,dynamic> en = {
  "q1": "Select the expression that you feel if you are visiting the dentist tomorrow?",
  "q2": "Select the expression that you feel if your teeth are examined by the dentist?",
  "q3": "Select the expression that you feel if your teeth are cleaned and polished?",
  "q4": "Select the expression that you feel if you are having a small injection in the gums?",
  "q5": "Select the expression that you feel if you are getting a filling in your tooth?",
  "q6": "Select the expression that you feel if you are having a tooth taken out?",
  "q7": "Select the expression that you feel if you are being put to sleep for the treatment of your teeth?",
  "q8": "Select the expression that you feel if you are having a mixture of gas and air which will help you feel comfortable for treatment but cannot put you to sleep?"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
