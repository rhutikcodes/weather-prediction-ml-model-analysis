import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/repository/bar_data.dart';
import 'package:weather_app/views/bar_tiles.dart';

import '../main.dart';

class ShowResultScreen extends StatelessWidget {
  const ShowResultScreen({Key? key}) : super(key: key);
  final double barWidth = 100;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Background(screenHeight: screenHeight, screenWidth: screenWidth),
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 45,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: screenHeight / 1.5,
              width: screenWidth / 1.5,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  groupsSpace: 12,
                  borderData: FlBorderData(
                    border: const Border(
                      left: BorderSide(width: 1, color: Colors.white),
                      bottom: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    bottomTitles: BarTitles.getTopBottomAxisTitles(true),
                    topTitles: BarTitles.getTopBottomAxisTitles(false),
                    leftTitles: BarTitles.getSideAxisTitles(true),
                    rightTitles: BarTitles.getSideAxisTitles(false),
                  ),
                  gridData: FlGridData(show: false),
                  barGroups: BarData.barData
                      .map(
                        (data) => BarChartGroupData(
                          x: data.id,
                          barRods: [
                            BarChartRodData(
                              toY: data.y,
                              width: barWidth,
                              color: data.color,
                              borderRadius: data.y > 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    )
                                  : const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
