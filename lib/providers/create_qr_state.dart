import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:qr_scanner/providers/scan_state.dart';

class CreateQrState extends StateNotifier<ScanHistoryModel> {
  CreateQrState(this.ref)
      : super(ScanHistoryModel(time: '', content: '', image: ''));

  final ref;
  void setData(ScanHistoryModel data) {
    state = data;
  }

  int? get qrId {
    if (state.id != null) {
      return state.id;
    }
    return null;
  }

  void updateId(int? id) {
    state = state.copyWith(id: id);
  }

  void updateFav(int id, bool isFav) async {
    await ref.read(scanHistoryProvider.notifier).updateFav(id, isFav);
    state = state.copyWith(isFav: isFav);
  }

  void updateTitle(String title) {
    // ref.read(scanHistoryProvider.notifier).updateTitle(id,title);
    state = state.copyWith(title: title);
  }
}

final createQrProvider =
    StateNotifierProvider<CreateQrState, ScanHistoryModel>((ref) {
  return CreateQrState(ref);
});
