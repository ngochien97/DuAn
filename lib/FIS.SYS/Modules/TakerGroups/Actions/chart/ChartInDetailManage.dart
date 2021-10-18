/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Styles/StyleBase.dart';

import '../../TakerGroupStatus.dart';

class ChartInDetailMg extends StatelessWidget {
  final List<charts.Series> seriesList;
  final List<Map<int, int>> datas;
  final bool animate;

  const ChartInDetailMg({this.animate, this.datas, this.seriesList});
  List<charts.Series<LinearSales, int>> buildCharBar() {
    final points = <int, int>{};
    final tmp = [0, 7, 10, 13, 16];
    for (final point in datas) {
      var rs = 0;

      for (final pointConfig in tmp) {
        if (point.keys.first >= pointConfig) {
          rs++;
        }
      }

      if (points[rs] == null) {
        points[rs] = point[point.keys.first];
      } else {
        // ignore: unnecessary_parenthesis
        points[rs] += (point[point.keys.first] ?? 0);
      }
    }
    Utils.console(points);
    final data = <LinearSales>[];
    if (points[1] != null) {
      data.add(LinearSales(
          0, points[1], charts.ColorUtil.fromDartColor(pointColor[1])));
    }
    if (points[2] != null) {
      data.add(LinearSales(
          1, points[2], charts.ColorUtil.fromDartColor(pointColor[2])));
    }
    if (points[3] != null) {
      data.add(LinearSales(
          2, points[3], charts.ColorUtil.fromDartColor(pointColor[3])));
    }
    if (points[4] != null) {
      data.add(LinearSales(
          3, points[4], charts.ColorUtil.fromDartColor(pointColor[4])));
    }
    if (points[5] != null) {
      data.add(LinearSales(
          4, points[5], charts.ColorUtil.fromDartColor(pointColor[5])));
    }

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

  @override
  Widget build(BuildContext conFText) {
    if (datas == null || datas.isEmpty) {
      return Container();
    }
    return Container(
      width: 170,
      height: 170,
      child: charts.PieChart(buildCharBar(),
          animate: animate,
          // Configure the width of the pie slices to 60px.
          //The remaining space in
          // the chart will be left as a hole in the center.
          defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 35,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.outside)
              ])),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> createSampleData() {
    final data = [
      LinearSales(0, 43, charts.ColorUtil.fromDartColor(FColors.yellow6)),
      LinearSales(1, 55, charts.ColorUtil.fromDartColor(FColors.gold6)),
      LinearSales(2, 45, charts.ColorUtil.fromDartColor(FColors.lime6)),
      LinearSales(3, 45, charts.ColorUtil.fromDartColor(FColors.red6)),
      LinearSales(4, 45, charts.ColorUtil.fromDartColor(FColors.green6)),
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

Widget infoChart() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
              const FText('Kém'),
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
                  backgroundColor: FColors.gold6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              const FText(
                'Yếu',
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
                  backgroundColor: FColors.yellow6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              const FText(
                'Trung Bình',
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
                  backgroundColor: FColors.lime6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              const FText('Khá'),
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
                  backgroundColor: FColors.green6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              const FText('Giỏi'),
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
