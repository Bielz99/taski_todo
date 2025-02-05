import 'package:flutter_test/flutter_test.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_cubit.dart'; // Certifique-se de importar corretamente a classe BottomNavigatorCubit

void main() {
  group('BottomNavigatorCubit', () {
    late BottomNavigatorCubit bottomNavigatorCubit;

    setUp(() {
      bottomNavigatorCubit = BottomNavigatorCubit();
    });

    tearDown(() {
      bottomNavigatorCubit.close();
    });

    test('deve ter o estado inicial com selectedIndex igual a 0', () {
      expect(bottomNavigatorCubit.state.selectedIndex, 0);
    });

    test('deve atualizar selectedIndex ao chamar setSelectedIndex', () {
      bottomNavigatorCubit.setSelectedIndex(3);

      expect(bottomNavigatorCubit.state.selectedIndex, 3);
    });

    test('deve atualizar selectedIndex para outro valor', () {
      bottomNavigatorCubit.setSelectedIndex(7);
      expect(bottomNavigatorCubit.state.selectedIndex, 7);
    });
  });
}
