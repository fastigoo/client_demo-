import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/post/presentation/states/post_controller.dart';
import 'package:learning/routes/app_pages.dart';

class PostsScreen extends GetView<PostController> {
  const PostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title'.tr,
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.getPosts();
            },
            icon: const Icon(Icons.download),
          ),
          GestureDetector(
            onTap: () {
              Get.updateLocale(const Locale('ar', 'SA'));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text("Ar"),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.updateLocale(const Locale('en', 'US'));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text("En"),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.isFalse
            ? ListView.builder(
                itemCount: controller.getPostsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Map<String, dynamic> data = {
                        "title": controller.getPostsList[index].title,
                        "body": controller.getPostsList[index].body,
                      };
                      Get.toNamed(
                        Routes.PROFILE,
                        arguments: data,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.getPostsList[index].title ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.getPostsList[index].body ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
