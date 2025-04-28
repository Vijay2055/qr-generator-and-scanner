import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:qr_scanner/providers/database_provider.dart';

class ScanState extends StateNotifier<List<ScanHistoryModel>> {
  ScanState(this.ref) : super(const []) {
    loadScans();
  }

  final Ref ref;

  Future<void> loadScans() async {
    final db = ref.read(databaseProvider);
    state = await db.getHistory();
  }

  Future<int> insertData(
    String content,
    String image,
    String time,
  ) async {
    ScanHistoryModel scanHistory = ScanHistoryModel(
      time: time,
      content: content,
      isFav: false,
      title: '',
      image: image,
    );

    final db = ref.read(databaseProvider);
    int id = await db.insertScan(scanHistory);
    loadScans();
    return id;
  }

  Future<ScanHistoryModel?> getSingleData(int id) async {
    final db = ref.read(databaseProvider);
    return await db.getSingleHistory(id);
  }

  Future<void> updateCont(int id, String cont, String path) async {
    final db = ref.read(databaseProvider);
    await db.updateContent(id, cont, path);
    loadScans();
  }

  Future<void> updateTitle(int id, String title) async {
    final db = ref.read(databaseProvider);
    final isUpdated = await db.updateTitle(id, title);
    if (isUpdated == true) {
      state = [
        for (final scanData in state)
          if (scanData.id == id) scanData.copyWith(title: title) else scanData
      ];
    }
  }

  Future<void> updateFav(int id, bool isFav) async {
    final db = ref.read(databaseProvider);
    await db.updateFav(id, isFav);
    loadScans();
  }

  Future<int> deleteQR(int id) async {
    final db = ref.read(databaseProvider);
    final count = await db.deleteQr(id);
    if (count > 0) {
      loadScans();
    }
    return count;
  }
}

final scanHistoryProvider =
    StateNotifierProvider<ScanState, List<ScanHistoryModel>>(
        (ref) => ScanState(ref));
