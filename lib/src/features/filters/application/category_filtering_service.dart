import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/local/category/local_category_filtering_repository.dart';

import 'package:love_cooking_app/src/features/filters/data/remote/category/remote_category_filtering_repository.dart';

import 'package:love_cooking_app/src/features/filters/domain/filter_item.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/domain/mutable_filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_filtering_service.g.dart';

class CategoryFilteringService {
  CategoryFilteringService(this.ref);
  final Ref ref;

  /// fetch the filtering from the local or remote repository
  /// depending on the user auth state
  Future<Filtering> fetchFiltering() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref
          .read(remoteCategoryFilteringRepositoryProvider)
          .fetchFiltering(user.uid);
    } else {
      return ref
          .read(localCategoryFilteringRepositoryProvider)
          .fetchFiltering();
    }
  }

  /// save the filtering to the local or remote repository
  /// depending on the user auth state
  Future<void> updateFiltering(Filtering filtering) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref
          .read(remoteCategoryFilteringRepositoryProvider)
          .updateFiltering(user.uid, filtering);
    } else {
      await ref
          .read(localCategoryFilteringRepositoryProvider)
          .updateFiltering(filtering);
    }
  }

  /// sets an item in the local or remote filtering depending on the user auth state
  Future<void> setItem(FilterItem item) async {
    final filtering = await fetchFiltering();
    final updated = filtering.updateFilterItem(item);
    await updateFiltering(updated);
  }

  // TODO: implement filtering customization
  // /// adds an item in the local or remote filtering depending on the user auth state
  // Future<void> addItem(FilterItem item) async {
  //   final filtering = await fetchFiltering();
  //   final updated = filtering.addFilter(item);
  //   await updateFiltering(updated);
  // }

  // /// removes a filter item from the local or remote filtering depending on the user auth
  // /// state
  // Future<void> removeItemByFilterName(String filterName) async {
  //   final filtering = await fetchFiltering();
  //   final updated = filtering.removeItemByFilterName(filterName);
  //   await updateFiltering(updated);
  // }
}

@Riverpod(keepAlive: true)
CategoryFilteringService categoryFilteringService(
    CategoryFilteringServiceRef ref) {
  return CategoryFilteringService(ref);
}

@Riverpod(keepAlive: true)
Stream<Filtering> categoryFiltering(CategoryFilteringRef ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(remoteCategoryFilteringRepositoryProvider)
        .watchFiltering(user.uid);
  } else {
    return ref.watch(localCategoryFilteringRepositoryProvider).watchFiltering();
  }
}
