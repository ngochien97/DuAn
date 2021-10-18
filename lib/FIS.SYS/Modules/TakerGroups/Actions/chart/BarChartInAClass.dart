/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartInAClass extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const BarChartInAClass(this.seriesList, {this.animate});

  // ignore: comment_references
  /// Creates a [BarChart] with sample data and no transition.
  factory BarChartInAClass.withSampleData() => BarChartInAClass(
        _createSampleData(),
        // Disable animations for image tests.
        animate: false,
      );

  @override
  Widget build(BuildContext context) => charts.BarChart(
        seriesList,
        animate: animate,
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
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
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
