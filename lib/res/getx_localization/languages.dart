import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    'en_US':{
      'email_hint':'Email',
      'internet_exception': "We're unable to show results.\nPlease check your network\nconnection.",
      'Retry':"Retry",
      'something_went_wrong':"Something went wrong",
      'Login': "Login",
      'password_hint': "Password",
      'enter_email':"Please enter email",
      'enter_password':"Please enter password",
      "login_successfully":"login successfully"

    },
    'ur_PK':{
      'email_hint':"ای میل",
      'internet_exception': "ہم نتائج دکھانے میں ناکام ہیں۔\nبراہ کرم اپنے نیٹ ورک\nکنکشن کی جانچ کریں۔",
      'Retry' : 'دوبارہ کوشش کریں۔',
      'something_went_wrong':" کچھ غلط ہو گیا",
      'Login':"لاگ ان",
      "password_hint":"پاس ورڈ",
      'enter_email':"براہ کرم ای میل درج کریں۔",
      'enter_password':"براہ کرم پاس ورڈ درج کریں۔",
      "login_successfully":"کامیابی سے لاگ ان"
    },
  };
}