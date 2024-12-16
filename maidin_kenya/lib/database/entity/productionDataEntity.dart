import 'package:floor/floor.dart';

@entity
class ProductionDataEntity  {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String userName ;
  final String address ;
  final String reportYear ;
  final String period ;
  final String mineralName ;
  final String mineralType ;
  final String mineralGreade ;
  final String mineralUnit ;
  final String oreExtractedQuantity ;
  final String oreProcessedQuantity ;
  final String recoveredGrade ;
  final String mineralRecovered ;
  final String closingStock ;
  final String remark ;

  ProductionDataEntity({this.id, required this.userName,
  required this.address, required this.reportYear,required this.period,
  required this.mineralName, required this.mineralType, required this.mineralGreade, required this.mineralUnit,
  required this.oreExtractedQuantity, required this.oreProcessedQuantity,
  required this.recoveredGrade, required this.mineralRecovered,
  required this.closingStock, required this.remark});
}