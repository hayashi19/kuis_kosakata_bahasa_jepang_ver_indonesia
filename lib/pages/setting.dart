import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Import Classes
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.put(SettingPageController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: const <Widget>[
            SettingRateApp(),
            SizedBox(height: 8),
            SettingAd1(),
            SizedBox(height: 8),
            SettingExtraContent(),
            SizedBox(height: 8),
            SettingAd2(),
            SizedBox(height: 8),
            SettingWebsiteVersion(),
            SizedBox(height: 8),
            SettingEmail()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ThemeService().switchTheme(),//Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark), 
        label: const Text("WARNA TEMA"),
      ),
    );
  }
}

class SettingRateApp extends StatelessWidget {
  const SettingRateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.find(); 
    return ElevatedButton(
      onPressed: () => launch(settingPageController.rateLink.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 55,
                  width: 55,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Kuis Kosakata Bahasa Jepang",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )
                )
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Beri Rate ★★★★★",
              style: TextStyle(
                color: Colors.yellowAccent, 
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingExtraContent extends StatelessWidget {
  const SettingExtraContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.find(); 
    return Column(
      children: <Widget>[
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: ExpandablePanel(
              header: Row(
                children: const <Widget>[
                  Icon(Icons.ad_units),
                  Spacer(),
                  Text(
                    "Tentang Aplikasi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              collapsed: Obx(() => Text(
                settingPageController.aboutApp.string,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis
              )),
              expanded: Obx(() => Text(
                settingPageController.aboutApp.string,
                softWrap: true,
                textAlign: TextAlign.justify,
              )),
            ),
          )
        ),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: ExpandablePanel(
              header: Row(
                children: const <Widget>[
                  Icon(Icons.ballot_rounded),
                  Spacer(),
                  Text(
                    "Bantuan Aplikasi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              collapsed: const Text(
                "Bantuan aplikasi, tips and trik menggunakannya.",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis
              ),
              expanded: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutAppHelp()
                      )
                    ),
                    icon: const Icon(Icons.ballot_outlined),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Bantuan penggunaan")
                      )
                    ),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutAppTrick()
                      )
                    ),
                    icon: const Icon(Icons.ballot_outlined),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Tips Penggunaan")
                    )
                  ),
                ],
              )
            ),
          ),
        )
      ],
    );
  }
}

class SettingWebsiteVersion extends StatelessWidget {
  const SettingWebsiteVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.find();
    return ElevatedButton.icon(
      onPressed: () => launch(settingPageController.websiteVersion.string),
      icon: const Icon(Icons.web),
      label: const Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Kuis Versi Website",
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ),
      ),
    );
  }
}

class SettingEmail extends StatelessWidget {
  const SettingEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async => await FlutterEmailSender.send(
        Email(
          subject: 'Laporan Kesalahan Dan Saran Apk Kuis Kosakata Bahasa Jepang',
          recipients: ['tryniti0412@gmail.com'],
          isHTML: false,
        )
      ),
      icon: const Icon(Icons.email_rounded),
      label: const Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email Report",
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ),
      ),
    );
  }
}

class AboutAppHelp extends StatelessWidget {
  const AboutAppHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bantuan Aplikasi"),
        ),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            // Image.asset('assets/logo.png'),
            Image.asset('assets/help/Quiz Question and Score.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Quiz Answer.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Quiz Setting.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Quiz Hint.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Dictionary Search.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Dictionary Word List.png'),
            const SizedBox(width: 8),
            Image.asset('assets/help/Setting.png'),
          ],
        ));
  }
}

class AboutAppTrick extends StatelessWidget {
  const AboutAppTrick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bantuan Aplikasi"),
        ),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            // Image.asset('assets/logo.png'),
            Image.asset('assets/tips/Tips 1.png'),
            const SizedBox(width: 8),
            Image.asset('assets/tips/Tips 2.png'),
          ],
        ));
  }
}

class SettingAd1 extends StatelessWidget {
  const SettingAd1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.find(); 
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: settingPageController.settingBanner1.value,
        controller: settingPageController.settingAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}

class SettingAd2 extends StatelessWidget {
  const SettingAd2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingPageController settingPageController = Get.find(); 
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: settingPageController.settingBanner2.value,
        controller: settingPageController.settingAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}