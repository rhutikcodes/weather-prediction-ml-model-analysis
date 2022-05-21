import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/repository/bar_data.dart';

class BarTitles {
  static AxisTitles getSideAxisTitles(bool showData) => AxisTitles(
      sideTitles: SideTitles(
          interval: BarData.interval.toDouble(),
          reservedSize: 30,
          getTitlesWidget: sideTitles,
          showTitles: showData));
  static AxisTitles getTopBottomAxisTitles(bool showData) => AxisTitles(
      sideTitles: SideTitles(
          showTitles: showData,
          reservedSize: 50,
          getTitlesWidget: bottomTitles));

  static Widget bottomTitles(double value, TitleMeta meta) {
    String text = meta.formattedValue;

    for (var element in BarData.barData) {
      if (element.id == int.parse(meta.formattedValue)) {
        text = element.name;
      }
    }
    const style = TextStyle(fontSize: 12, color: Colors.white);
    return Center(
        child: Text(
      text,
      style: style,
    ));
  }

  static Widget sideTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
    return Padding(
      child: Text(meta.formattedValue, style: style),
      padding: const EdgeInsets.only(left: 8),
    );
  }
}
