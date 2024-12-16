import 'package:floor/floor.dart';
import 'package:maidin_kenya/database/entity/productionDataEntity.dart';

@dao
abstract class ProductionDao  {
  @insert
  Future<int> insertProductionData(ProductionDataEntity user);

  @Query('SELECT * FROM ProductionDataEntity')
  Future<List<ProductionDataEntity>> retrieveProductionData();

  @Query('SELECT * FROM ProductionDataEntity where id  =:id')
  Future<ProductionDataEntity?> retrieveOneData( int id);

  @Query('DELETE FROM ProductionDataEntity WHERE id = :id')
  Future<ProductionDataEntity?> deleteUsProductionData(int id);

  @Query('DELETE FROM ProductionDataEntity WHERE id = :id')
  Future<ProductionDataEntity?> syncUsProductionData(int id);

  @update
  Future<void> updateUser(ProductionDataEntity data);
}