import 'package:floor/floor.dart';

import '../entity/paymentMineralDataEntity.dart';

@dao
abstract class PaymentMineralDao{
  @insert
  Future<int>insertPaymentMineralData(PaymentMineralDataEntity user);

  @Query('SELECT * FROM PaymentMineralDataEntity')
  Future<List<PaymentMineralDataEntity>> retrievePaymentMineralData();

  @Query('SELECT * FROM PaymentMineralDataEntity where id  =:id')
  Future<PaymentMineralDataEntity?> retrieveOneData( int id);
  
}