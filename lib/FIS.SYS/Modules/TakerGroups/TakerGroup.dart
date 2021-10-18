import 'package:khao_thi_gv/F.Utils/Convert.dart';
import 'TakerGroupStatus.dart';

class TakerGroup {
  int id;
  String name;
  String formGroupCode;
  DateTime fromTime;
  DateTime dueTime;
  DateTime toTime;
  bool statusProctor;
  int timeLimit;
  bool controlMode; //true : tư dong
  int takerCount;
  int takerSubmitCount;
  int status;
  String companyCode;
  String codeProctor1;
  String codeProctor2;

  String get getStringTimeOpen {
    if (controlMode) {
      return '${fromTime.format("dd/MM/yyyy, HH:mm")} - ${dueTime.format("dd/MM/yyyy, HH:mm")}';
    }
    switch (status) {
      case TakerGroupStatusBase.moitao:
      case TakerGroupStatusBase.tamDung:
        return 'Đang cập nhật';
      case TakerGroupStatusBase.dangThi:
        return 'Đã mở';
      case TakerGroupStatusBase.hetHanRutDe:
      case TakerGroupStatusBase.daDongKip:
        return 'Đã hết hạn';
      case TakerGroupStatusBase.daXoa:
        return 'Đã hết hạn';
      default:
    }
    return '';
  }

  int get statusDisplay {
    if (status == TakerGroupStatusBase.dangThi &&
        fromTime.isAfter(DateTime.now())) {
      return TakerGroupStatusBase.sanSangThi;
    }
    return status;
  }

  TakerGroup(
      {this.id,
      this.name,
      this.formGroupCode,
      this.fromTime,
      this.dueTime,
      this.toTime,
      this.statusProctor,
      this.timeLimit,
      this.controlMode,
      this.takerCount,
      this.takerSubmitCount,
      this.status,
      this.companyCode,
      this.codeProctor1,
      this.codeProctor2});

  factory TakerGroup.fromJson(Map<String, dynamic> json) {
    final user = TakerGroup(
      id: json['id'],
      name: json['name'],
      formGroupCode: json['test_form_group_code'],
      fromTime:
          json['from_time'] == null ? null : DateTime.parse(json['from_time']),
      dueTime:
          json['due_time'] == null ? null : DateTime.parse(json['due_time']),
      toTime: json['to_time'] == null ? null : DateTime.parse(json['to_time']),
      statusProctor: (json['status_proctor'] as num) == 0 ? false : true,
      timeLimit: json['time_limit'],
      controlMode: (json['control_mode'] as num) == 0 ? false : true,
      takerCount: json['taker_count'],
      takerSubmitCount: json['taker_submit_count'],
      status: json['status'],
      companyCode: json['company_code'],
      codeProctor1: json['code_proctor_1'],
      codeProctor2: json['code_proctor_2'],
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['test_form_group_code'] = formGroupCode;
    data['status_proctor'] = statusProctor ? 1 : 0;
    data['time_limit'] = timeLimit;
    data['control_mode'] = controlMode ? 0 : 1;
    data['taker_count'] = takerCount;
    data['taker_submit_count'] = takerSubmitCount;
    data['status'] = status;
    data['company_code'] = companyCode;
    data['from_time'] = fromTime.toIso8601String();
    data['due_time'] = dueTime.toIso8601String();
    data['to_time'] = toTime.toIso8601String();
    return data;
  }
}
