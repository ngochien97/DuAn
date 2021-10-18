import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../../TakerGroups/TakerGroupStatus.dart';
import '../Provider/GeneralStat.dart';
import 'charts/ChartCircleHashCode.dart';
import 'charts/ChartInHome.dart';
import 'charts/StatLinePointChart.dart';

class StudentStat extends StatefulWidget {
  @override
  _StudentStatState createState() => _StudentStatState();
}

class _StudentStatState extends State<StudentStat> {
  ChartCirHashCode chartHashcode = ChartCirHashCode.withSampleData();
  List<charts.Series> seriesListDefault;
  List<charts.Series<LinearSales, int>> seriesListBar;

  void init() {
    final summary = context.read<GeneralStat>().getSummaryStat;
    if (summary == null) {
      setState(() {
        seriesListDefault = _createSampleData();
      });
    }
  }

  void buildChartBar() {
    final group =
        Provider.of<GeneralStat>(context, listen: true).getSummaryStat;
    if (group.totalDoing +
            group.totalDone +
            group.totalTodo +
            group.totalWaitForMark ==
        0) {
      return;
    }

    final tmp = <charts.Series<LinearSales, int>>[];

    final data = [
      LinearSales(
          0,
          group.totalTodo,
          charts.ColorUtil.fromDartColor(
              testTakerGroupStatus[TestTakerStatusBase.chuaThi])),
      LinearSales(
          3,
          group.totalDone,
          charts.ColorUtil.fromDartColor(
              testTakerGroupStatus[TestTakerStatusBase.daThi])),
      LinearSales(
          1,
          group.totalDoing,
          charts.ColorUtil.fromDartColor(
              testTakerGroupStatus[TestTakerStatusBase.dangThi])),
      LinearSales(
          2,
          group.totalWaitForMark,
          charts.ColorUtil.fromDartColor(
              testTakerGroupStatus[TestTakerStatusBase.choChamDiem])),
    ];
    tmp.add(charts.Series<LinearSales, int>(
      id: 'Sales',
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: data,
      colorFn: (LinearSales row, __) => row.color,
      // labelAccessorFn: (LinearSales row, _) => '${row.sales}',
      // patternColorFn: (LinearSales sales, _) => sales.color,
      // outsideLabelStyleAccessorFn: (LinearSales row, _) =>
      // charts.TextStyleSpec(color: row.color),
    ));

    setState(() {
      seriesListBar = tmp;
    });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final myFakeDesktopData = [
      TimeSeriesSales(DateTime.now().add(const Duration(days: 1)), 5),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 2)), 53),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 3)), 57),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 4)), 51),
    ];

    final myFakeMobileData = [
      TimeSeriesSales(DateTime.now().add(const Duration(days: 1)), 15),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 2)), 25),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 3)), 45),
      TimeSeriesSales(DateTime.now().add(const Duration(days: 4)), 65),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<GeneralStat>(context, listen: true).getSummaryStat !=
        null) {
      buildChartBar();
    }
    return Container(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: FColors.grey1,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: const FText('Thống kê thí sinh',
                style: FTextStyle.titleModules5),
          ),
          (seriesListBar != null && seriesListBar.isNotEmpty)
              ? Container(
                  height: 260.h,
                  child: Row(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: infoChart(
                              Provider.of<GeneralStat>(context, listen: false)
                                  .getSummaryStat)),
                      Expanded(
                          flex: 3,
                          child: Container(
                              alignment: Alignment.topRight,
                              child: DonutPieChart(seriesListBar))),
                    ],
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      height: 300.h,
                      child: Row(
                        children: <Widget>[
                          infoHashCode(),
                          Expanded(
                              flex: 2,
                              child:
                                  ChartCirHashCode(chartHashcode.seriesList)),
                        ],
                      ),
                    ),
                    Container(
                      height: 300.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [FEffect.elevation1],
                            color: FColors.grey1,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const FText(
                            'Chưa có dữ liệu',
                            style: FTextStyle.titleModules4,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    ));
  }
}
