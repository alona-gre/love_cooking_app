import 'package:love_cooking_app/src/features/recipes/presentation/recipes_list/recipes_search_state_provider.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Search field used to filter recipes by name
class RecipesSearchTextField extends ConsumerStatefulWidget {
  const RecipesSearchTextField({super.key});

  @override
  ConsumerState<RecipesSearchTextField> createState() =>
      _RecipesSearchTextFieldState();
}

class _RecipesSearchTextFieldState
    extends ConsumerState<RecipesSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            hintText: 'Search recipes'.hardcoded,
            icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      ref.read(recipesSearchQueryStateProvider.notifier).state =
                          '';
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (text) =>
              ref.read(recipesSearchQueryStateProvider.notifier).state = text,
        );
      },
    );
  }
}
