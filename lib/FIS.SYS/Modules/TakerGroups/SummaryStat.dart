class SummaryStat {
  int totalTodo;
  int totalDoing;
  int totalWaitForMark;
  int totalDone;

  SummaryStat(
      {this.totalTodo, this.totalDoing, this.totalDone, this.totalWaitForMark});

  factory SummaryStat.fromJson(Map<String, dynamic> json) => SummaryStat(
        totalTodo: json['total_todo'],
        totalDoing: json['total_doing'],
        totalWaitForMark: json['total_wait_for_mark'],
        totalDone: json['total_done'],
      );
}
