import 'dart:ui';
import '../../Styles/Colors.dart';

class StateMachine {
  int state;
  String action;
  StateMachine(this.state, this.action);
}

class TakerGroupStatusBase {
  static const moitao = 1;
  static const dangMoKip = 11;
  static const dangThi = 13;
  static const sanSangThi = 130;
  static const tamDung = 15;
  static const hetHanRutDe = 17;
  static const dangDongKip = 19;
  static const daDongKip = 20;
  static const chamXong = 22;
  static const ketThuc = 100;
  static const daXoa = -1;
}

Map<int, String> takerGroupStatus = const <int, String>{
  TakerGroupStatusBase.moitao: 'Mới khởi tạo',
  TakerGroupStatusBase.dangMoKip: 'Đang mở kíp',
  TakerGroupStatusBase.dangThi: 'Đang thi',
  TakerGroupStatusBase.sanSangThi: 'Sẵn sàng thi',
  TakerGroupStatusBase.tamDung: 'Tạm dừng',
  TakerGroupStatusBase.hetHanRutDe: 'Hết hạn rút đề',
  TakerGroupStatusBase.dangDongKip: 'Đang đóng kíp',
  TakerGroupStatusBase.daDongKip: 'Đã đóng kíp',
  TakerGroupStatusBase.chamXong: 'Chấm xong',
  TakerGroupStatusBase.ketThuc: 'Kết thúc',
  TakerGroupStatusBase.daXoa: 'Đã xóa'
};

//19,20,-1 xám; 15 đỏ; 17 cam, 11,13 blue;1 EB2F96
List<StateMachine> takerGroupStatusMachine = [
  StateMachine(1, 'Play'),
  StateMachine(1, 'Delete'),
  StateMachine(13, 'Pause'),
  StateMachine(13, 'Lock'),
  StateMachine(13, 'End'),
  StateMachine(15, 'Play'),
  StateMachine(15, 'Lock'),
  StateMachine(15, 'End'),
  // StateMachine(17, 'UnLock'),
  StateMachine(17, 'End'),
  StateMachine(17, 'Pause'),
  StateMachine(20, 'Delete')
];

Map<int, Color> pointColor = const <int, Color>{
  1: FColors.red6,
  2: FColors.gold6,
  3: FColors.yellow6,
  4: FColors.lime6,
  5: FColors.green6
};

class TestTakerStatusBase {
  static const chuaThi = 1;
  static const dangThi = 35;
  static const daThi = 36;
  static const choChamDiem = 37;
}

Map<int, String> testTakerStatus = const <int, String>{
  1: 'Chưa thi',
  35: 'Đang thi',
  36: 'Đã thi',
  37: 'Chờ chấm điểm',
};
Map<int, Color> testTakerGroupStatus = const <int, Color>{
  TestTakerStatusBase.chuaThi: FColors.gold6,
  TestTakerStatusBase.dangThi: FColors.blue6,
  TestTakerStatusBase.daThi: FColors.green6,
  TestTakerStatusBase.choChamDiem: FColors.red6,
};
