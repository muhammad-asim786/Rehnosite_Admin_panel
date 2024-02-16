import 'package:rhinoapp/Model/base_model.dart';
import 'package:rhinoapp/service/firebase_database.dart';

class BookServiceViewModel extends BaseViewModal {
  final databaseService = DatabaseService();

   Map<String, bool> selectedMap = {};
  // selectedData which contains
  void selectData(String id) {
    if (selectedMap.containsKey(id)) {
      selectedMap.remove(id);
      selectedMap.clear();
    } else {
      selectedMap.clear();
      selectedMap[id] = true;
    }
    notifyListeners();
  }

  void clearSelectedData() {
    selectedMap.clear();
    notifyListeners();
  }

}
