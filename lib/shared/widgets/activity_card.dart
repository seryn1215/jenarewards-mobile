import 'package:capusle_rewards/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  bool showProject;

  bool isNotification;

  ActivityCard(
      {required this.activity,
      this.showProject = false,
      this.isNotification = true});

  @override
  Widget build(BuildContext context) {
    var formattedTimestamp =
        DateFormat('MMM dd, yyyy - HH:mm').format(activity.joinedAt);

    // Define the subtitle with the formatted timestamp
    var subtitleText = '$formattedTimestamp';

    // Check if showProject is true, then append project name to the subtitle
    if (showProject) {
      subtitleText +=
          '\nProject: ${activity.project?.name}'; // Assuming activity has a projectName field
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "+ ${activity.creditedCoins} 🟡",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('yyyy-MM-dd HH:mm').format(activity.joinedAt),
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xffaeaeae),
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );

    // return Card(
    //   borderOnForeground: true,
    //   color: ColorConstants
    //       .backgroundColor, // Ensure ColorConstants is defined somewhere
    //   child: ListTile(
    //     leading: Icon(
    //       Icons.monetization_on,
    //       color: showProject ? Colors.green : null,
    //     ),
    //     title: Text('coins_credited'.tr +
    //         ': ${activity.creditedCoins}'
    //             .tr), // Ensure you handle localization with .tr or replace it as needed
    //     subtitle: Text(subtitleText),
    //   ),
    // );
  }
}
