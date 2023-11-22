import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:interview_flutter/components/bottom_loader.dart';
import 'package:interview_flutter/src/controllers/person_controller.dart';
import 'package:interview_flutter/components/person_list_item.dart';

class PersonScreen extends GetView<PersonController> {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Persons'),
          elevation: 5,
        ),
        body: GetBuilder<PersonController>(
          id: "person_list",
          builder: (controller) {
            if (controller.loading && controller.listPersons.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 1,
              onRefresh: () {
                controller.refreshList();
                return Future<void>.delayed(const Duration(seconds: 2));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return PersonListItem(
                            person: controller.listPersons[index]);
                      },
                      itemCount: controller.listPersons.length,
                    ),
                  ),
                  if (controller.loading) ...[
                    const BottomLoader(),
                  ]
                ],
              ),
            );
          },
        ));
  }
}
