import 'package:capusle_rewards/main.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/shared/widgets/activity_card.dart';
import 'package:capusle_rewards/shared/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:capusle_rewards/shared/widgets/msg/msg_box.dart';
import 'package:get/get.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({Key? key}) : super(key: key);

  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> with TickerProviderStateMixin {
  final List<MsgBox> _messages = [];
  final FocusNode _focusNode = FocusNode();
  final _textController = TextEditingController();
  bool _isComposing = false;
  bool _isSelf = true;

  @override
  void initState() {
    super.initState();

    // Get.find<ProjectController>().loadMyActivities();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProjectController>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'notifications'.tr + '(${controller.myActivities.length})',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: RefreshIndicator(
                  onRefresh: () {
                    return controller.loadMyActivities();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    reverse: false,
                    itemCount: controller.myActivities.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        activity: controller.myActivities[index],
                      );
                    },
                  ),
                ),
              ),
              const Divider(height: 1.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ))
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    var message = _isSelf
        ? SendMsgBox(
            message: text,
            animationController: _buildAnimationController(),
          )
        : ReceiveMsgBox(
            message: text,
            animationController: _buildAnimationController(),
          );

    setState(() {
      _messages.insert(0, message);
    });

    _focusNode.requestFocus();
    message.animationController.forward();

    _isSelf = !_isSelf;
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }
}
