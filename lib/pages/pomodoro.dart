import 'package:flutter/material.dart';
import 'package:pomodoro/components/Botoes.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:pomodoro/store/contador.store.dart';
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
                      Row(
                        children: [
                          EntradaTempo(
                              valor: store.tempoEstudo, titulo: 'Estudo'),
                          EntradaTempo(
                              valor: store.tempoDescanso, titulo: 'Descanso'),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Contador',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '5',
                              style: TextStyle(fontSize: 60),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Botoes(
                              texto: 'Iniciar',
                              icone: Icons.play_arrow,
                            ),
                          ),
                          //Padding(
                          //padding: const EdgeInsets.all(10),
                          //child: Botoes(
                          //texto: 'Parar',
                          //icone: Icons.stop,
                          //),
                          //),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Botoes(
                              texto: 'Reiniciar',
                              icone: Icons.refresh,
                            ),
                          ),
                        ],
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
