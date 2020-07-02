import 'package:flutter_contacts/model/contact_model.dart';
import 'package:flutter_contacts/utils/custom_dio.dart';

class ContactsRepository {
  Future<List<ContactModel>> findAll() {
    var dio = CustomDio.withAuthentication().instance;
    return dio.get("http://10.0.0.109:3000/contacts").then((res) {
      print("data in contacts repository: ${res.data}");
      return res.data.map<ContactModel>((c) => ContactModel.fromMap(c)).toList()
          as List<ContactModel>;
    }).catchError((onError) => print(onError));
  }

  Future<List<ContactModel>> findFiltred({String name}) {
    var dio = CustomDio.withAuthentication().instance;
    return dio
        .get("http://10.0.0.109:3000/contacts/filter?name=$name")
        .then((res) {
      return res.data.map<ContactModel>((c) => ContactModel.fromMap(c)).toList()
          as List<ContactModel>;
    }).catchError((onError) => print(onError));
  }
}
