// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_recipes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesRepositoryHash() => r'b750a8b405e7218d2bb48e271244c85780381686';

/// See also [recipesRepository].
@ProviderFor(recipesRepository)
final recipesRepositoryProvider =
    AutoDisposeProvider<FakeRecipesRepository>.internal(
  recipesRepository,
  name: r'recipesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipesRepositoryRef = AutoDisposeProviderRef<FakeRecipesRepository>;
String _$recipesListStreamHash() => r'ecff26e0212e31e437373cad6a3653bc1f5571a7';

/// See also [recipesListStream].
@ProviderFor(recipesListStream)
final recipesListStreamProvider =
    AutoDisposeStreamProvider<List<Recipe>>.internal(
  recipesListStream,
  name: r'recipesListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipesListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipesListStreamRef = AutoDisposeStreamProviderRef<List<Recipe>>;
String _$recipesListFutureHash() => r'56255c8188b0583c5e13c9d0e380125f3483fd15';

/// See also [recipesListFuture].
@ProviderFor(recipesListFuture)
final recipesListFutureProvider =
    AutoDisposeFutureProvider<List<Recipe>>.internal(
  recipesListFuture,
  name: r'recipesListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipesListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipesListFutureRef = AutoDisposeFutureProviderRef<List<Recipe>>;
String _$recipeHash() => r'852906fd73e7d83f2ef715ac594f989db974f7e8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [recipe].
@ProviderFor(recipe)
const recipeProvider = RecipeFamily();

/// See also [recipe].
class RecipeFamily extends Family<AsyncValue<Recipe?>> {
  /// See also [recipe].
  const RecipeFamily();

  /// See also [recipe].
  RecipeProvider call(
    String id,
  ) {
    return RecipeProvider(
      id,
    );
  }

  @override
  RecipeProvider getProviderOverride(
    covariant RecipeProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeProvider';
}

/// See also [recipe].
class RecipeProvider extends AutoDisposeStreamProvider<Recipe?> {
  /// See also [recipe].
  RecipeProvider(
    String id,
  ) : this._internal(
          (ref) => recipe(
            ref as RecipeRef,
            id,
          ),
          from: recipeProvider,
          name: r'recipeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipeHash,
          dependencies: RecipeFamily._dependencies,
          allTransitiveDependencies: RecipeFamily._allTransitiveDependencies,
          id: id,
        );

  RecipeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Recipe?> Function(RecipeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecipeProvider._internal(
        (ref) => create(ref as RecipeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Recipe?> createElement() {
    return _RecipeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecipeRef on AutoDisposeStreamProviderRef<Recipe?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RecipeProviderElement extends AutoDisposeStreamProviderElement<Recipe?>
    with RecipeRef {
  _RecipeProviderElement(super.provider);

  @override
  String get id => (origin as RecipeProvider).id;
}

String _$recipesListSearchHash() => r'c5b884091827a021fbf61e60f68f6451138628c2';

/// See also [recipesListSearch].
@ProviderFor(recipesListSearch)
const recipesListSearchProvider = RecipesListSearchFamily();

/// See also [recipesListSearch].
class RecipesListSearchFamily extends Family<AsyncValue<List<Recipe>>> {
  /// See also [recipesListSearch].
  const RecipesListSearchFamily();

  /// See also [recipesListSearch].
  RecipesListSearchProvider call(
    String query,
  ) {
    return RecipesListSearchProvider(
      query,
    );
  }

  @override
  RecipesListSearchProvider getProviderOverride(
    covariant RecipesListSearchProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipesListSearchProvider';
}

/// See also [recipesListSearch].
class RecipesListSearchProvider
    extends AutoDisposeFutureProvider<List<Recipe>> {
  /// See also [recipesListSearch].
  RecipesListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => recipesListSearch(
            ref as RecipesListSearchRef,
            query,
          ),
          from: recipesListSearchProvider,
          name: r'recipesListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recipesListSearchHash,
          dependencies: RecipesListSearchFamily._dependencies,
          allTransitiveDependencies:
              RecipesListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  RecipesListSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Recipe>> Function(RecipesListSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecipesListSearchProvider._internal(
        (ref) => create(ref as RecipesListSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Recipe>> createElement() {
    return _RecipesListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipesListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecipesListSearchRef on AutoDisposeFutureProviderRef<List<Recipe>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _RecipesListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Recipe>>
    with RecipesListSearchRef {
  _RecipesListSearchProviderElement(super.provider);

  @override
  String get query => (origin as RecipesListSearchProvider).query;
}

String _$filteredRecipesFutureHash() =>
    r'cb84fda8e6c140313d1eea73918019beaa8d33a1';

/// See also [filteredRecipesFuture].
@ProviderFor(filteredRecipesFuture)
final filteredRecipesFutureProvider =
    AutoDisposeFutureProvider<List<Recipe>>.internal(
  filteredRecipesFuture,
  name: r'filteredRecipesFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredRecipesFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredRecipesFutureRef = AutoDisposeFutureProviderRef<List<Recipe>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
