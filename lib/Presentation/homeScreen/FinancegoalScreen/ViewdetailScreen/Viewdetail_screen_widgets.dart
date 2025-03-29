import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget CustomCircularProgressBar(
    int index, viewdetailfinancialModel modeldata) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircularPercentIndicator(
        radius: displaysize.height * .05,
        lineWidth: 9,
        percent: (double.parse(modeldata.progress_percentage)) > 1
            ? 1
            : double.parse(modeldata.progress_percentage),
        center: Text(
            "₹${((double.parse(modeldata.total_spent)).toStringAsFixed(2))}/-", // Display percentage
            style: CustomTextStyler().styler(
                size: .013,
                type: 'M',
                color: (double.parse(modeldata.progress_percentage)) > 1
                    ? Colors.red
                    : neo_theme_blue3)),
        progressColor: (double.parse(modeldata.progress_percentage)) > 1
            ? Colors.red
            : Colors.primaries[index % Colors.primaries.length + 2]
                .withValues(alpha: .7),
        backgroundColor: Colors.grey[300]!,
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animationDuration: 1200,
      ),
      SizedBox(height: displaysize.height * .005),
      Text(
          modeldata.category_name
              .substring(0, modeldata.category_name.indexOf('&') - 1),
          style: CustomTextStyler().styler(
              size: .018,
              type: 'M',
              color: (double.parse(modeldata.progress_percentage)) > 1
                  ? Colors.red
                  : neo_theme_blue3))
    ],
  );
}
