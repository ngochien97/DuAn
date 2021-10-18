import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StatLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const StatLinePointChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    if (seriesList == null) {
      return Container();
    }
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(includeArea: true),
      customSeriesRenderers: [
        charts.PointRendererConfig(customRendererId: 'customPoint')
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
