abstract class StudentDetailEvent {
  const StudentDetailEvent();
}

class ScrollChangeEvent extends StudentDetailEvent {
  final int index;
  final int tabIndex;

  ScrollChangeEvent(this.index, this.tabIndex);
}

class ParentScrollChangeEvent extends StudentDetailEvent {
  final int index;
  final int tabIndex;

  ParentScrollChangeEvent(this.index, this.tabIndex);
}
