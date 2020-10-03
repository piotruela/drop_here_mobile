import 'package:drop_here_mobile/accounts/model/client.dart';

abstract class ClientsListService {
  Future<List<Client>> fetchClientsList();
}

class FakeClientsListService implements ClientsListService {
  @override
  Future<List<Client>> fetchClientsList() {
    List<Client> clients = [Client(name: 'abc'), Client(name: 'def')];
    return Future.delayed(Duration(seconds: 1), () {
      return clients;
    });
  }
}
