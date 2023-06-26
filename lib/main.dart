

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipts_bayanatz/confg/them.dart';
import 'package:receipts_bayanatz/core/utils/cacheHelper.dart';
import 'package:receipts_bayanatz/core/widgets/flutter_toast.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
import 'confg/app_route.dart';
import 'confg/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.Initi();
  showToast(
                text:"Welcome To Receipt Application",
                state: ToastStates.SUCCECC);
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return ReceiptCubit()..CreateDatabase();
          }),
        ],
        child: MaterialApp.router(
          routerConfig: AppRoute.router,
          debugShowCheckedModeBanner: false,
          theme: light,
        ));
  }
}





