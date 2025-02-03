import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorState> {
  BottomNavigatorCubit() : super(BottomNavigatorState(selectedIndex: 0));

  setSelectedIndex(int index) =>
      emit(BottomNavigatorState(selectedIndex: index));
}
