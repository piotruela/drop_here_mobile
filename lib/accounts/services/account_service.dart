import 'package:drop_here_mobile/accounts/model/account.dart';
import 'package:drop_here_mobile/accounts/model/company/create_profile_form.dart';

abstract class AccountsService {
  Future<int> createProfile(CreateProfileForm form);

  Future<Account> fetchAccountDetails();
}
