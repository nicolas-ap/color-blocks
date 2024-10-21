import 'dart:async';
import 'dart:math';
import 'package:color_blocks/const/cores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class GameController extends GetxController {
  RxInt nivel = 1.obs;
  bool pronto = false;
  RxInt record = 1.obs;
  List<int> resposta = List<int>.empty(growable: true);
  List<int> tentativaDoUsuario = List<int>.empty(growable: true);
  Rx<Color> corSucesso = Color.fromARGB(255, 156, 255, 174).obs;
  Rx<Color> corAcerto = Colors.blue.obs;
  RxList<int> randomNumbers = List.generate(9, (i) => i).obs;
  RxString colorBlocks = "".obs;
  List<String> controleDoPronto = ["Color::Blocks ✋","Color::Blocks 😎","Color::Blocks 👍","Color::Blocks 👎","Color::Blocks 🤩"];

  static AudioPlayer player = AudioPlayer();
  static const tapSounds = ['sounds/tap4.wav', 'tap2.mp3', 'tap3.mp3'];

  

  @override
  void onInit() async {
    super.onInit();
    shuffleNumber();
    colorBlocks.value = controleDoPronto[0];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    record.value = prefs.getInt('record') ?? record.value;
    iniciarSequencia();
  }

  void shuffleNumber() {
    randomNumbers.shuffle();
  }

  void iniciarSequencia() {
    Future.delayed(const Duration(milliseconds: 500),
        () => apareceNovaSequencia(nivel.value));
  }

  // Gera um número aleatório entre 0 e 10
  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(9);
  }

  void apareceNovaSequencia(int nivel) async {
    await Future.delayed(const Duration(milliseconds: 500));
    corSucesso.value = Color.fromARGB(255, 156, 255, 174);
    pronto = false;
    int i = generateRandomNumber();
    resposta.add(i);
    int n = 0;
    colorBlocks.value = controleDoPronto[0];
    while (n < nivel) {
      acendeRetangulo(resposta[n]);
      await Future.delayed(const Duration(milliseconds: 150));
      apagaRetangulo(resposta[n]);
      await Future.delayed(const Duration(milliseconds: 150));
      n++;
    }
    pronto = true;
    colorBlocks.value = controleDoPronto[2];
    //print("Resposta: $resposta");
  }

  void verificaRespostaDoUsuario() async {
    for (int i = 0; i < resposta.length; i++) {
      if (tentativaDoUsuario[i] != resposta[i]) {
        pronto = false;
        colorBlocks.value = controleDoPronto[3];
        corSucesso.value = Color.fromARGB(255, 255, 116, 116);
        await Future.delayed(const Duration(milliseconds: 300));
        corAcerto = Colors.blue.obs;
        tentativaDoUsuario.clear();
        resposta.clear();
        nivel.value = 1;
        shuffleNumber();
        return apareceNovaSequencia(nivel.value);
      }
    }
    tentativaDoUsuario.clear();
    nivel.value++;
    verificaRecord(nivel.value);
    await Future.delayed(const Duration(milliseconds: 300));
    pronto = false;
    apareceNovaSequencia(nivel.value);
  }

  void verificaRecord(nivel) async {
    if (record.value < nivel) {
      record.value = nivel;
      colorBlocks.value = controleDoPronto[4];
      corAcerto = Color.fromARGB(255, 255, 252, 156).obs;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('record', record.value);
    }else{
      colorBlocks.value = controleDoPronto[1];
    }
  }

  //Clareia as cores
  void acendeRetangulo(int i) {
    player.play(AssetSource(tapSounds[0]));
    cores[i] = HSLColor.fromAHSL(
      1,
      cores[i].hue,
      cores[i].saturation,
      0.5,
    );
  }

  //Escurece as cores
  void apagaRetangulo(int i) {
    cores[i] = HSLColor.fromAHSL(
      1,
      cores[i].hue,
      cores[i].saturation,
      0.2,
    );
  }
}
