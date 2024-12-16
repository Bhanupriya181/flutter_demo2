import 'package:floor/floor.dart';
import 'package:maidin_kenya/database/entity/salesDataEntity.dart';

  @dao
  abstract class SalesDataDao{
  @insert
  Future<int>insertSalesData(SalesDataEntity user);

  @Query('SELECT * FROM SalesDataEntity')
  Future<List<SalesDataEntity>> retrieveSalesData();

  @Query('DELETE FROM SalesDataEntity')
  Future<SalesDataEntity?> deleteSalesData();

  @Query('DELETE FROM SalesDataEntity WHERE id = :id')
  Future<SalesDataEntity?> deleteSalesDataById(int id);

  @update
  Future<void> updateUser(SalesDataEntity data);

}