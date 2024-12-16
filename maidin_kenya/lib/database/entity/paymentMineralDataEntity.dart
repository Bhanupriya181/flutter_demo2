import 'package:floor/floor.dart';

@entity
class PaymentMineralDataEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String userName;
  final String userAddress;
  final String saleTransactionNo;
  final String mineralName;
  final String mineralType;
  final String mineralGrade;
  final String mineralUnit;
  final String mineralWeight;
  final String saleDate;
  final String saleType;
  final String purchaserName;
  final String purchaserAddress;
  final String soldReceivedPrice;
  final String saleVerifiedPrice;
  final String deductableValueByMinistry;
  final String mineralSaleValue;
  final String fullRoyalityValue;
  final String royalityPaid;
  final String royalityPaidDate;
  final String royalityPaidAmount;
  final String royalityLiability;
  final String receiptNumber;
  final String invoiceDoc;

  PaymentMineralDataEntity({
    this.id,
    required this.userName,
    required this.userAddress,
    required this.saleTransactionNo,
    required this.mineralName,
    required this.mineralType,
    required this.mineralGrade,
    required this.mineralUnit,
    required this.mineralWeight,
    required this.saleDate,
    required this.saleType,
    required this.purchaserName,
    required this.purchaserAddress,
    required this.soldReceivedPrice,
    required this.saleVerifiedPrice,
    required this.deductableValueByMinistry,
    required this.mineralSaleValue,
    required this.fullRoyalityValue,
    required this.royalityPaid,
    required this.royalityPaidDate,
    required this.royalityPaidAmount,
    required this.royalityLiability,
    required this.receiptNumber,
    required this.invoiceDoc,
  });
}
