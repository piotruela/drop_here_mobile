import 'package:drop_here_mobile/accounts/model/client.dart';

abstract class ClientsListService {
  //TODO change filter?
  Future<List<Client>> fetchClientsList({String filter, String searchText});
}

class FakeClientsListService implements ClientsListService {
  @override
  Future<List<Client>> fetchClientsList({String filter, String searchText}) {
    List<Client> clients = [
      Client(name: 'abc', isActive: true, numberOfDropsMember: 5),
      Client(name: 'def', isActive: false, numberOfDropsMember: 3)
    ];
    return Future.delayed(Duration(seconds: 1), () {
      return clients;
    });
  }
}
