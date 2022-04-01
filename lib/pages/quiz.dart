import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';

// Import Classes
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  // final a =  json.decode(verb)["N5"];

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.put(QuizPageController());
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: const <Widget>[
              QuizScore(),
              SizedBox(height: 8),
              QuizAd1(),
              SizedBox(height: 8),
              QuizQuestion(),
              SizedBox(height: 8),
              QuizAnswer(),
              SizedBox(height: 8),
              QuizAd2(),
              SizedBox(height: 8),
              QuizDropdownMenu(),
              SizedBox(height: 8),
              QuizSwitch(),
              SizedBox(height: 8),
            ],
          )),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) => const QuizHint()),
        label: const Text('BERI PETUNJUK'),
        icon: const Icon(Icons.help),
      ),
    );
  }
}

class QuizScore extends StatelessWidget {
  const QuizScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container for false score
          Card(
            elevation: 4,
            shadowColor: Colors.redAccent,
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFCB2D3E), Color(0xFFEF473A)],
                  ),
                ),
                child: Obx(() => Text(
                      "SALAH: ${quizPageController.falseScore}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          color: Colors.white),
                    ))),
          ),

          // For false or true text
          Obx(() => Text(
                quizPageController.falseOrTrue.value,
                style:
                    TextStyle(color: quizPageController.falseOrTrueColor.value),
              )),

          // Container for false score
          Card(
            elevation: 4,
            shadowColor: Colors.greenAccent,
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFA8E063), Color(0xFF56AB2F)],
                  ),
                ),
                child: Obx(() => Text(
                      "BENAR: ${quizPageController.trueScore}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          color: Colors.white),
                    ))),
          ),
        ]);
  }
}

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.put(QuizPageController());
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          // Kanji question
          Obx(() => Visibility(
                visible: quizPageController.kanjiVisibility.value,
                child: Obx(() => Text(
                      quizPageController
                              .quizWordList[quizPageController.rand.value]
                          ["KanjiCasualPositive"],
                      style: const TextStyle(
                        fontSize: 64,
                      ),
                    )),
              )),

          // Romaji question
          Obx(() => Visibility(
                visible: quizPageController.romajiVisibility.value,
                child: Obx(() => Text(
                      quizPageController
                              .quizWordList[quizPageController.rand.value]
                          ["RomajiCasualPositive"],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    )),
              )),

          // Bahasa question
          Obx(() => Visibility(
                visible: quizPageController.bahasaVisibility.value,
                child: Obx(() => Text(
                      quizPageController
                              .quizWordList[quizPageController.rand.value]
                          ["BahasaCasualPositive"],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    )),
              )),
        ]),
      ),
    );
  }
}

class QuizSwitch extends StatelessWidget {
  const QuizSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Text("Sembunyikan Ejaan"),
            Obx(() => Switch(
                value: quizPageController.answerTypeValue == "Romaji"
                    ? quizPageController.bahasaVisibility.value
                    : quizPageController.answerTypeValue == "Kanji"
                        ? quizPageController.romajiVisibility.value
                        : quizPageController.romajiVisibility.value,
                onChanged: (value) => quizPageController.answerTypeValue ==
                        "Romaji"
                    ? quizPageController.bahasaVisibility.value = value
                    : quizPageController.answerTypeValue == "Kanji"
                        ? quizPageController.romajiVisibility.value = value
                        : quizPageController.romajiVisibility.value = value)),
          ],
        ));
  }
}

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(() => TextField(
                controller: quizPageController.submitTextfield,
                onEditingComplete: () => quizPageController.checkAnswer(quizPageController.answerTypeValue.value),
                decoration: InputDecoration(
                  hintText: "jawab dengan ${quizPageController.answerTypeValue.value}",
                ),
              ))
            )
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            // Set onPressed to get rand number
            onPressed: () => quizPageController.checkAnswer(quizPageController.answerTypeValue.value),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'CHECK',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Josefin Sans'
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  // Parameter
  String altValue;
  final List<String> altItem;
  final ValueChanged altOnChange;

  // Initialize
  Dropdown(
      {Key? key,
      required this.altItem,
      required this.altValue,
      required this.altOnChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: altValue,
            isExpanded: true,
            onChanged: (String? newValue) {
              altOnChange(newValue);
            },
            items: altItem.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class QuizDropdownMenu extends StatelessWidget {
  const QuizDropdownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.put(QuizPageController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Pengaturan kuis",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            // Level
            Expanded(
                child: Obx(() => Dropdown(
                    altItem: quizPageController.levelTypeItem,
                    altValue: quizPageController.levelTypeValue.value,
                    altOnChange: (value) {
                      quizPageController.levelTypeValue.value = value;
                      quizPageController.changeWordType(
                          quizPageController.wordTypeValue.value,
                          quizPageController.levelTypeValue.value);
                    }))),
            // Word Type
            Expanded(
                child: Obx(() => Dropdown(
                    altItem: quizPageController.wordTypeItem,
                    altValue: quizPageController.wordTypeValue.value,
                    altOnChange: (value) {
                      quizPageController.wordTypeValue.value = value;
                      quizPageController.changeWordType(
                          quizPageController.wordTypeValue.value,
                          quizPageController.levelTypeValue.value);
                    })))
          ],
        ),
        // Answer type
        Obx(() => Dropdown(
            altItem: quizPageController.answerTypeItem,
            altValue: quizPageController.answerTypeValue.value,
            altOnChange: (value) {
              quizPageController.answerTypeValue.value = value;
              quizPageController
                  .wordVisibility(quizPageController.answerTypeValue.value);
            }))
      ],
    );
  }
}

class QuizHint extends StatelessWidget {
  const QuizHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                // Content inside the bottom sheet
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Obx(() => Text(
                          "${quizPageController.quizWordList[quizPageController.rand.value]["KanjiCasualPositive"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiCasualPositive"]}): ${quizPageController.quizWordList[quizPageController.rand.value]["BahasaCasualPositive"]}",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Konjugasi Umum:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "JPLT Level: ${quizPageController.quizWordList[quizPageController.rand.value]["Level"]}")),
                Obx(() => Text(
                    "Jenis ${quizPageController.wordTypeValue}: ${quizPageController.quizWordList[quizPageController.rand.value]["WordType"]}")),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "Kasual Negatif: ${quizPageController.quizWordList[quizPageController.rand.value]["KanjiCasualNegative"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiCasualNegative"]})")),
                Obx(() => Text(
                    "Kasual Lampau: ${quizPageController.quizWordList[quizPageController.rand.value]["KanjiCasualPast"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiCasualPast"]})")),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "Sopan Posistif: ${quizPageController.quizWordList[quizPageController.rand.value]["KanjiPolitePositive"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiPolitePositive"]})")),
                Obx(() => Text(
                    "Sopan Negatif: ${quizPageController.quizWordList[quizPageController.rand.value]["KanjiPoliteNegative"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiPoliteNegative"]})")),
                Obx(() => Text(
                    "Sopan Lampau: ${quizPageController.quizWordList[quizPageController.rand.value]["KanjiPolitePast"]} (${quizPageController.quizWordList[quizPageController.rand.value]["RomajiPolitePast"]})")),
              ],
            ),
          ),
          // Close button
          ElevatedButton(
            child: const Text("Tutup Petunjuk"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}

class QuizAd1 extends StatelessWidget {
  const QuizAd1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: quizPageController.quizBanner1.value,
        controller: quizPageController.quizAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}

class QuizAd2 extends StatelessWidget {
  const QuizAd2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizPageController quizPageController = Get.find();
    return Container(
      height: 80,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => NativeAdmob(
        error: const Text("Iklan tidak tersedia"),
        adUnitID: quizPageController.quizBanner2.value,
        controller: quizPageController.quizAdsController,
        type: NativeAdmobType.banner,
      ))
    );
  }
}
