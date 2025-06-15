import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:client/core/components/loading_animation.dart';
import 'package:client/core/resources/images.dart';
import 'package:client/core/services/resource_manager.dart';

class CacheNetworkImageComponent extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget loadingAnimation;
  final Widget? errorWidget;
  final double? width;
  final double? height;

  const CacheNetworkImageComponent({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.loadingAnimation = const LoadingAnimation(),
    this.errorWidget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => loadingAnimation,
      errorWidget: (context, url, error) => errorWidget ?? _defaultErrorWidget(),
      fadeInCurve: Curves.easeIn,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _defaultErrorWidget() {
    return Image.asset(
      ResourceManager.getAssetResource(
        nullImg,
        type: ResourceType.image,
      ),
      fit: fit,
      width: width,
      height: height,
    );
  }
}