class ContactModel {
  String completeName;
  String email;
  String phone;
  String facebook;

  ContactModel({
    this.completeName,
    this.email,
    this.phone,
    this.facebook,
  });

  static ContactModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ContactModel(
      completeName: map["complete_name"],
      email: map["email"],
      phone: map["phone"],
      facebook: map["facebook"],
    );
  }
}
