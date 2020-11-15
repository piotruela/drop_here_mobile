part of 'edit_company_details_bloc.dart';

class EditCompanyDetailsState extends Equatable {
  final CompanyManagementRequest request;
  final Future<File> companyImage;
  const EditCompanyDetailsState({
    this.request,
    this.companyImage,
  });

  EditCompanyDetailsState copyWith({
    final CompanyManagementRequest request,
    final Future<File> companyImage,
  }) {
    return EditCompanyDetailsState(
        request: request ?? this.request, companyImage: companyImage ?? this.companyImage);
  }

  @override
  List<Object> get props => [request, companyImage];
}
