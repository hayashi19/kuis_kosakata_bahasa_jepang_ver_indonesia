import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/native_admob_controller.dart';
// ignore: import_of_legacy_library_into_null_safe
 import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Import classes
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/wordList/adjective.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/wordList/noun.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/wordList/verb.dart';

 //////////////////////////////////////////////////////////////////////////////////////////////////// THEME
 class AppTheme {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFBC002D),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF1D1E2C),
      foregroundColor: Color(0xFFACE8DD),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF3B1C32),
      backgroundColor: Color(0xFFBC002D)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFFBC002D),
        onPrimary: Colors.white,
        shadowColor: Colors.redAccent[400],
        elevation: 6,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold
        )
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: const Color(0xFFBC002D),
      )
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFBC002D),
      titleTextStyle: TextStyle(
        color: Colors.white
      )
    ),
    cardTheme: CardTheme(
      color: Colors.grey[50],
      elevation: 4,
      shadowColor: Colors.black
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white, 
    )
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF55192A),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFACE8DD),
      foregroundColor: Color(0xFF1D1E2C),
    ),
    scaffoldBackgroundColor: const Color(0xFF1D1E2C),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFFACE8DD),
      unselectedItemColor: Color(0xFFFEE4B6),
      backgroundColor: Color(0xFF55192A),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF55192A),
        onPrimary: Colors.white,
        shadowColor: const Color(0xFFBC002D),
        elevation: 6,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold
        )
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: const Color(0xFFACE8DD),
      )
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF55192A),
      titleTextStyle: TextStyle(
        color: Colors.white
      )
    ),
    cardTheme: CardTheme(
      color: Colors.blueGrey[900],
      elevation: 4,
      shadowColor: Colors.grey[900]
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1D1E2C), 
    )
  );
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  
  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  
  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  
  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// THEME

////////////////////////////////////////////////////////////////////////////////////////////////////  HOME CONTROLLER
class HomePageController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageViewController;

  changeIndex(index) => currentIndex.value = index;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    pageViewController = PageController(initialPage: currentIndex.value);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// HOME CONTROLLER

//////////////////////////////////////////////////////////////////////////////////////////////////// QUIZ CONTROLLER
class QuizPageController extends GetxController {
  
  // SCORE SECTION
  var trueScore = 0.obs;
  var falseScore = 0.obs;
  var falseOrTrue = "".obs;
  var falseOrTrueColor = (Colors.lightGreen).obs;

  // QUESTION SECTION
  var kanjiVisibility = true.obs;
  var romajiVisibility = false.obs;
  var bahasaVisibility = true.obs;
  final quizWordList = RxList([]);
  var rand = 0.obs;

  // SETTING SECTION
  final answerTypeItem = ['Kanji', 'Romaji', 'Bahasa'].obs;
  var answerTypeValue = "Romaji".obs;
  final wordTypeItem = ["Kata Kerja", "Kata Sifat", "Kata Benda"].obs;
  var wordTypeValue = "Kata Kerja".obs;
  final levelTypeItem = ["N5", "N4"].obs;
  var levelTypeValue = "N5".obs;

  // TEXTFIELD SECTION
  TextEditingController submitTextfield = TextEditingController();

  // ONCREATE
  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    quizWordList.value = json.decode(verb)[levelTypeValue.value];
    rand.value = Random().nextInt(quizWordList.length);
  }

  // FUNCTION SECTION
  // function for set the rand number variable to get the rand number
  randNum() => rand.value = Random().nextInt(quizWordList.length);

  // QUIZ ADS
  var quizBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var quizBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var quizAdsController = NativeAdmobController();

  changeWordType(wordType, levelType) {
    switch (wordType) {
      case "Kata Kerja":
        quizWordList.value = json.decode(verb)[levelType];
        randNum();
        break;
      case "Kata Sifat":
        quizWordList.value = json.decode(adjective)[levelType];
        randNum();
        break;
      case "Kata Benda":
        quizWordList.value = json.decode(noun)[levelType];
        randNum();
        break;
      default:
    }
  }

  // set the visibility function to visibilty change base on answer type
  wordVisibility(answerType) {
    switch (answerType) {
      case "Kanji":
        romajiVisibility.value = bahasaVisibility.value = true;
        kanjiVisibility.value = false;
        break;
      case "Romaji":
        kanjiVisibility.value = bahasaVisibility.value = true;
        romajiVisibility.value = false;
        break;
      case "Bahasa":
        kanjiVisibility.value = romajiVisibility.value = true;
        bahasaVisibility.value = false;
        break;
      default:
    }
  }

  // if answer false
  answerFalse(answerType) {
    falseScore.value++;
    kanjiVisibility.value = romajiVisibility.value = bahasaVisibility.value = true;
    falseOrTrue.value = "SALAH";
    falseOrTrueColor.value = Colors.red;
    submitTextfield.clear();
    Future.delayed(const Duration(seconds: 3), () {
      wordVisibility(answerType);
      falseOrTrue.value = "";
      randNum();
    });
  }

  // if answer true
  answerTrue() {
    randNum();
    trueScore.value++;
    submitTextfield.clear();
    falseOrTrue.value = "BENAR";
    falseOrTrueColor.value = Colors.green;
    Future.delayed(const Duration(seconds: 1), () {
      falseOrTrue.value = "";
    });
  }

  // function for checking the answer
  checkAnswer(answerType) {
    // check which answer tyle that user use, than execute the function if answer base on answer type is same as the question
    switch (answerType) {
      case "Kanji":
        if (submitTextfield.text.contains(quizWordList[rand.value]["KanjiCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      case "Romaji":
        if (submitTextfield.text.contains(quizWordList[rand.value]["RomajiCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      case "Bahasa":
        if (submitTextfield.text.contains(quizWordList[rand.value]["BahasaCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      default:
    }
  }

}
//////////////////////////////////////////////////////////////////////////////////////////////////// QUIZ CONTROLLER

//////////////////////////////////////////////////////////////////////////////////////////////////// DICTIONARY CONTROLLER
class DictionaryPageController extends GetxController {
  // This file is place for drop down menu that acces to all widget
  // Menu for word type
  final wordTypeItemDic = ["Kata Kerja", "Kata Sifat", "Kata Benda"].obs;
  var wordTypeValueDic = "Kata Kerja".obs;
  // Menu for level
  final levelTypeItemDic = ["N5", "N4"].obs;
  var levelTypeValueDic = "N5".obs;

  // Textfield controler for search word in list dictionary
  TextEditingController txtQuery = TextEditingController();

  // Variable for list view to get json list
  final dictionaryWordList = RxList(json.decode(verb)["N5"] + json.decode(verb)["N4"] + json.decode(adjective)["N5"] + json.decode(adjective)["N4"] + json.decode(noun)["N5"] + json.decode(noun)["N4"]);
  var foundWord = [].obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    foundWord.value = dictionaryWordList;
    dictionaryWordList.sort((a, b) => a["RomajiCasualPositive"].compareTo(b["RomajiCasualPositive"]));
  }

  // ADS
  var dictionaryBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictionaryBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictionaryBannerExtra = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictoinaryAdsController = NativeAdmobController();

  // This function is called whenever the text field changes
  void searchFIlter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = dictionaryWordList;
    } else {
      results = dictionaryWordList.where((words) {
        final kanji = words["KanjiCasualPositive"].toLowerCase();
        final romaji = words["RomajiCasualPositive"].toLowerCase();
        final bahasa = words["BahasaCasualPositive"].toLowerCase();
        final searchLower = enteredKeyword.toLowerCase();

        return kanji.contains(searchLower) ||
            romaji.contains(searchLower) ||
            bahasa.contains(searchLower);
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundWord.value = results;
  }

  // Procedure for change the dictionary word type
  dictionaryChangeWordType(wordType, wordList) {
    if (wordType.value.toString() == 'Kata Kerja') {
      wordList.value = foundWord.value = json.decode(verb)["N5"] + json.decode(verb)["N4"];
    }
    if (wordType.value.toString() == 'Kata Sifat') {
      wordList.value = foundWord.value =
          json.decode(adjective)["N5"] + json.decode(adjective)["N4"];
    }
    if (wordType.value.toString() == 'Kata Benda') {
      wordList.value = foundWord.value = json.decode(noun)["N5"] + json.decode(noun)["N4"];
    }
  }

  clearSearch() {
    txtQuery.text = '';
    searchFIlter(txtQuery.value.text);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// DICTIONARY CONTROLLER

//////////////////////////////////////////////////////////////////////////////////////////////////// SETTING CONTROLLER
class SettingPageController extends GetxController {
  var aboutApp = "Aplikasi ini tidak menyediakan sertifikat apapun tentang bahasa Jepang, seperti JPLT atau semancamnya.\nAplikasi ini dibuat bertujuan agar pengguna bisa belajar dan menghafal kosakata-kosakata bahasa Jepang. Aplikasi ini juga bertujuan agar pengguna dapat menghafal setiap kanji, cara pengucapan dan arti dari kata tersebut dalam bahasa Indonesia. Aplikasi ini dibuat berdasarkan kosakata JPLT. Tetapi tidak menjamin kalau penerjemahan dan pelafalan kosakatanya tepat 100%. Jika ada kesalahan kanji, translasi, atau ada saran bisa hub email developer atau lewat review google playstore. Terima kasih telah mengunduh aplikasi ini.".obs;
  var rateLink = 'https://play.google.com/store/apps/details?id=com.japanesequiz.user0412&hl=en&gl=US'.obs;
  var websiteVersion = 'https://kuis-kosakata-bahasa-jepang.web.app/'.obs;

  // ADS
  var settingBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var settingBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var settingAdsController = NativeAdmobController();
}
//////////////////////////////////////////////////////////////////////////////////////////////////// SETTING CONTROLLER
