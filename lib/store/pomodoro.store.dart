import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

final player = AudioCache();

enum TipoIntervalo { ESTUDO, DESCANSO }

abstract class _PomodoroStore with Store {
  @observable
  int contaPomodoro = 0;

  @observable
  bool iniciado = false;

  @observable
  int minutos = 25;

  @observable
  int segundos = 0;

  @observable
  int tempoEstudo = 25;

  @observable
  int tempoDescanso = 5;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.ESTUDO;

  Timer? cronometro;

  void comecarTempoDescanso() {
    tipoIntervalo = TipoIntervalo.DESCANSO;
  }

  @action
  void contadorPomodoro() {
    if (tempoEstudo == 0) {
      contaPomodoro++;
    }
  }

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaEstudando() ? tempoEstudo : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempoEstudo() {
    tempoEstudo++;
    if (estaEstudando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoEstudo() {
    if (tempoEstudo > 1) {
      tempoEstudo--;
      if (estaEstudando()) {
        reiniciar();
      }
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estaDescanso()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    if (tempoDescanso > 1) {
      tempoDescanso--;
      if (estaDescanso()) {
        reiniciar();
      }
    }
  }

  bool estaEstudando() {
    return tipoIntervalo == TipoIntervalo.ESTUDO;
  }

  bool estaDescanso() {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void tocar() {
    if (minutos == 0 && segundos == 0) {
      player.play('not.wav');
    }
  }

  void _trocarTipoIntervalo() {
    if (estaEstudando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.ESTUDO;
      minutos = tempoEstudo;
    }
    segundos = 0;
  }
}
