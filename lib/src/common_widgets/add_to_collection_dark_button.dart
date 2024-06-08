import 'package:flutter/material.dart';

class AddToCollectionDarkButton extends StatelessWidget {
  const AddToCollectionDarkButton({
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
              ? const Icon(
                  key: removeFromCollectionButtonKey,
                  Icons.bookmark_added,
                  color: Colors.black,
                )
              : CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      onPressed;
                    },
                  ),
                ),
    );
  }
}
