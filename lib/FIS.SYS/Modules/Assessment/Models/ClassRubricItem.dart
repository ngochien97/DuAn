class ClassRubricItem {
  int id;
  String name;
  int studentCount;
  String tags;
  int get rubricCount {
    return classRubrics.length;
  }

  List<ClassRubrics> classRubrics = [];

  ClassRubricItem(
      {this.id, this.name, this.studentCount, this.classRubrics, this.tags});

  ClassRubricItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tags = json['tags'];
    studentCount = json['student_count'];
    if (json['class_rubrics'] != null) {
      classRubrics = <ClassRubrics>[];
      json['class_rubrics'].forEach((v) {
        classRubrics.add(ClassRubrics.fromJson(v));
      });
    }
  }
}

class ClassRubrics {
  int id;
  String rubricCode;
  String rubricName;

  ClassRubrics({this.id, this.rubricCode, this.rubricName});

  ClassRubrics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rubricCode = json['rubric_code'];
    rubricName = json['rubric_name'];
  }
}
