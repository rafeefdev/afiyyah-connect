import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stepcontroller_provider.g.dart';

@riverpod
class StepcontrollerProvider extends _$StepcontrollerProvider {
  @override
  int build() => 0;

  //TODO : implement real use case for the stepcontroller (Supabase, etc)
  void next() => state++;
  void previous() => state--;
  void toStep(int step) => state = step;
}
