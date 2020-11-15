import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/routes/bloc/drop_details_bloc/drop_details_bloc.dart';
import 'package:flutter/material.dart';

class DropDetailsPage extends BlocWidget<DropDetailsBloc> {
  final String dropUid;

  DropDetailsPage({this.dropUid});

  @override
  DropDetailsBloc bloc() => DropDetailsBloc()..add(FetchDropDetails(dropUid: dropUid));
  @override
  Widget build(BuildContext context, DropDetailsBloc bloc, _) {
    return Scaffold();
  }
}
