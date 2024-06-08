// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:love_cooking_app/src/features/Recipes/domain/Recipe.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';

/// Model class representing the collection contents.
class Collection {
  const Collection([this.items = const {}]);

  /// All the items in the collection, where:
  /// - key: Recipe ID
  /// - value: bool (whether it is favorite)
  final Map<RecipeID, bool> items;

  @override
  String toString() => 'Collection(items: $items)';

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      Map<RecipeID, bool>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  bool operator ==(covariant Collection other) {
    if (identical(this, other)) return true;

    return mapEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

extension CollectionItems on Collection {
  /// this method converts a Map of items into a List of items
  /// used to display all the items of the Collection
  List<CollectionItem> toCollectionItemsList() {
    return items.entries.map((entry) {
      return CollectionItem(
        recipeId: entry.key,
        isFavorite: entry.value,
      );
    }).toList();
  }
}
