import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_app/core/widgets/app_text_form_field.dart';
import 'package:notification_app/core/widgets/bloc_button.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:notification_app/features/push_notification/presentation/manager/push_notification_cubit/push_notification_cubit.dart';

class PushNotificationForm extends StatefulWidget {
  const PushNotificationForm({super.key});

  @override
  State<PushNotificationForm> createState() => _PushNotificationFormState();
}

class _PushNotificationFormState extends State<PushNotificationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: "Notification Title",
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
            },
          ),
          const SizedBox(height: 18),
          AppTextFormField(
            hintText: "Notification Body",
            minLines: 5,
            controller: bodyController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          
          const SizedBox(height: 25),
          BlocButton<PushNotificationCubit, PushNotificationState>(
            label: "Send Notification",
            isLoading: (state) => state is PushNotificationLoadingState,
            onPressed: () {
              validateThenPushNotification(context);
              titleController.clear();
              bodyController.clear();
            },
          ),
        ],
      ),
    );
  }

  void validateThenPushNotification(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<PushNotificationCubit>().pushNotification(
        notificationData: NotificationData(
          title: titleController.text,
          body: bodyController.text,
        ),
      );
    }
  }
}
