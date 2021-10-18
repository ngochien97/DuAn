import 'package:flutter/cupertino.dart';
import '../../TakerGroups/Stat.dart';
import '../../TakerGroups/SummaryStat.dart';

class GeneralStat extends ChangeNotifier {
  List<Stat> _stats;
  SummaryStat _summaryStat;

  List<Stat> get getStats => _stats;
  SummaryStat get getSummaryStat => _summaryStat;

  void setStatsData(List<Stat> stats) {
    _stats = stats;
    notifyListeners();
  }

  void setSummaryStatData(SummaryStat summaryStat) {
    _summaryStat = summaryStat;
    notifyListeners();
  }
}
