import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/shimmer_loading_recipe_card.dart';

/// Custom image widget that loads an image as a static asset.
class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // Use [CachedNetworkImage] if the url points to a remote resource
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 300,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const ShimmerLoadingRecipeCard(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
