import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/StyleBase.dart';

class StatLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const StatLinePointChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    if (seriesList == null) {
      return Container(
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
      );
    } else {
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
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
