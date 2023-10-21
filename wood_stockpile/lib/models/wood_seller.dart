// To parse this JSON data, do
//
//     final woodSeller = woodSellerFromJson(jsonString);

class WoodSeller {
  String uid;
  String companyName;
  String email;
  String mobileNo;
  String certificate;
  String type;
  String verified;
  String address;
  double latitude;
  double longitude;
  List<String> images;
  WoodSeller(
      {required this.companyName,
      required this.email,
      required this.mobileNo,
      required this.certificate,
      required this.type,
      required this.verified,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.uid,
      required this.images});

  factory WoodSeller.fromJson(Map<String, dynamic> json) => WoodSeller(
      companyName: json["Company_name"],
      email: json["email"],
      mobileNo: json["Mobile_no"],
      certificate: json["certificate"],
      type: json["type"],
      verified: json["verified"],
      address: json["Address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      uid: json["uid"],
      images: json["company_images"]);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "Company_name": companyName,
        "email": email,
        "Mobile_no": mobileNo,
        "certificate": certificate,
        "type": type,
        "verified": verified,
        "Address": address,
        "latitude": latitude,
        "longitude": longitude,
        "images": images
      };
}
