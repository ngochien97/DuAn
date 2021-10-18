import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../Provider/GeneralStat.dart';
import 'charts/ChartCircleHashCode.dart';
import 'charts/StatLinePointChart.dart';

class TurnStat extends StatefulWidget {
  @override
  _TurnStatState createState() => _TurnStatState();
}

class _TurnStatState extends State<TurnStat> {
  ChartCirHashCode chartHashcode = ChartCirHashCode.withSampleData();
  List<charts.Series> seriesList;
  List<charts.Series> seriesListDefault;

  void init() {
    final stats = context.read<GeneralStat>().getStats;
    if (stats == null) {
      setState(() {
        seriesListDefault = _createSampleData();
      });
    }
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

  void buildChartLine() {
    final stats = Provider.of<GeneralStat>(context, listen: true).getStats;
    final countTestTakerData = <TimeSeriesSales>[];
    final countTestTakerStartedData = <TimeSeriesSales>[];
    for (final stat in stats) {
      countTestTakerData.add(
          TimeSeriesSales(DateTime.parse(stat.date), stat.countTestTaker ?? 0));

      countTestTakerStartedData.add(TimeSeriesSales(
          DateTime.parse(stat.date), stat.countTestTakerStarted ?? 0));
    }

    final data = <charts.Series<TimeSeriesSales, DateTime>>[];
    // ignore: cascade_invocations
    data.add(
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Lượt thi',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(FColors.green5),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: countTestTakerData,
      ),
    );
    // ignore: cascade_invocations
    data.add(
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Lượt thi dự kiến',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(FColors.blue5),
        // areaColorFn specifies that the area skirt will be light red.
        // areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,

        data: countTestTakerStartedData,
      ),
    );
    setState(() {
      seriesList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<GeneralStat>(context, listen: true).getStats != null) {
      buildChartLine();
    }
    return Container(
        child: Container(
      color: FColors.grey1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 290,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: const FText('Thống kê lượt thi',
                style: FTextStyle.titleModules5),
          ),
          (seriesList != null && seriesList.isNotEmpty)
              ? Expanded(child: StatLinePointChart(seriesList))
              : Expanded(
                  child: Stack(
                    children: [
                      StatLinePointChart(seriesListDefault),
                      Container(
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
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
                ),
        ],
      ),
    )

        //     Container(
        //   color: FColors.grey1,
        //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   height: 300,
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         alignment: Alignment.topLeft,
        //         child: FText('Thống kê lượt thi', style: FTextStyle.titleModules5),
        //       ),
        //       (seriesList != null && seriesList.length > 0)
        //           ? Expanded(child: StatLinePointChart(seriesList))
        //           : Expanded(
        //               child: Stack(
        //                 children: [
        //                   Expanded(child: StatLinePointChart(seriesListDefault)),
        //                   Container(
        //                     height: 255,
        //                     width: MediaQuery.of(context).size.width,
        //                     decoration: BoxDecoration(
        //                       color: Color.fromRGBO(255, 255, 255, 0.8),
        //                     ),
        //                     child: Center(
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(4),
        //                           boxShadow: [FEffect.elevation1],
        //                           color: FColors.grey1,
        //                         ),
        //                         padding: EdgeInsets.all(8),
        //                         child: FText(
        //                           'Chưa có dữ liệu',
        //                           style: FTextStyle.titleModules4,
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             )
        //     ],
        //   ),
        // ),
        );
  }
}
