import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final int progress;
  final int total;
  final int coins;
  final Function onTap;
  final bool inProgress;
  final DateTime startDate;
  final DateTime endDate;

  ProjectCard({
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
    required this.coins,
    required this.onTap,
    required this.inProgress,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: inProgress
                ? Border.all(
                    color: Color(0xff00dd8c),
                    width: 2,
                  )
                : null, //
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd').format(startDate) +
                          "~" +
                          DateFormat('yyyy/MM/dd').format(endDate),
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffaeaeae),
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "${inProgress ? "in_progress".tr : "completed".tr}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color:
                            inProgress ? Color(0xff90a4f9) : Color(0xfffec4c4),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "+ $coins 🟡",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffF43939),
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
