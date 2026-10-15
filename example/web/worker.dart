import 'dart:html';

import 'package:unsure_web/unsure_calculator.dart';

void main() {
  final scope = DedicatedWorkerGlobalScope.instance;
  final calculator = UnsureCalculator();

  scope.onMessage.listen((event) {
    final formula = event.data as String;
    final result = calculator.calculate(formula);
    scope.postMessage(result.toData());
  });
}
