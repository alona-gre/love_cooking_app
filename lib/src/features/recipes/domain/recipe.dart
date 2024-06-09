// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:love_cooking_app/src/features/recipes/domain/ingredient.dart';

/// * The recipe identifier is an important concept and can have its own type.
typedef RecipeID = String;

/// Class representing a recipe.
class Recipe {
  const Recipe({
    required this.categories,
    required this.steps,
    required this.duration,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.portion,
  });

  /// Unique recipe id
  final String id;
  final List<String> categories;
  final String title;
  final String description;
  final String imageUrl;
  final List<Ingredient> ingredients;
  final int portion;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  @override
  String toString() {
    return 'Recipe(id: $id, imageUrl: $imageUrl, title: $title, description: $description, categories: $categories, ingredients: $ingredients, steps: $steps, duration: $duration, isGlutenFree: $isGlutenFree, isLactoseFree: $isLactoseFree, isVegan: $isVegan, isVegetarian: $isVegetarian, portion: $portion,)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.categories, categories) &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.steps, steps) &&
        other.duration == duration &&
        other.isGlutenFree == isGlutenFree &&
        other.isLactoseFree == isLactoseFree &&
        other.isVegan == isVegan &&
        other.isVegetarian == isVegetarian;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categories.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        ingredients.hashCode ^
        steps.hashCode ^
        duration.hashCode ^
        isGlutenFree.hashCode ^
        isLactoseFree.hashCode ^
        isVegan.hashCode ^
        isVegetarian.hashCode;
  }

  Recipe copyWith({
    String? id,
    List<String>? categories,
    String? title,
    String? description,
    String? imageUrl,
    List<Ingredient>? ingredients,
    int? portion,
    List<String>? steps,
    int? duration,
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
  }) {
    return Recipe(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      portion: portion ?? this.portion,
      steps: steps ?? this.steps,
      duration: duration ?? this.duration,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }
}
