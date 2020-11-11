import 'package:drop_here_mobile/accounts/bloc/choose_seller_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class ChooseSellerPage extends BlocWidget<ChooseSellerBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final VoidCallback addSeller;
  final String selectedProfileUid;

  ChooseSellerPage({this.addSeller, this.selectedProfileUid});

  @override
  ChooseSellerBloc bloc() => ChooseSellerBloc()..add(InitializePage(selectedSellerUid: selectedProfileUid));

  @override
  Widget build(BuildContext context, ChooseSellerBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocBuilder<ChooseSellerBloc, ChooseSellerState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => Conditional.single(
              context: context,
              conditionBuilder: (_) => bloc.state.type != ChooseSellerStateType.loading,
              widgetBuilder: (_) => _buildContent(localeBundle, bloc),
              fallbackBuilder: (_) => Center(child: CircularProgressIndicator())),
        ),
        floatingActionButton: BlocBuilder<ChooseSellerBloc, ChooseSellerState>(
          buildWhen: (previous, current) => previous.selectedProfileUid != current.selectedProfileUid,
          builder: (context, state) => Align(
            child: SubmitFormButton(
                isActive: state.selectedProfileUid != null,
                text: localeBundle.submit,
                onTap: () => Get.back(
                    result: bloc.state.sellers
                        .firstWhere((element) => element.profileUid == bloc.state.selectedProfileUid,
                            orElse: () => null)
                        ?.profileUid)),
          ),
        ));
  }

  Widget _buildContent(LocaleBundle localeBundle, ChooseSellerBloc bloc) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DhBackButton(padding: EdgeInsets.zero, backAction: () => Get.back(result: bloc.state.selectedProfileUid)),
            Text(
              localeBundle.chooseSeller,
              style: themeConfig.textStyles.primaryTitle,
            ),
            for (ProfileInfoResponse profile in bloc.state.sellers ?? [])
              SellerCard(
                  title: profile.fullName,
                  onTap: () => bloc.add(ChooseSeller(sellerUid: profile.profileUid)),
                  selected: bloc.state.selectedProfileUid == profile.profileUid)
          ],
        ),
      ),
    );
  }
}
