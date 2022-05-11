import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  const UserAvatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null || imageUrl!.isNotEmpty) {
      return CachedNetworkImage(imageUrl: imageUrl!);
    } else {
      return const Icon(
        Icons.account_circle_rounded,
        size: 100,
      );
    }
  }
}
