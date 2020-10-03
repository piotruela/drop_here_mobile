import 'package:drop_here_mobile/accounts/model/client.dart';

abstract class ClientsListService {
  Future<List<Client>> fetchClientsList();
}

class FakeClientsListService implements ClientsListService {
  @override
  Future<List<Client>> fetchClientsList() {
    List<Client> clients = [
      Client(name: 'abc', isActive: true, numberOfDropsMember: 5),
      Client(name: 'def', isActive: false, numberOfDropsMember: 3)
    ];
    return Future.delayed(Duration(seconds: 1), () {
      return clients;
    });
  }
}
