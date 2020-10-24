import 'dart:io';

import 'package:drop_here_mobile/accounts/bloc/countries_bloc.dart';
import 'package:drop_here_mobile/accounts/bloc/edit_company_details_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_switch.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:image_picker/image_picker.dart';

class EditCompanyDetailsPage extends BlocWidget<EditCompanyDetailsBloc> {
  final Company company;
  final Image companyImage;

  EditCompanyDetailsPage({this.company, this.companyImage});

  @override
  bloc() => EditCompanyDetailsBloc(company);

  @override
  Widget build(BuildContext context, EditCompanyDetailsBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  BlocBuilder<EditCompanyDetailsBloc, EditCompanyDetailsState>(
                    buildWhen: (previous, current) => previous.companyImage != current.companyImage,
                    builder: (context, state) => bloc.state.companyImage != null
                        ? FutureBuilder(
                            future: bloc.state.companyImage,
                            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                              return Conditional.single(
                                context: context,
                                conditionBuilder: (_) => snapshot.hasData,
                                widgetBuilder: (_) => SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: ClipOval(child: Image.file(snapshot.data))),
                                fallbackBuilder: (_) => SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: CircleAvatar(backgroundColor: Colors.black)),
                              );
                            })
                        : SizedBox(width: 150, height: 150, child: ClipOval(child: companyImage)),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RawMaterialButton(
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.camera_alt,
                        ),
                        shape: CircleBorder(),
                        onPressed: () => bloc.add(PhotoChanged(companyImage: getImage())),
                      ),
                    ),
                  )
                ],
              ),
              _companyNameField(localeBundle, bloc),
              labeledSwitch(
                  text: localeBundle.visible,
                  initialPosition:
                      bloc.state.request.visibility == describeEnum(VisibilityStatus.VISIBLE),
                  onSwitch: (visible) => bloc.add(FormChanged(
                      request: bloc.state.request.copyWith(
                          visibility: describeEnum(
                              visible ? VisibilityStatus.VISIBLE : VisibilityStatus.HIDDEN))))),
              BlocProvider(
                create: (BuildContext context) => CountriesBloc()..add(FetchCountries()),
                child: BlocBuilder<CountriesBloc, CountriesState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is CountriesFetchingSuccess) {
                      return BlocBuilder<EditCompanyDetailsBloc, EditCompanyDetailsState>(
                        buildWhen: (previousPageState, currentPageState) =>
                            previousPageState.request.countryName !=
                            currentPageState.request.countryName,
                        builder: (context, pageState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            secondaryTitle(localeBundle.country),
                            DropdownButton<String>(
                              hint: Text("Country"),
                              value: bloc.state.request.countryName,
                              isExpanded: true,
                              items: List<DropdownMenuItem<String>>.generate(
                                state?.countries?.length,
                                (int index) => DropdownMenuItem<String>(
                                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                                  value: state.countries.elementAt(index).name,
                                  child: Text(state.countries.elementAt(index).name),
                                ),
                              ),
                              onChanged: (String chosenCountry) => bloc.add(FormChanged(
                                  request:
                                      bloc.state.request.copyWith(countryName: chosenCountry))),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: SubmitFormButton(
                  isActive: true,
                  onTap: () => bloc.add(FormSubmitted(
                      request: bloc.state.request, companyImage: bloc.state.companyImage)),
                  text: "Submit",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyNameField(LocaleBundle locale, EditCompanyDetailsBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryTitle(locale.companyName),
        DhPlainTextFormField(
          inputType: InputType.text,
          hintText: locale.addSpotNameHint,
          initialValue: bloc.state.request.companyName,
          onChanged: (String name) =>
              bloc.add(FormChanged(request: bloc.state.request.copyWith(companyName: name))),
        ),
      ],
    );
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
