

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_constants.dart';

class ReusableCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget placeholderWidget;
  final Widget errorWidget;
  final double? height;
  final double? width;

  const ReusableCachedNetworkImage({
    required this.imageUrl,
    required this.placeholderWidget,
    required this.errorWidget,
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customCacheManager = CacheManager(
      Config(
        AppConstants.kImageCachedKey,
        stalePeriod: const Duration(days: int365),
      ),
    );

    return CachedNetworkImage(
      cacheManager: customCacheManager,
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      imageUrl: imageUrl,
      placeholder: (context, url) => placeholderWidget,
      errorWidget: (context, url, error) => errorWidget,
      fit: BoxFit.cover,
    );
  }
}



CachedNetworkImage reusableCachedNetworkImage(
    {required String imageUrl,
    double? width,
    double? height,
    String? imageAssets}) {
  return CachedNetworkImage(
    width: width,
    height: height,
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) =>
        Image.asset(imageAssets ?? ImageAssets.profileImage),
  );
}
