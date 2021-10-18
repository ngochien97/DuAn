/// Donut chart example. This is a simple pie chart with a hole in the middle.
// ignore: library_prefixes
import 'package:charts_flutter/flutter.dart' as chartsHashCode;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Styles/StyleBase.dart';

class ChartCirHashCode extends StatelessWidget {
  final List<chartsHashCode.Series> seriesList;
  final bool animate;

  const ChartCirHashCode(this.seriesList, {this.animate});

  /// Creates a [ChartCirHashCode] with sample data and no transition.
  factory ChartCirHashCode.withSampleData() => ChartCirHashCode(
        _createSampleData(),
        // Disable animations for image tests.
        animate: false,
      );

  @override
  Widget build(BuildContext context) => Container(
        width: 170,
        height: 170,
        child: chartsHashCode.PieChart(seriesList,
            animate: animate,
            // Configure the width of the pie slices to 60px. The remaining space in
            // the chart will be left as a hole in the center.
            defaultRenderer: chartsHashCode.ArcRendererConfig(
                arcWidth: 35,
                arcRendererDecorators: [
                  chartsHashCode.ArcLabelDecorator(
                      labelPosition: chartsHashCode.ArcLabelPosition.outside)
                ])),
      );

  /// Create one series with sample hard coded data.
  static List<chartsHashCode.Series<LinearHashCode, int>> _createSampleData() {
    final data = [
      LinearHashCode(
          0, 43, chartsHashCode.ColorUtil.fromDartColor(FColors.grey5)),
      LinearHashCode(
          1, 55, chartsHashCode.ColorUtil.fromDartColor(FColors.grey5)),
      LinearHashCode(
          2, 45, chartsHashCode.ColorUtil.fromDartColor(FColors.grey5)),
      LinearHashCode(
          3, 45, chartsHashCode.ColorUtil.fromDartColor(FColors.grey5)),
      LinearHashCode(
          4, 45, chartsHashCode.ColorUtil.fromDartColor(FColors.grey5)),
    ];

    return [
      chartsHashCode.Series<LinearHashCode, int>(
          id: 'Sales',
          domainFn: (LinearHashCode sales, _) => sales.year,
          measureFn: (LinearHashCode sales, _) => sales.sales,
          data: data,
          colorFn: (LinearHashCode row, __) => row.color,
          // fillColorFn: (_, __) =>
          //     charts.MaterialPalette.blue.shadeDefault.lighter,
          labelAccessorFn: (LinearHashCode row, _) => '${row.sales}',
          patternColorFn: (LinearHashCode sales, _) => sales.color,
          outsideLabelStyleAccessorFn: (LinearHashCode row, _) =>
              chartsHashCode.TextStyleSpec(color: row.color)
          //  fillColorFn: (LinearSales row, _) => row.color),
          // areaColorFn: (LinearSales row, _) => row.color
          ),
    ];
  }
}

Widget infoHashCode() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.gold6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText('Yếu'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.yellow6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText('Trung Bình'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.lime6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText('Khá'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.red6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText('Kém'),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: FBoundingBox(
                  backgroundColor: FColors.green6,
                  size: FBoxSize.size16x16,
                  type: FBoundingBoxType.circle,
                  child: Container(),
                ),
              ),
              FText('Giỏi'),
            ],
          ),
        )
      ],
    );

/// Sample linear data type.
class LinearHashCode {
  final int year;
  final int sales;
  final chartsHashCode.Color color;

  LinearHashCode(this.year, this.sales, this.color);
}
