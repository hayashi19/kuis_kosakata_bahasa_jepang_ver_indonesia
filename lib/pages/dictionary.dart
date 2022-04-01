// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:get/get.dart';

// Import classes
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.put(DictionaryPageController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const <Widget>[
            SizedBox(height: 24),
            SearchView(),
            SizedBox(height: 8),
            DictionaryAd1(),
            SizedBox(height: 8),
            Expanded(child: DictionaryListView()),
            SizedBox(height: 8),
            DictionaryAd2()
          ],
        )
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return TextField(
          controller: dictionaryPageController.txtQuery,
          onChanged: dictionaryPageController.searchFIlter,
          decoration: const InputDecoration(
            hintText: "Cari kata kanji romaji bahasa",
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
              prefixIcon: Icon(Icons.search),
          )
        );
  }
}

class DictionaryListView extends StatelessWidget {
  const DictionaryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return Obx(() => ListView.builder(
      itemCount: dictionaryPageController.foundWord.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListPage(
                altList: dictionaryPageController.foundWord,
                altIndex: index
              )
            )
          ),
          child: ListBody(
            children: [
              // Set the list background
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      // Word for show the word type
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() => Text(
                              "Level: ${dictionaryPageController.foundWord[index]["Level"]}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10)
                            )),
                          ),
                          Expanded(
                            child: Obx(() => Text(
                              "Tipe Kata: ${dictionaryPageController.foundWord[index]["WordType"]}",
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10),
                            )),
                          ),
                        ]
                      ),
                      const SizedBox(height: 8),
                      // List of column for the words
                      Obx(() => Text(
                        dictionaryPageController.foundWord[index]["KanjiCasualPositive"].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                        )
                      )),
                      const SizedBox(height: 8),
                      // Text for romaji
                      Obx(() => Text(
                        dictionaryPageController.foundWord[index]["RomajiCasualPositive"].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        )
                      )),
                      const SizedBox(height: 8),
                      // Text for bahasa
                      Obx(() => Text(
                        dictionaryPageController.foundWord[index]["BahasaCasualPositive"].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        )
                      ))
                    ]
                  ),
                ),
              )
            ],
          )
        );
      },
    ));
  }
}

// Extra page
class ListPage extends StatelessWidget {
  final List altList;
  final int altIndex;

  const ListPage({Key? key, required this.altList, required this.altIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Halam Penjelasan ${altList[altIndex]["KanjiCasualPositive"]}(${altList[altIndex]["RomajiCasualPositive"]})")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // For level and word type
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Level: " + altList[altIndex]["Level"],
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Tipe Kata: " + altList[altIndex]["WordType"],
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ]
              ),

              const SizedBox(height: 8),

              // For main dictionary form
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.black, width: 4),
                      top: BorderSide(color: Colors.black, width: 4),
                      right: BorderSide(color: Colors.grey, width: 3),
                      bottom: BorderSide(color: Colors.grey, width: 3),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Text(
                        altList[altIndex]["KanjiCasualPositive"],
                        style: const TextStyle(
                          fontSize: 48,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        altList[altIndex]["RomajiCasualPositive"],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        altList[altIndex]["BahasaCasualPositive"],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]
                  )
                )
              ),
            ),
            const SizedBox(height: 28),
            const DictionaryAdExtra(),
            const SizedBox(height: 28),
            // Casual form
            const Text(
              "Konjugasi Kasual (Sehari - hari)",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            Text("Negatif: ${altList[altIndex]["KanjiCasualNegative"]}(${altList[altIndex]["RomajiCasualNegative"]})"),
            const SizedBox(height: 8),
            Text("Lampau: ${altList[altIndex]["KanjiCasualPast"]}(${altList[altIndex]["RomajiCasualPast"]})"),
            const SizedBox(height: 8),
            Text("Negatif Lampau: ${altList[altIndex]["KanjiCasualPastNegative"]}(${altList[altIndex]["RomajiCasualPastNegative"]})"),
            const SizedBox(height: 28),
            // Polite form
            const Text(
              "Konjugasi Sopan",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            Text("Positif: ${altList[altIndex]["KanjiPolitePositive"]}(${altList[altIndex]["RomajiPolitePositive"]})"),
            const SizedBox(height: 8),
            Text("Negatif: ${altList[altIndex]["KanjiPoliteNegative"]}(${altList[altIndex]["RomajiPoliteNegative"]})"),
            const SizedBox(height: 8),
            Text("Lampau: ${altList[altIndex]["KanjiPolitePast"]}(${altList[altIndex]["RomajiPolitePast"]})"),
            const SizedBox(height: 8),
            Text("Negatif Lampau: ${altList[altIndex]["KanjiPolitePastNegative"]}(${altList[altIndex]["RomajiPolitePastNegative"]})"),
          ],
        ),
      ),
    );
  }
}

class DictionaryAd1 extends StatelessWidget {
  const DictionaryAd1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: dictionaryPageController.dictionaryBanner1.value,
        controller: dictionaryPageController.dictoinaryAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}

class DictionaryAd2 extends StatelessWidget {
  const DictionaryAd2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: dictionaryPageController.dictionaryBanner2.value,
        controller: dictionaryPageController.dictoinaryAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}

class DictionaryAdExtra extends StatelessWidget {
  const DictionaryAdExtra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DictionaryPageController dictionaryPageController = Get.find();
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: dictionaryPageController.dictionaryBannerExtra.value,
        controller: dictionaryPageController.dictoinaryAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}