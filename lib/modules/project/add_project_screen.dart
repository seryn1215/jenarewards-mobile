import 'package:capusle_rewards/bricks/custom_input_field.dart';
import 'package:capusle_rewards/bricks/gradient_app_bar.dart';
import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProjectScreen extends StatelessWidget {
  final ProjectController controller = Get.find();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Add Project',
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomInputField(
              controller: _titleController,
              label: 'Title',
              hint: 'Enter project title',
            ),
            SizedBox(height: 16),
            CustomInputField(
              controller: _descriptionController,
              label: 'Description',
              maxLines: 4,
            ),
            SizedBox(height: 16),
            CustomInputField(
              controller: _deadlineController,
              label: 'Deadline',
              hint: 'dd/mm/yyyy',
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.createProject(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  deadline: DateUtil.parseDate(_deadlineController.text),
                );
              },
              child: Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }
}
