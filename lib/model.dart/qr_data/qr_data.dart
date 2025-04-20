abstract class QrData {
  String getData();
  Map<String, String> toMap();
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
}

// class for sms
class SmsData implements QrData {
  final String number;
  final String message;

  SmsData({required this.number, required this.message});

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
}

class EmailData implements QrData {
  final String to;
  final String subject;
  final String body;

  EmailData({required this.to, required this.subject, required this.body});

  @override
  String getData() {
    return 'MATMSG:TO:$to;SUB:$subject;BODY:$body;;';
  }

  @override
  Map<String, String> toMap() {
    return {'To': to, 'Subject': subject, 'Body': body};
  }
}

// for url
class UrlData implements QrData {
  final String url;

  UrlData({required this.url});

  @override
  String getData() {
    return 'URL:$url';
  }

  @override
  Map<String, String> toMap() {
    return {'Url': url};
  }
}

// for text
class TextData implements QrData {
  final String text;

  TextData({required this.text});

  @override
  String getData() {
    return 'TEXT:$text';
  }

  @override
  Map<String, String> toMap() {
    return {'Text': text};
  }
}

class ContactData implements QrData {
  final String name;
  final String phone;
  final String email;
  final String org;
  final String address;
  final String note;

  ContactData({
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
}

class GeoData implements QrData {
  final double latitude;
  final double longitude;
  final String? query; // Optional query parameter

  GeoData({
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
}
