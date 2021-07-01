import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {

  NavigationCubit() : super(NavigationInitial());
  setNavigation(int index){
    emit(NavigationNavigate(navigationIndex: index));
  }

  void fetch() {

  }
}
