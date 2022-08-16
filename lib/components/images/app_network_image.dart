import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final bool asCover;

  const AppNetworkImage({
    Key? key,
    required this.url,
    this.asCover = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: url,
      imageUrl: url,
      imageBuilder: asCover
          ? (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              )
          : null,
      // placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
