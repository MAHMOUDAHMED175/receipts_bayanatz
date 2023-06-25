import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipts_bayanatz/core/widgets/custom_app_par.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_state.dart';

class DevicesPrinter extends StatefulWidget {
  const DevicesPrinter({super.key});

  // final List<Map<String, dynamic>> data;
  // DevicesPrinter(this.data);

  @override
  _DevicesPrinterState createState() => _DevicesPrinterState();
}

class _DevicesPrinterState extends State<DevicesPrinter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {ReceiptCubit.get(context).initPrinter()});
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ReceiptCubit.get(context);
    return BlocConsumer<ReceiptCubit, ReceiptState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(textAppBar: 'Devices', elevationAppBar: 10, showenCenterText: true, actionsAppBar: [])),
          body: cubit.devices.isEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text('turn on Bluetooth \n${cubit.devicesMsg}',textAlign: TextAlign.center,)),
                    const CircularProgressIndicator(strokeWidth: 6),
                  ],
                )
              : ListView.builder(
                  itemCount: cubit.devices.length,
                  itemBuilder: (c, i) {
                    return ListTile(
                      leading: const Icon(Icons.print),
                      title: Text(cubit.devices[i].name!),
                      subtitle: Text(cubit.devices[i].address!),
                      onTap: () {
                        cubit.testPrint(cubit.devices[i] as String, context);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
