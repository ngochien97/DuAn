class TestOutlineItem {
  TestOutlineItem({
    this.count,
    this.page,
    this.pageSize,
    this.totalCount,
    this.testOutlines,
  });

  int count;
  int page;
  int pageSize;
  int totalCount;
  List<TestOutline> testOutlines;

  factory TestOutlineItem.fromJson(Map<String, dynamic> json) =>
      TestOutlineItem(
        count: json['count'],
        page: json['page'],
        pageSize: json['page_size'],
        totalCount: json['total_count'],
        testOutlines: List<TestOutline>.from(
            json['test_outlines'].map((x) => TestOutline.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'page': page,
        'page_size': pageSize,
        'total_count': totalCount,
        'test_outlines':
            List<dynamic>.from(testOutlines.map((x) => x.toJson())),
      };
}

class TestOutline {
  TestOutline({
    this.name,
    this.id,
  });

  String name;
  int id;

  factory TestOutline.fromJson(Map<String, dynamic> json) => TestOutline(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
