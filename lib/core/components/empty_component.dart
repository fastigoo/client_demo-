import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/text_styles.dart';

class EmptyComponent extends StatelessWidget {
  const EmptyComponent({
    super.key,
    this.text = "No data found",
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ResourceManager.getAssetResource(
            emptyImage,
            type: ResourceType.image,
          ),
          width: 150.r,
          height: 150.r,
          fit: BoxFit.cover,
        ),
        Center(
          child: Text(
            text,
            style: TextStyles.largeBodyTextStyle(context),
          ),
        ),
      ],
    );
  }
}
