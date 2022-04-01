// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Inport classes
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/dictionary.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/quiz.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/setting.dart';
import 'package:url_launcher/url_launcher.dart';

// class for desktop web 
class WebDesktopHome extends StatelessWidget {
  const WebDesktopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    final QuizPageController quizPageController = Get.put(QuizPageController());
    final SettingPageController settingPageController = Get.put(SettingPageController());
    final DictionaryPageController dictionaryPageController = Get.put(DictionaryPageController());
    return MediaQuery.of(context).size.width <= 720 ? 
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            const QuizScore(),
            const SizedBox(height: 8),
            const QuizQuestion(),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) => const QuizHint()
              ),
              child: const Text('BERI PETUNJUK'),
            ),
            const SizedBox(height: 8),
            const QuizAnswer(),
            const SizedBox(height: 8),
            const QuizDropdownMenu(),
            const SizedBox(height: 8),
            SizedBox(
              height: 640,
              child: Column(
                children: const <Widget>[
                  SearchView(),
                  SizedBox(height: 8),
                  Expanded(child: DictionaryListView()),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const SettingExtraContent(),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => launch("https://play.google.com/store/apps/details?id=com.japanesequiz.user0412"),
              icon: const Icon(Icons.phone_android),
              label: const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kuis Versi Mobile",
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SettingEmail()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ThemeService().switchTheme(),//Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark), 
        label: const Text("WARNA TEMA"),
      ),
    ) :
    Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView(
                  children: <Widget>[
                    const QuizScore(),
                    const SizedBox(height: 8),
                    const QuizQuestion(),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) => const QuizHint()
                      ),
                      child: const Text('BERI PETUNJUK'),
                    ),
                    const SizedBox(height: 8),
                    const QuizAnswer(),
                    const SizedBox(height: 8),
                    const QuizDropdownMenu(),
                    const SizedBox(height: 8),
                    const SettingExtraContent(),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => launch("https://play.google.com/store/apps/details?id=com.japanesequiz.user0412"),
                      icon: const Icon(Icons.phone_android),
                      label: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Kuis Versi Mobile",
                            style: TextStyle(
                              fontSize: 24
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SettingEmail()
                  ],
                )
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => ThemeService().switchTheme(),//Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark), 
                label: const Text("WARNA TEMA"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: const <Widget>[
                  SearchView(),
                  SizedBox(height: 8),
                  Expanded(child: DictionaryListView()),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}

// class for mobile android
class MobileHome extends StatelessWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => homePageController.changeIndex(index),
        controller: homePageController.pageViewController,
        children: const <Widget>[
          QuizPage(),
          DictionaryPage(),
          SettingPage(),
        ],
      ),

      // Bot nav bar contain icon of pages
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: homePageController.currentIndex.value,
        onTap: (index) => homePageController.pageViewController.animateToPage(index,
          duration: const Duration(milliseconds: 450),
          curve: Curves.fastLinearToSlowEaseIn
        ),
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem( // Ic kuis
            icon: Icon(Icons.quiz_rounded), 
            label: "Kuis"
          ),
          BottomNavigationBarItem( // Ic kamus
            icon: Icon(Icons.library_books_rounded), 
            label: "Kamus"
          ),
          BottomNavigationBarItem( // Ic setting
            icon: Icon(Icons.app_settings_alt_rounded),
            label: "Pengaturan"
          ),
        ]),
      ),
    );
  }
}