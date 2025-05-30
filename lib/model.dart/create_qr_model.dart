class CreateQrModel {
  final String? title;
  final bool? isFav;
  final bool? isSaved;
  final String? content;
  final int? id;

  CreateQrModel({this.title, this.isFav, this.isSaved, this.content, this.id});

  CreateQrModel copyWith(
      {bool? isFav, bool? isSave, String? title, String? content, int? id}) {
    return CreateQrModel(
        title: title ?? this.title,
        isFav: isFav ?? this.isFav,
        isSaved: isSave ?? isSaved,
        id: id ?? this.id,
        content: content ?? this.content);
  }
}
