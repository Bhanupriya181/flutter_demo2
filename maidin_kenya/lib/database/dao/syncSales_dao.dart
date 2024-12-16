import 'package:floor/floor.dart';
import 'package:maidin_kenya/database/entity/syncSalesDataEntity.dart';



@dao
abstract class SyncSalesDao{
  @insert
  Future<int> insertSyncSalesData(SyncSalesDataEntity user);

  @Query('SELECT * FROM SyncSalesDataEntity')
  Future<List<SyncSalesDataEntity>> retrieveSyncSalesData();

  @Query('DELETE FROM SyncSalesDataEntity')
  Future<SyncSalesDataEntity?> deleteSyncSalesData();

  @Query('DELETE FROM SyncSalesDataEntity WHERE id = :id')
  Future<SyncSalesDataEntity?> deleteSyncSalesDataById(int id);

  @update
  Future<void> updateUser(SyncSalesDataEntity data);

}