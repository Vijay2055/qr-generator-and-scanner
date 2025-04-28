import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/create_qr_model.dart';

class QrCreateNotifier extends StateNotifier<CreateQrModel> {
  QrCreateNotifier()
      : super(CreateQrModel(
          isFav: false,
          isSaved: false,
        ));
  void updateTitle(String title) {
    state = state.copyWith(title: title);
    print(state.isSaved);
  }

  void updateId(int id, bool isSave) {
    state = state.copyWith(id: id, isSave: isSave);
    
  }

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateIsFav(bool isFav) {
    state = state.copyWith(isFav: isFav);
  }

  void updateIsSave(bool isSave) {
    state = state.copyWith(isSave: isSave);
  }

  void reset() {
    state = CreateQrModel(
      isFav: false,
      isSaved: false,
      title: null,
      content: null,
      id: null,
    );
  }
}

final qrProvider =
    StateNotifierProvider<QrCreateNotifier, CreateQrModel>((ref) {
  return QrCreateNotifier();
});
