import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String heroTag;
  final double size;
  const UserAvatar({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Hero(
        tag: heroTag,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          imageBuilder: (context, imageProvider) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                border: Border.all(color: Theme.of(context).primaryColor)),
          ),
        ),
      );
    } else {
      return Icon(
        Icons.account_circle_rounded,
        size: size,
      );
    }
  }
}
