import 'dart:async';
import 'package:color_blocks/const/cores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/game_controller.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCont = Get.put(GameController());
    double vh = MediaQuery.of(context).size.height * 0.01;
    double vmax = MediaQuery.of(context).size.longestSide * 0.01;
    double vw = MediaQuery.of(context).size.width * 0.01;

    Widget criaRetangulos(int i) {
      double vh = MediaQuery.of(context).size.height * 0.01;
      double vw = MediaQuery.of(context).size.width * 0.01;

      return GestureDetector(
        onTap: () {
          if (gameCont.pronto == false) {
            return;
          }

          gameCont.acendeRetangulo(i);
          gameCont.tentativaDoUsuario.add(i);
          Timer(const Duration(milliseconds: 300),
              () => gameCont.apagaRetangulo(i));
          if (gameCont.resposta.length == gameCont.tentativaDoUsuario.length) {
            gameCont.pronto = false;
            return gameCont.verificaRespostaDoUsuario();
          }
          gameCont.verificaRespostaDoUsuario();
        },
        child: Obx(
          () => Container(
            height: vh * 20,
            width: vw * 32.5,
            margin: const EdgeInsets.all(1),
            color: cores[i].toColor(),
          ),
        ),
      );
    }

    return Scaffold(
      //CORPO DO APLICATIVO:
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: vh * 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(gameCont.colorBlocks.value,
                        style:
                            TextStyle(fontSize: vmax * 5.0, color: Colors.white)),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Lvl.: ${gameCont.nivel.value}',
                          style: TextStyle(
                              color: gameCont.corSucesso.value,
                              fontSize: vmax * 5),
                        ),
                        Text(
                          'Max.: ${gameCont.record.value}',
                          style:
                              TextStyle(color: gameCont.corAcerto.value, fontSize: vmax * 5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: vw * 100,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                  for(int i = 0; i<9; i+=3) Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        criaRetangulos(gameCont.randomNumbers[i]),
                        criaRetangulos(gameCont.randomNumbers[i+1]),
                        criaRetangulos(gameCont.randomNumbers[i+2]),
                      ],
                    ),
                  ),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       criaRetangulos(gameCont.randomNumbers[0]),
                  //       criaRetangulos(gameCont.randomNumbers[1]),
                  //       criaRetangulos(gameCont.randomNumbers[2]),
                  //     ],
                  //   ),
                  // ),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       criaRetangulos(gameCont.randomNumbers[3]),
                  //       criaRetangulos(gameCont.randomNumbers[4]),
                  //       criaRetangulos(gameCont.randomNumbers[5]),
                  //     ],
                  //   ),
                  // ),
                  // Obx(
                  //   () => Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       criaRetangulos(gameCont.randomNumbers[6]),
                  //       criaRetangulos(gameCont.randomNumbers[7]),
                  //       criaRetangulos(gameCont.randomNumbers[8]),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
