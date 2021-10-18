/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../Styles/StyleBase.dart';
import '../../TakerGroupStatus.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<Map<int, int>> datas;

  SimpleBarChart({this.animate, this.datas, this.seriesList});

  final staticTicks = <charts.TickSpec<String>>[
    charts.TickSpec('1'),
    charts.TickSpec('2'),
    charts.TickSpec('3'),
    charts.TickSpec('4'),
    charts.TickSpec('5'),
    charts.TickSpec('6'),
    charts.TickSpec('7'),
    charts.TickSpec('8'),
    charts.TickSpec('9'),
    charts.TickSpec('10')
  ];

  @override
  Widget build(BuildContext context) {
    if (datas == null) {
      return Container();
    }
    return charts.BarChart(buildChar(),
        animate: animate,
        domainAxis: charts.OrdinalAxisSpec(
            tickProviderSpec: charts.StaticOrdinalTickProviderSpec(staticTicks))
        // domainAxis:
        //     new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec())
        );
  }

  List<charts.Series<OrdinalSales, String>> buildChar() {
    final data = <OrdinalSales>[];

    final maps = <int, int>{};
    for (final item in datas) {
      maps[item.keys.first] = item[item.keys.first];
    }
    for (var i = 0; i < 21; i++) {
      var rs = 1;
      if (i >= 7) {
        rs = 2;
      }
      if (i >= 10) {
        rs = 3;
      }
      if (i >= 13) {
        rs = 4;
      }
      if (i >= 16) {
        rs = 5;
      }

      final tmp = i % 2 != 0 ? (i / 2).toStringAsFixed(1) : (i / 2).round();
      data.add(OrdinalSales('$tmp', maps[i] ?? 0, pointColor[rs]));
    }

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (OrdinalSales clickData, _) =>
            charts.ColorUtil.fromDartColor(clickData.color),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<OrdinalSales, String>> createSampleData() {
    final data = [
      OrdinalSales('5', 5, FColors.blue6),
      OrdinalSales('6', 25, FColors.blue6),
      OrdinalSales('7', 100, FColors.blue6),
      OrdinalSales('8', 75, FColors.blue6),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.

}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final Color color;

  OrdinalSales(this.year, this.sales, this.color);
}
