import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/shipments/bloc/customer_shipment_bloc/customer_shipment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageShipmentPage extends BlocWidget<CustomerShipmentBloc> {
  final String dropUid;

  ManageShipmentPage({this.dropUid});

  @override
  CustomerShipmentBloc bloc() => CustomerShipmentBloc();

  @override
  Widget build(BuildContext context, CustomerShipmentBloc bloc, _) {
    return Scaffold(
      body: BlocBuilder<CustomerShipmentBloc, CustomerShipmentState>(

      ),
    );
  }
}
