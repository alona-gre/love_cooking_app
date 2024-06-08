import 'package:flutter/material.dart';

class AddToCollectionLightButton extends StatelessWidget {
  const AddToCollectionLightButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    required this.isFavorite,
  });

  final bool isLoading;
  final bool isFavorite;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const addToCollectionButtonKey = Key('addToCollectionButton');
  static const removeFromCollectionButtonKey =
      Key('removeFromCollectionButton');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isLoading
          ? const CircularProgressIndicator()
          : isFavorite
              ? IconButton(
                  onPressed: onPressed,
                  key: removeFromCollectionButtonKey,
                  icon: const Icon(Icons.bookmark_added),
                  color: Colors.white,
                )
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: onPressed,
                  ),
                ),
    );
  }
}
