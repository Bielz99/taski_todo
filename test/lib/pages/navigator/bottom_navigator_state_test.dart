import 'package:flutter_test/flutter_test.dart';

class BottomNavigatorState {
  final int selectedIndex;
  BottomNavigatorState({required this.selectedIndex});
}

void main() {
  test('BottomNavigatorState should correctly store selectedIndex', () {
    final bottomNavigatorState = BottomNavigatorState(selectedIndex: 2);

    expect(bottomNavigatorState.selectedIndex, 2);
  });

  test(
      'BottomNavigatorState should correctly store selectedIndex with another value',
      () {
    final bottomNavigatorState = BottomNavigatorState(selectedIndex: 5);

    expect(bottomNavigatorState.selectedIndex, 5);
  });
}
