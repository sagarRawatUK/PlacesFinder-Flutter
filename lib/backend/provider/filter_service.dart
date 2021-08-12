import 'package:flutter/cupertino.dart';

class FilterService with ChangeNotifier {
  int count = 0;
  String? query = "store";
  bool selectAll = false;
  List<bool> filters = [false, false, false];

  int get getFilterCount => count;
  String? get getQuery => query;
  bool get getSelectAll => selectAll;
  List<bool> get getFilters => filters;

  void setFilter(int index, bool value) {
    filters[index] = value;
    notifyListeners();
  }

  void selectAllBox(bool value) {
    selectAll = value;
    filters = [value, value, value];
    notifyListeners();
  }

  void clearAll() {
    selectAll = false;
    filters = [false, false, false];
    notifyListeners();
  }

  int getCount() {
    count = 0;
    for (int i = 0; i <= 2; i++) {
      if (filters[i]) count++;
    }
    notifyListeners();
    return count;
  }

  setQuery() {
    if (filters[0]) {
      query = "gym";
      notifyListeners();
    } else if (filters[1]) {
      query = "cafe";
      notifyListeners();
    } else if (filters[2]) {
      query = "restaurant";
      notifyListeners();
    } else if (filters[0] && filters[1] && filters[2])
      query = "stores";
    else
      query = "store";
    notifyListeners();
  }
}
