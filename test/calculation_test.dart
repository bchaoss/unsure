import 'package:test/test.dart';
import 'package:unsure/unsure.dart';

void main() {
  test('works for simple input', () {
    var parser = FormulaParser();
    var formula = parser.parseString('1000 + 2~4');
    var calculation = Calculation(formula.emit);

    expect(() => calculation.run(), returnsNormally);
  });

  test('doesn\'t break when all output is not a number', () {
    var parser = FormulaParser();
    var formula = parser.parseString('100~101 / 0');
    var calculation = Calculation(formula.emit);

    late Result result;
    expect(() => result = calculation.run(), returnsNormally);
    expect(result.isInvalid, isTrue);
  });

  test('handles identical zero results', () {
    var parser = FormulaParser();
    var formula = parser.parseString('0 * 2~3');
    var calculation = Calculation(formula.emit, iterations: 1000);

    var result = calculation.run();
    var histogram = result.histogram!;

    expect(histogram.lowerBound, 0);
    expect(histogram.counts[histogram.bandCount ~/ 2], 1000);
    expect(() => histogram.toString(), returnsNormally);
  });
}
