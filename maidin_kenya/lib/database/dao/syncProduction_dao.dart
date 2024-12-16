
import 'package:floor/floor.dart';
import 'package:maidin_kenya/database/entity/syncProductionDataEntity.dart';

@dao
abstract class SyncProductionDao{
  @insert
  Future<int> insertSyncProductionData(SyncProductionDataEntity user);

  @Query('SELECT * FROM SyncProductionDataEntity')
  Future<List<SyncProductionDataEntity>> retrieveSyncProductionData();

  @Query('DELETE FROM SyncProductionDataEntity')
  Future<SyncProductionDataEntity?> deleteSyncProductionData();

  @Query('DELETE FROM SyncProductionDataEntity WHERE id = :id')
  Future<SyncProductionDataEntity?> deleteSyncProductionDataById(int id);

  @update
  Future<void> updateUser(SyncProductionDataEntity data);
}