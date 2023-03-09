import 'package:mobx/mobx.dart';
part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

abstract class _PomodoroStore with Store {
  @observable
  int tempoEstudo = 1;

  @observable
  int tempoDescanso = 1;

  @action
  void incrementarTempoEstudo() {
    tempoEstudo++;
  }

  @action
  void decrementarTempoEstudo() {
    tempoEstudo--;
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
  }

  @action
  void decrementarTempoDescanso() {
    tempoDescanso--;
  }
}
