import 'package:checks/context.dart';

// LABEL: eligible-hrk_test_batteries
extension CustomChecks<T> on Subject<T> {
  /// Expects that the value is not equal to [other] according to [operator !=].
  void notEquals(T other) {
    context.expect(() => prefixFirst('not equals ', literal(other)), (actual) {
      if (actual != other) return null;
      return Rejection(which: ['are equal']);
    });
  }
}
