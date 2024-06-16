/// A filter along with a bool value that can be set by user
class FilterItem {
  const FilterItem({
    required this.filterName,
    required this.isEnabled,
  });
  final String filterName;
  final bool isEnabled;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterItem &&
        other.filterName == filterName &&
        other.isEnabled == isEnabled;
  }

  @override
  int get hashCode => filterName.hashCode ^ isEnabled.hashCode;
}
