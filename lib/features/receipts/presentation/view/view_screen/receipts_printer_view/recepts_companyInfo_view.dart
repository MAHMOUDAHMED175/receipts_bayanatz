import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts_bayanatz/confg/app_route.dart';
import 'package:receipts_bayanatz/confg/local_notification/notification_services.dart';
import 'package:receipts_bayanatz/core/widgets/custom_app_par.dart';
import 'package:receipts_bayanatz/core/widgets/text_from_field_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/products_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/scane_photo.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_state.dart';

class ReceiptsPrinterView extends StatefulWidget {
  ReceiptsPrinterView({Key? key}) : super(key: key);

  @override
  State<ReceiptsPrinterView> createState() => _ReceiptsPrinterViewState();
}

class _ReceiptsPrinterViewState extends State<ReceiptsPrinterView> {
  @override
  void initState() {
    NotificationsServices().initializationNotification();

    super.initState();
  }

  var nameCompanyController = TextEditingController();
  var phoneCompanyController = TextEditingController();
  var addressCompanyController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptCubit, ReceiptState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                  textAppBar: 'Create Receipts',
                  elevationAppBar: 20,
                  showenCenterText: true,
                  actionsAppBar: [])),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[200],
                                  content: AlertDialogeTakeImage(),
                                );
                              });
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 85,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red,
                                      Colors.lightBlueAccent,
                                      Colors.red,
                                      Colors.red,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child:
                                    ReceiptCubit
                                        .get(context)
                                        .imagesFile ==
                                        null
                                        ? const Text(
                                      'Logo',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                        : CircleAvatar(
                                        radius: 70,
                                        backgroundImage: FileImage(
                                          ReceiptCubit
                                              .get(context)
                                              .imagesFile!,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red,
                                        Colors.lightBlueAccent,
                                        Colors.red,
                                        Colors.red,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 38,
                                  )),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'اسم الشركه او المحل',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20),
                        ),
                        defaultFormField(
                            controller: nameCompanyController,
                            type: TextInputType.text,
                            hintText: 'اسم الشركه او المحل',
                            fillsColor: Colors.grey[300],
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'اسم الشركه او المحل';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'عنوان الشركه او المحل',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20),
                        ),
                        defaultFormField(
                            controller: addressCompanyController,
                            type: TextInputType.text,
                            hintText: 'عنوان الشركه او المحل',
                            fillsColor: Colors.grey[300],
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'عنوان الشركه او المحل';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'هاتف الشركه او المحل',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20),
                        ),
                        defaultFormField(
                            controller: phoneCompanyController,
                            type: TextInputType.phone,
                            hintText: 'هاتف الشركه او المحل',
                            fillsColor: Colors.grey[300],
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'هاتف الشركه او المحل';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ReceiptCubit.get(context).InsertDatabaseCompany(
                              companyName: nameCompanyController.text,
                              companyPhone: phoneCompanyController.text,
                              companyAddress: addressCompanyController.text,

                          );
                          GoRouter.of(context).push(AppRoute.productsReceipts);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "!! هل تريد اضافة منتجات",
                          style: TextStyle(color: Colors.white),
                          // style: Styles.textStyle18
                          //     .copyWith(color: ColorsApp.whiteColor),
                        ),
                      )),
                  // SizedBox(
                  //     height: 300,
                  //     width: double.infinity,
                  //     child: CreatePdfReceipts()),
                  // contentReceiptsWidget(),
                  // MaterialButton(
                  //   onPressed: () {
                  //     NotificationsServices().BigNotification('Receipts',
                  //         'We thank you for your trust,Downloading.................');
                  //   },
                  //   child: Text( ' pdfتنزيل الايصال  ك '),
                  //   color: Colors.orange,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: MaterialButton(
                  //     height: 60,
                  //     minWidth: double.infinity,
                  //     onPressed: () {
                  //       GoRouter.of(context).push(AppRoute.devicesPrinter);
                  //       showToast(
                  //           text: 'جارى البحث عن اجهزه يرجى فتح البلوتوث',
                  //           state: ToastStates.WARNING);
                  //     },
                  //     child: Text('هل تريد طباعه الايصال !!'),
                  //     color: Colors.orange[300],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
    //2
  }
}
