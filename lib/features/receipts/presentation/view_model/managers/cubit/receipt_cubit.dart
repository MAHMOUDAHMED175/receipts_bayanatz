import 'dart:io';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:receipts_bayanatz/core/widgets/flutter_toast.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/print_content_pdf_receipt_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_state.dart';
import 'package:sqflite/sqflite.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());

  static ReceiptCubit get(context) => BlocProvider.of(context);

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> devices = [];
  String devicesMsg = "";
  final f = NumberFormat("\$###,###.00", "en_US");

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bluetoothPrint.scanResults.listen(
      (val) {
        {
          devices = val;
          emit(devicesReceiptState());
        }

        if (devices.isEmpty) {
          devicesMsg = "No Devices";
          emit(devicesMsgReceiptState());
        }
      },
    );
  }

  void testPrint(String printerIp, context) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      await PrintPdfContent.printDemoReceipt(
          printer,
          context,

          ///
          /// عايزه تفكير

          0

          ///

          );

      printer.disconnect();
    }

    showToast(text: res.msg, state: ToastStates.SUCCECC);
  }

  ///TakePhoto
  File? imagesFile;
  String? savePathImage;

  Future<void> takeImageGellary(context) async {
    final XFile? imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }
    imagesFile = File(imageFile.path);
    emit(takeImageGellaryState());
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagesFile!.path);
    final saveImagepath = await imagesFile!.copy('${apDir.path}/$fileName');
    Navigator.pop(context);

    addImagePlace(saveImagepath);
  }

  Future<void> takeImageCamera(context) async {
    final XFile? imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      return;
    }
    imagesFile = File(imageFile.path);
    emit(takeImageCameraState());

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagesFile!.path);

    final saveImagepath = await imagesFile!.copy('${apDir.path}/$fileName');
    Navigator.pop(context);
    addImagePlace(saveImagepath);
  }

  void addImagePlace(File image) {
    savePathImage = image.path;
    // print(image.path);
  }

  ///TakePhoto

  double total = 0.0;
  double tax = 0.0;
  double totalAfterTax = 0.0;





  late Database database;
  List<Map> product = [];
  List<Map> company = [];

  void CreateDatabase() {
    openDatabase(
      'store.db',
      version: 1,
      onCreate: (database, version) {
        print("congratulation database is created");
        database
            .execute(
                'CREATE TABLE store(id INTEGER PRIMARY KEY,productName TEXT,productPrice TEXT,productCount TEXT,productTotal TEXT)')
            .then((value) {
          print('table is created');
        }).catchError((error) {
          print('errror when create table');
        });

        database
            .execute(
                'CREATE TABLE companyInfo(id INTEGER PRIMARY KEY,companyName TEXT,companyPhone TEXT,companyAddress TEXT)')
            .then((value) {
          print('table companyInfo is created');
        }).catchError((error) {
          print('errror when create table companyInfo');
        });
      },
      onOpen: (database) {
        getDatabase(database);
        print("congratulation database is opend");
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  Future InsertDatabase({
    required String productName,
    required String productPrice,
    required String productCount,
    required String productTotal,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO store(productName,productPrice,productCount,productTotal)VALUES("$productName","$productPrice","$productCount","$productTotal")')
          .then((value) {
        emit(InsertDatabaseState());
        print("values inserted successfully");
        print(value);
        getDatabase(database);
      }).catchError((error) {
        print(error);
      });
    });
  }

  Future InsertDatabaseCompany({
    required String companyName,
    required String companyPhone,
    required String companyAddress,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO companyInfo(companyName,companyPhone,companyAddress)VALUES("$companyName","$companyPhone","$companyAddress")')
          .then((value) {
        emit(InsertDatabaseState());
        print("values inserted successfully");
        print(value);
        getDatabase(database);
      }).catchError((error) {
        print(error);
      });
    });
  }

  void getDatabase(database) {
    product = []; // إعادة تعيين القائمة عند كل استرداد للبيانات
    company = []; // إعادة تعيين القائمة عند كل استرداد للبيانات
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM store').then((value) {
      value.forEach((element) {
        product.add(element);
      });
      emit(GetDatabaseState());
    });
    database.rawQuery('SELECT * FROM companyInfo').then((value) {
      value.forEach((element) {
        company.add(element);
      });
      emit(GetDatabaseState());
    });
  }

  void DeleteData({required int id1, context}) async {
    await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM store WHERE id = ?', [id1]);
    }).then((value) {
      getDatabase(database);
      emit(DeleteDatabaseState());
    });
  }
}
