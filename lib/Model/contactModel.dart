class PhoneNumb {
  String? name;
  String? phone;

  PhoneNumb({this.name, this.phone});

  PhoneNumb.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
      };
}
