part of 'navigation_cubit.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {
  int navigationIndex = 0;
}
class NavigationNavigate extends NavigationState{
  int navigationIndex;
  NavigationNavigate({required this.navigationIndex});
}