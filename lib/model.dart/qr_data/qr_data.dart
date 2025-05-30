import 'package:flutter/material.dart';

abstract class QrData {
  String getData();
  Map<String, String> toMap();
  bool get isBarcode;
}

// class for wifi data
class WifiData implements QrData {
  final String ssid;
  final String password;
  final String encryption;

  const WifiData(
      {required this.ssid, required this.password, required this.encryption});
  @override
  String getData() {
    return 'WIFI:S:$ssid;T:$encryption;P:$password;;';
  }

  @override
  Map<String, String> toMap() {
    return {
      'SSID': ssid,
      'PASSWORD': password,
      'ENCRYPTION': encryption,
    };
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

//class for phone

class Phone implements QrData {
  final phone;

  const Phone({required this.phone});

  @override
  String getData() {
    return 'Phone: $phone';
  }

  @override
  Map<String, String> toMap() {
    return {'Phone': phone};
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

// class for sms
class SmsData implements QrData {
  final String number;
  final String message;

  const SmsData({required this.number, required this.message});

  @override
  String getData() {
    return 'SMSTO:$number:\nMessage:$message';
  }

  @override
  Map<String, String> toMap() {
    return {
      'Phone': number,
      'Message': message,
    };
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

class EmailData implements QrData {
  final String to;
  final String subject;
  final String body;

  const EmailData(
      {required this.to, required this.subject, required this.body});

  @override
  String getData() {
    return 'MATMSG:TO:$to;SUB:$subject;BODY:$body;;';
  }

  @override
  Map<String, String> toMap() {
    return {'To': to, 'Subject': subject, 'Body': body};
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

// for url
class UrlData implements QrData {
  final String url;

  const UrlData({required this.url});

  @override
  String getData() {
    return 'URL:$url';
  }

  @override
  Map<String, String> toMap() {
    return {'Url': url};
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

// for text
class TextData implements QrData {
  final String text;

  const TextData({required this.text});

  @override
  String getData() {
    return 'TEXT:$text';
  }

  @override
  Map<String, String> toMap() {
    return {'Text': text};
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

class ContactData implements QrData {
  final String name;
  final String phone;
  final String email;
  final String org;
  final String address;
  final String note;

  const ContactData({
    required this.name,
    required this.phone,
    required this.email,
    required this.org,
    required this.address,
    required this.note,
  });

  @override
  String getData() {
    return 'BEGIN:VCARD\nVERSION:3.0\nFN:$name\nTEL:$phone\nEMAIL:$email\nOrg:$org\nADR:$address\nNOTE:$note\nEND:VCARD';
  }

  @override
  Map<String, String> toMap() {
    return {
      "Name": name,
      "Phone": phone,
      "Email": email,
      "Organization": org,
      'Address': address,
      "Notes": note,
    };
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

class GeoData implements QrData {
  final double latitude;
  final double longitude;
  final String? query; // Optional query parameter

  const GeoData({
    required this.latitude,
    required this.longitude,
    this.query,
  });

  @override
  String getData() {
    if (query != null && query!.isNotEmpty) {
      // If query is provided, append it to the Geo URL
      return 'GEO:$latitude,$longitude?q=$query';
    } else {
      // Otherwise, just return the basic GEO data
      return 'GEO:$latitude,$longitude';
    }
  }

  @override
  Map<String, String> toMap() {
    return {
      "Latitude": latitude.toString(),
      "Longitude": longitude.toString(),
      'Query': query ?? ''
    };
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => false;
}

abstract class BarcodeGeneratorType extends QrData {
  String get barcodeType;
}

class Ean8 implements BarcodeGeneratorType {
  final String ean8;

  const Ean8({required this.ean8});
  @override
  String getData() {
    final checksum = _convertEan8(ean8);
    return '$ean8$checksum';
  }

  int _convertEan8(String input) {
    int sum = 0;
    for (int i = 0; i < 7; i++) {
      int digit = int.parse(input[i]);

      if ((i + 1) % 2 == 1) {
        sum += digit * 3;
      } else {
        sum += digit;
      }
    }
    int nextMultiple10 = ((sum + 9) ~/ 10) * 10;
    int checkDigit = nextMultiple10 - sum;
    return checkDigit % 10;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Ean_8': ean8};
  }

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'ean8';
}

class Ean13 implements BarcodeGeneratorType {
  final String ean13;

  const Ean13({required this.ean13});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'ean13';

  @override
  String getData() {
    return ean13;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Ean_13': ean13};
  }
}

class Upce implements BarcodeGeneratorType {
  final String upce;
  const Upce({required this.upce});
  @override
  // TODO: implement barcodeType
  String get barcodeType => 'upce';

  @override
  String getData() {
    return upce;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Upc_e': upce};
  }
}

class Upca implements BarcodeGeneratorType {
  final String upca;
  const Upca({required this.upca});
  @override
  // TODO: implement barcodeType
  String get barcodeType => 'upca';

  @override
  String getData() {
    return upca;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {"Upc_a": upca};
  }
}

class Code39 implements BarcodeGeneratorType {
  final String code39;
  const Code39({required this.code39});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'code39';

  @override
  String getData() {
    // TODO: implement getData
    final ans = toExtendedCode39(code39);
    return ans;
  }

  String toExtendedCode39(String input) {
    const extCode39Map = {
      '\x00': '%U',
      '!': '/A',
      '"': '/B',
      '#': '/C',
      '\$': '/D',
      '%': '/E',
      '&': '/F',
      '\'': '/G',
      '(': '/H',
      ')': '/I',
      '*': '/J',
      '+': '/K',
      ',': '/L',
      '-': '-',
      '.': '.',
      '/': '/',
      '0': '0',
      '1': '1',
      '2': '2',
      '3': '3',
      '4': '4',
      '5': '5',
      '6': '6',
      '7': '7',
      '8': '8',
      '9': '9',
      ':': '/Z',
      ';': '%F',
      '<': '%G',
      '=': '%H',
      '>': '%I',
      '?': '%J',
      '@': '%V',
      'A': 'A',
      'B': 'B',
      'C': 'C',
      'D': 'D',
      'E': 'E',
      'F': 'F',
      'G': 'G',
      'H': 'H',
      'I': 'I',
      'J': 'J',
      'K': 'K',
      'L': 'L',
      'M': 'M',
      'N': 'N',
      'O': 'O',
      'P': 'P',
      'Q': 'Q',
      'R': 'R',
      'S': 'S',
      'T': 'T',
      'U': 'U',
      'V': 'V',
      'W': 'W',
      'X': 'X',
      'Y': 'Y',
      'Z': 'Z',
      '[': '%K',
      '\\': '%L',
      ']': '%M',
      '^': '%N',
      '_': '%O',
      '`': '%W',
      'a': '+A',
      'b': '+B',
      'c': '+C',
      'd': '+D',
      'e': '+E',
      'f': '+F',
      'g': '+G',
      'h': '+H',
      'i': '+I',
      'j': '+J',
      'k': '+K',
      'l': '+L',
      'm': '+M',
      'n': '+N',
      'o': '+O',
      'p': '+P',
      'q': '+Q',
      'r': '+R',
      's': '+S',
      't': '+T',
      'u': '+U',
      'v': '+V',
      'w': '+W',
      'x': '+X',
      'y': '+Y',
      'z': '+Z',
      '{': '%P',
      '|': '%Q',
      '}': '%R',
      '~': '%S',
      '\x7f': '%T',
      ' ': ' ',
    };

    final buffer = StringBuffer();

    for (final char in input.characters) {
      if (extCode39Map.containsKey(char)) {
        buffer.write(extCode39Map[char]);
      } else {
        throw FormatException(
            'Character not supported in Extended Code 39: "$char"');
      }
    }

    return buffer.toString();
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    // TODO: implement toMap
    return {"Code_39": code39};
  }
}

class Code93 implements BarcodeGeneratorType {
  final String code93;
  const Code93({required this.code93});

  String toExtendedCode93(String input) {
    const extCode93Map = {
      // Standard chars
      '0': '0', '1': '1', '2': '2', '3': '3', '4': '4',
      '5': '5', '6': '6', '7': '7', '8': '8', '9': '9',
      'A': 'A', 'B': 'B', 'C': 'C', 'D': 'D', 'E': 'E',
      'F': 'F', 'G': 'G', 'H': 'H', 'I': 'I', 'J': 'J',
      'K': 'K', 'L': 'L', 'M': 'M', 'N': 'N', 'O': 'O',
      'P': 'P', 'Q': 'Q', 'R': 'R', 'S': 'S', 'T': 'T',
      'U': 'U', 'V': 'V', 'W': 'W', 'X': 'X', 'Y': 'Y', 'Z': 'Z',
      '-': '-', '.': '.', ' ': ' ', '\$': '\$', '/': '/', '+': '+', '%': '%',
     

      // Extended encoding
      'a': '+A', 'b': '+B', 'c': '+C', 'd': '+D', 'e': '+E', 'f': '+F',
      'g': '+G', 'h': '+H', 'i': '+I', 'j': '+J', 'k': '+K', 'l': '+L',
      'm': '+M', 'n': '+N', 'o': '+O', 'p': '+P', 'q': '+Q', 'r': '+R',
      's': '+S', 't': '+T', 'u': '+U', 'v': '+V', 'w': '+W', 'x': '+X',
      'y': '+Y', 'z': '+Z',
    };

    final buffer = StringBuffer();

    for (final char in input.split('')) {
      if (extCode93Map.containsKey(char)) {
        buffer.write(extCode93Map[char]);
      } else {
        throw FormatException(
            'Character "$char" not supported in Extended Code 93');
      }
    }

    return buffer.toString();
  }

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'code93';

  @override
  String getData() {
    
    return toExtendedCode93(code93);
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Code_93': code93};
  }
}

class Code128 implements BarcodeGeneratorType {
  final String code128;
  const Code128({required this.code128});
  @override
  // TODO: implement barcodeType
  String get barcodeType => 'code128';

  @override
  String getData() {
    return code128;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Code_128': code128};
  }
}

class Itf implements BarcodeGeneratorType {
  final String itf;
  const Itf({required this.itf});
  @override
  // TODO: implement barcodeType
  String get barcodeType => 'itf';

  @override
  String getData() {
    return itf;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Itf': itf};
  }
}

class Pdf417 implements BarcodeGeneratorType {
  final String pdf417;
  const Pdf417({required this.pdf417});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'pdf417';

  @override
  String getData() {
    return pdf417;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Pdf_417': pdf417};
  }
}

class Codebar implements BarcodeGeneratorType {
  final String codebar;

  const Codebar({required this.codebar});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'codebar';

  @override
  String getData() {
    return codebar;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Codebar': codebar};
  }
}

class DataMatrix implements BarcodeGeneratorType {
  final String code;
  DataMatrix({required this.code});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'datamatrix';

  @override
  String getData() {
    return code;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {"Data_Matrix": code};
  }
}

class Aztec implements BarcodeGeneratorType {
  final String code;
  const Aztec({required this.code});

  @override
  // TODO: implement barcodeType
  String get barcodeType => 'aztec';

  @override
  String getData() {
    return code;
  }

  @override
  // TODO: implement isBarcode
  bool get isBarcode => true;

  @override
  Map<String, String> toMap() {
    return {'Aztec': code};
  }
}
