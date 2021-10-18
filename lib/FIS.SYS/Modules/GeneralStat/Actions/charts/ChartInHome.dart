/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/SummaryStat.dart';

import '../../../../../F.Utils/Convert.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Styles/StyleBase.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const DonutPieChart(this.seriesList, {this.animate});

  // Creates a [DonutPieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() => DonutPieChart(
        _createSampleData(),
        // Disable animations for image tests.
        animate: false,
      );

  @override
  Widget build(BuildContext context) {
    if (seriesList == null) {
      return Container();
    }
    return Container(
      width: 180,
      height: 180,
      child: charts.PieChart(
        seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 45,
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(
          0, 43, charts.ColorUtil.fromDartColor(const Color(0xffFAAD14))),
      LinearSales(
          1, 55, charts.ColorUtil.fromDartColor(const Color(0xff00BC3C))),
      LinearSales(
          2, 45, charts.ColorUtil.fromDartColor(const Color(0xffFA8C16))),
    ];

    return [
      charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          colorFn: (LinearSales row, __) => row.color,
          // fillColorFn: (_, __) =>
          //     charts.MaterialPalette.blue.shadeDefault.lighter,
          labelAccessorFn: (LinearSales row, _) => '${row.sales}',
          patternColorFn: (LinearSales sales, _) => sales.color,
          outsideLabelStyleAccessorFn: (LinearSales row, _) =>
              charts.TextStyleSpec(color: row.color)
          //  fillColorFn: (LinearSales row, _) => row.color),
          // areaColorFn: (LinearSales row, _) => row.color
          ),
    ];
  }
}

Widget infoChart(SummaryStat summaryStat) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.gold6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText(
                'Chưa thi: ${summaryStat.totalTodo.toDouble().toMoney().replaceAll(".0", "")}',
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.blue6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText(
                  'Đang thi: ${summaryStat.totalDoing.toDouble().toMoney().replaceAll(".0", "")}'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.red6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText(
                  'Chờ chấm điểm: ${summaryStat.totalWaitForMark.toDouble().toMoney().replaceAll(".0", "")}'),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.green6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText(
                  'Đã thi: ${summaryStat.totalDone.toDouble().toMoney().replaceAll(".0", "")}'),
            ],
          ),
        )
      ],
    );

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales, this.color);
}
