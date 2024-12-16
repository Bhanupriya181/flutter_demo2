import 'package:floor/floor.dart';
@entity
class SyncSalesDataEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;


  final String userName;
  final String address;
  final String selectedDate;
  final String saleTransactionController;
  final String mineralName;
  final String mineralType;
  final String mineralGreade;
  final String mineralUnit;
  final String mineralWeightController;
  final String soldMineralPriceController;
  final String verifiedMineralPriceController;
  final String saleTypeController;
  final String societyId;
  final String societyName;
  final String namePurchaserController;
  final String addressPurchaserController;
  final String exportedMineralController;
  final String selectedValue;
  final String fileName;
  final String pdfName;

  SyncSalesDataEntity({this.id, required this.userName,
    required this.address, required this.selectedDate, required this.saleTransactionController,
    required this.mineralName, required this.mineralType, required this.mineralGreade,
    required this.mineralUnit, required this.mineralWeightController,
    required this.soldMineralPriceController, required this.verifiedMineralPriceController,
    required this.saleTypeController, required this.societyId, required this.societyName,
    required this.namePurchaserController, required this.addressPurchaserController,
    required this.exportedMineralController, required this.selectedValue, required this.fileName,
    required this.pdfName});
}