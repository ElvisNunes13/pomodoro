import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/Botoes.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  Pomodoro({super.key});
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(13, 181, 81, 1),
              Color.fromRGBO(59, 255, 67, 1)
            ], begin: FractionalOffset(0.5, 1)),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18),
              ),
              Expanded(
                child: Center(
                  child: Cronometro(),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(children: [
                      Observer(
                        builder: (_) => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            EntradaTempo(
                              titulo: 'Estudo',
                              valor: store.tempoEstudo,
                              inc: store.iniciado && store.estaEstudando()
                                  ? null
                                  : store.incrementarTempoEstudo,
                              dec: store.iniciado && store.estaEstudando()
                                  ? null
                                  : store.decrementarTempoEstudo,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            EntradaTempo(
                              valor: store.tempoDescanso,
                              titulo: 'Descanso',
                              inc: store.iniciado && store.estaDescanso()
                                  ? null
                                  : store.incrementarTempoDescanso,
                              dec: store.iniciado && store.estaDescanso()
                                  ? null
                                  : store.decrementarTempoDescanso,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Observer(
                        builder: (_) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!store.iniciado)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Botoes(
                                  texto: 'Iniciar',
                                  icone: Icons.play_arrow,
                                  click: store.iniciar,
                                ),
                              ),
                            if (store.iniciado)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Botoes(
                                  texto: 'Parar',
                                  icone: Icons.stop,
                                  click: store.parar,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Botoes(
                                texto: 'Reiniciar',
                                icone: Icons.refresh,
                                click: store.reiniciar,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20)
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
