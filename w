import 'package:crm_common_core/bloc/login_bloc.dart';
import 'package:crm_common_core/bloc/session_bloc.dart';
import 'package:crm_common_core/config/app_config.dart';
import 'package:crm_common_core/config/assets_config.dart';
import 'package:crm_common_core/config/theme_config.dart';
import 'package:crm_common_core/i18n/locale_bundle.dart';
import 'package:crm_common_core/i18n/localization.dart';
import 'package:crm_common_core/locator.dart';
import 'package:crm_common_core/ui/widgets/bloc_widget.dart';
import 'package:crm_common_core/ui/widgets/conditional_widget.dart';
import 'package:crm_common_core/ui/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends BlocWidget<LoginBloc> {
  final String username;
  final String password;
  final ThemeData themeData = locator.get<ThemeConfig>().primaryTheme();
  final AssetsConfig assetsConfig = locator.get<AssetsConfig>();

  LoginPage({this.username, this.password});

  @override
  LoginBloc bloc() => LoginBloc(username: username, password: password);

  @override
  Widget build(BuildContext context, LoginBloc bloc, BlocWidgetState<LoginBloc> widgetState) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Theme(
        data: themeData,
        child: Scaffold(
            body: BlocConsumer<SessionBloc, SessionState>(
                bloc: BlocProvider.of<SessionBloc>(context),
                listener: (context, state) {
                  if (state == SessionState.authenticated) {
                    pageNavigator.push(locator.getDefaultModule().homeRoute);
                  } else if (state == SessionState.error) {
                    snackBarController.showError(localeBundle.loginError);
                  }
                },
                builder: (context, state) => _buildView(context, bloc, state))));
  }

  Widget _buildView(BuildContext context, LoginBloc loginBloc, SessionState state) => LoadingView(
        transparentBarrier: false,
        isLoading: state == SessionState.authentication_in_progress,
        child: _buildLoginForm(context, loginBloc, state),
      );

  Widget _buildLoginForm(BuildContext context, LoginBloc bloc, SessionState sessionState) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    final double pageHeight = MediaQuery.of(context).size.height;
    final double pageWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: themeData.primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            height: pageHeight,
            width: pageWidth,
            decoration: BoxDecoration(
                color: themeData.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: SingleChildScrollView(
              child: Container(
                height: pageHeight - 24.0,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(localeBundle.companyName, style: themeData.textTheme.button),
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Container(
                      key: Key('loginImage'),
                      child: assetsConfig.helloImage,
                    ),
                    Expanded(child: SizedBox.shrink()),
                    LoginTextField(
                        label: localeBundle.loginEmail,
                        initialValue: bloc.state.credentials.username,
                        onTextChanged: (text) =>
                            bloc.add(CredentialsChanged(credentials: bloc.state.credentials.copyWith(username: text))),
                        isError: sessionState == SessionState.bad_credentials),
                    PasswordFormField(
                      initialValue: bloc.state.credentials.password,
                      label: localeBundle.loginPassword,
                      isError: sessionState == SessionState.bad_credentials,
                      onTextChanged: (text) =>
                          bloc.add(CredentialsChanged(credentials: bloc.state.credentials.copyWith(password: text))),
                    ),
                    _buildErrorInfo(localeBundle, sessionState),
                    BlocBuilder<LoginBloc, LoginFormState>(
                      buildWhen: (previous, current) => previous.credentials != current.credentials,
                      builder: (context, state) =>
                          LogInButton(loginBloc: bloc, isActive: state.credentials.isFormFilled),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Align(alignment: Alignment.bottomCenter, child: _buildFooter(context))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorInfo(LocaleBundle localeBundle, SessionState sessionState) {
    return ConditionalWidget(
      condition: sessionState == SessionState.bad_credentials,
      child: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: themeData.errorColor,
              size: 16.0,
            ),
            Text(
              localeBundle.badCredentialsText,
              style: themeData.textTheme.bodyText2.copyWith(color: themeData.errorColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    final AppConfig _appConfig = locator.get<AppConfig>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: localeBundle.problemWithLogingQuestion,
              style: themeData.textTheme.bodyText2.copyWith(color: Colors.black),
            ),
            WidgetSpan(
              child: GestureDetector(
                  child: Text(
                    localeBundle.contactUs,
                    style: themeData.textTheme.button,
                  ),
                  onTap: () => launch("mailto:${_appConfig.supportMail}")),
            ),
          ],
        ),
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  final LoginBloc loginBloc;
  final bool isActive;
  final ThemeData themeData = locator.get<ThemeConfig>().primaryTheme();

  LogInButton({this.loginBloc, this.isActive});

  @override
  Widget build(BuildContext context) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: SizedBox(
        width: 160.0,
        child: RaisedButton(
          child: Text(localeBundle.loginButtonText,
              style: themeData.textTheme.button
                  .copyWith(color: isActive ? themeData.accentColor : themeData.disabledColor)),
          onPressed: isActive ? () => loginAction(context) : null,
        ),
      ),
    );
  }

  VoidCallback loginAction(BuildContext context) {
    FocusScope.of(context).unfocus();
    BlocProvider.of<SessionBloc>(context).add(AuthenticateUserEvent(loginBloc.state.credentials));
    return null;
  }
}

typedef OnTextChanged = Function(String);

class LoginTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final OnTextChanged onTextChanged;
  final bool obscureText;
  final bool isError;
  final Widget suffixIcon;
  final ThemeData themeData = locator.get<ThemeConfig>().primaryTheme();

  LoginTextField(
      {this.label,
      this.initialValue,
      this.onTextChanged,
      this.obscureText = false,
      this.isError = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 23.0, right: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        cursorWidth: 1.0,
        cursorColor: isError ? themeData.errorColor : themeData.primaryColor,
        onChanged: (String value) {
          onTextChanged?.call(value);
        },
        obscureText: obscureText,
        decoration: isError ? _errorDecoration() : _defaultDecoration(),
      ),
    );
  }

  InputDecoration _errorDecoration() {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        suffixIcon: suffixIcon,
        focusedBorder: _errorBorder,
        enabledBorder: _errorBorder,
        border: _errorBorder,
        labelStyle: themeData.textTheme.caption.copyWith(color: themeData.errorColor));
  }

  InputDecoration _defaultDecoration() {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      suffixIcon: suffixIcon,
      labelText: label,
      border: OutlineInputBorder(borderSide: BorderSide(color: themeData.primaryColor)),
    );
  }

  OutlineInputBorder get _errorBorder =>
      OutlineInputBorder(borderSide: BorderSide(width: 2, color: themeData.errorColor));
}

class PasswordFormField extends StatefulWidget {
  final OnTextChanged onTextChanged;
  final String label;
  final String initialValue;
  final bool isError;

  const PasswordFormField({this.onTextChanged, this.label, this.initialValue, this.isError = false});

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  final ThemeData themeData = locator.get<ThemeConfig>().primaryTheme();

  @override
  Widget build(BuildContext context) {
    return LoginTextField(
      label: widget.label,
      initialValue: widget.initialValue,
      isError: widget.isError,
      obscureText: _obscureText,
      onTextChanged: (String value) {
        widget.onTextChanged?.call(value);
      },
      suffixIcon: GestureDetector(
        onTap: () => setState(() {
          _obscureText = !_obscureText;
        }),
        child: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: widget.isError ? themeData.errorColor : null,
        ),
      ),
    );
  }
}
