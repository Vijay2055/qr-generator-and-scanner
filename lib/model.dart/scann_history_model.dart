enum Category {
  url,
  text,
  wifi,
  barcode,
  phone,
  contact,
  email,
  sms,
  geo,

  ean_8,
  ean_13,
  upc_e,
  upc_a,
  code_39,
  code_93,
  code_128,
  itf,
  pdf_417,
  codebar,
  data_matrix,
  aztec
}

class ScanHistoryModel {
  ScanHistoryModel({
    this.id,
    required this.time,
    this.isFav = false,
    required this.content,
    required this.image,
    this.title = '',
  }) : category = _detectCategory(content);

  final int? id;
  final String time;
  final bool isFav;
  final String content;
  final String image;
  final String title;
  final Category category;


  // convert object to Map for database storage

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'title': title,
      'isFav': isFav ? 1 : 0,
      'content': content,
      'image': image,
      'category': category.index
    };
  }

  // convert map to scanHistory object

  factory ScanHistoryModel.fromMap(Map<String, dynamic> map) {
    return ScanHistoryModel(
      id: map['id'],
      time: map['time'],
      title: map['title'] ?? '',
      isFav: map['isFav'] == 1,
      content: map['content'],
      image: map['image'],
    );
  }

  static Category _detectCategory(String result) {
    if (_isWiFi(result)) {
      return Category.wifi;
    } else if (_isURL(result)) {
      return Category.url;
    } else if (_isPhoneNumber(result)) {
      return Category.phone;
    } else if (_isEmail(result)) {
      return Category.email;
    } else if (_isBarcode(result)) {
      return Category.barcode;
    } else {
      return Category.text;
    }
  }

  ScanHistoryModel copyWith({
    int? id,
    String? time,
    bool? isFav,
    String? content,
    String? image,
    String? title,
    Category? category,
  }) {
    return ScanHistoryModel(
        id: id ?? this.id,
        time: time ?? this.time,
        content: content ?? this.content,
        image: image ?? this.image,
        title: title ?? this.title,
        isFav: isFav ?? this.isFav);
  }

  static bool _isWiFi(String text) {
    final wifiRegExp = RegExp(
      r'^WIFI:(?:S:([^;]+);)?(?:T:([^;]+);)?(?:P:([^;]*);)?(?:H:(true|false);)?;',
      caseSensitive: false,
    );

    return wifiRegExp.hasMatch(text);
  }

  static bool _isURL(String text) {
    final urlRegExp = RegExp(r'^(https?|ftp|file|upi):\/\/[^\s/$.?#].[^\s]*$',
        caseSensitive: false);
    return urlRegExp.hasMatch(text);
  }

  static bool _isPhoneNumber(String text) {
    final phoneRegExp = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegExp.hasMatch(text);
  }

  static bool _isEmail(String text) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(text);
  }

  static bool _isBarcode(String text) {
    // Example for numeric barcode; expand as needed.
    return RegExp(r'^\d{12,13}$').hasMatch(text);
  }
}
