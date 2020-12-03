import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/customer_management_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'client_details_registration_event.dart';
part 'client_details_registration_state.dart';

class ClientDetailsRegistrationBloc
    extends Bloc<ClientDetailRegistrationEvent, ClientDetailRegistrationState> {
  ClientDetailsRegistrationBloc()
      : super(ClientDetailRegistrationState(type: ClientDetailRegistrationStateType.initial));
  final AccountService accountService = Get.find<AccountService>();
  final CustomerManagementService customerManagementService = Get.find<CustomerManagementService>();
  @override
  Stream<ClientDetailRegistrationState> mapEventToState(
    ClientDetailRegistrationEvent event,
  ) async* {
    if (event is ChangeForm) {
      yield ClientDetailRegistrationState(
        type: ClientDetailRegistrationStateType.form_changed,
        firstName: event.firstName,
        lastName: event.lastName,
        photo: state.photo,
      );
    } else if (event is AddPhoto) {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      yield ClientDetailRegistrationState(
        type: ClientDetailRegistrationStateType.form_changed,
        firstName: state.firstName,
        lastName: state.lastName,
        photo: File(pickedFile.path),
      );
    } else if (event is SubmitForm) {
      print(state.firstName);
      void updateResponse = await customerManagementService.updateCustomerInfo(
          CustomerManagementRequest(firstName: state.firstName, lastName: state.lastName));
      void photoResponse = await customerManagementService.uploadCustomerPhoto(state.photo);
      Get.offAll(CustomerMapPage());
    }
  }
}
