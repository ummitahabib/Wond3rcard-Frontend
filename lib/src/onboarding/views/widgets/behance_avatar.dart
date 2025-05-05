import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';

class BehanceAvatar extends StatelessWidget {
  const BehanceAvatar({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SpacingConstants.size45,
      height: SpacingConstants.size45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SpacingConstants.size100),
        child: Image.network(
          fit: BoxFit.cover,
          image,
          width: SpacingConstants.size45,
          height: SpacingConstants.size45,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported);
          },
        ),
      ),
    );
  }
}
