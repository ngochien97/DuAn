import '../PresentationModel.dart';
import 'PresentationProvider.dart';

class PresentationHistoryProvider extends PresentationProvider {
  static const pageSize = 4;

  @override
  Future<PresentationModel> loadData() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    historyPageId = 1;
    final data = await presentDA
        .getHistoryPresentationActiveByClassId(classId, pageId, pageSize, [3]);
    isLoading = false;
    if (data.code == 200) {
      presents = data.presents;
    }
    notifyListeners();
    return data;
  }

  @override
  Future<PresentationModel> loadMoreData() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    pageId += 1;
    final data = await presentDA
        .getPresentationActiveByClassId(classId, pageId, pageSize, [3]);
    isLoading = false;
    if (data.code == 200) {
      if (data.presents.isEmpty) {
        pageId -= 1;
        return data;
      }
      presents.addAll(data.presents);
      notifyListeners();
    } else {
      historyPageId -= 1;
    }

    return data;
  }
}
