import 'package:flutter/material.dart';

import 'model/contact_model.dart';
import 'repositories/contacts_repository.dart';
import 'repositories/login_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ContactModel>> contatoFuture;
  ContactsRepository _repository;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoginRepository().login();
    _repository = ContactsRepository();
    contatoFuture = _repository.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example DIO')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (_searchController.text.isEmpty) {
                        contatoFuture = _repository.findAll();
                      } else {
                        contatoFuture = _repository.findFiltred(
                            name: _searchController.text);
                      }
                    });
                  },
                  child: Text('Buscar'),
                ),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: contatoFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ContactModel>> snapshot) {
                print(snapshot.hasData);
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      var item = snapshot.data[index];
                      return ListTile(
                        title: Text(item.completeName),
                        subtitle: Text(item.phone),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
