
import 'package:flutter/cupertino.dart';
import 'package:libary_anainfo/home_page/Food1.dart';

class BookmarkBloc extends ChangeNotifier {
  int _count = 0;
  List<Food1> items = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void addItems(Food1 data) {
    items.add(data);
    notifyListeners();
  }

  int get count {
    return _count;
  }

  List<Food1> get itemsList {
    return items;
  }
}