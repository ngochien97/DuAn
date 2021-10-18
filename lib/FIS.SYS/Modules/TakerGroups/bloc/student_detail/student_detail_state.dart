abstract class StudentDetailState {
  final int index;
  final int tabIndex;
  StudentDetailState({this.index, this.tabIndex});
}

class ScrollState extends StudentDetailState {
  ScrollState(int index, int tabIndex)
      : super(index: index, tabIndex: tabIndex);
}

class ScrollParentState extends StudentDetailState {
  ScrollParentState(int index, int tabIndex)
      : super(index: index, tabIndex: tabIndex);
}
