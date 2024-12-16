import 'dart:async';
import 'package:floor/floor.dart';
import 'package:maidin_kenya/database/dao/production_dao.dart';
import 'package:maidin_kenya/database/dao/salesdata_dao.dart';
import 'package:maidin_kenya/database/dao/syncSales_dao.dart';
import 'package:maidin_kenya/database/entity/productionDataEntity.dart';
import 'package:maidin_kenya/database/entity/syncSalesDataEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/paymentMineral_dao.dart';
import 'dao/syncProduction_dao.dart';
import 'entity/paymentMineralDataEntity.dart';
import 'entity/salesDataEntity.dart';
import 'entity/syncProductionDataEntity.dart';
part 'database.g.dart';

@Database(version: 2, entities: [ProductionDataEntity,SyncProductionDataEntity,
  SalesDataEntity,SyncSalesDataEntity,PaymentMineralDataEntity])
abstract class UserDatabase extends FloorDatabase {
  ProductionDao get productionDao;
  SyncProductionDao get syncProductionDao;
  SalesDataDao get salesDataDao;
  SyncSalesDao get syncSalesDao;
  PaymentMineralDao get paymentMineralDataDao;

}
