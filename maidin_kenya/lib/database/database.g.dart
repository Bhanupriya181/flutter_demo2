// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorUserDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder databaseBuilder(String name) =>
      _$UserDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$UserDatabaseBuilder(null);
}

class _$UserDatabaseBuilder {
  _$UserDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$UserDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$UserDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<UserDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$UserDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UserDatabase extends UserDatabase {
  _$UserDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductionDao? _productionDaoInstance;

  SyncProductionDao? _syncProductionDaoInstance;

  SalesDataDao? _salesDataDaoInstance;

  SyncSalesDao? _syncSalesDaoInstance;

  PaymentMineralDao? _paymentMineralDataDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductionDataEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `address` TEXT NOT NULL, `reportYear` TEXT NOT NULL, `period` TEXT NOT NULL, `mineralName` TEXT NOT NULL, `mineralType` TEXT NOT NULL, `mineralGreade` TEXT NOT NULL, `mineralUnit` TEXT NOT NULL, `oreExtractedQuantity` TEXT NOT NULL, `oreProcessedQuantity` TEXT NOT NULL, `recoveredGrade` TEXT NOT NULL, `mineralRecovered` TEXT NOT NULL, `closingStock` TEXT NOT NULL, `remark` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SyncProductionDataEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `address` TEXT NOT NULL, `reportYear` TEXT NOT NULL, `period` TEXT NOT NULL, `mineralName` TEXT NOT NULL, `mineralType` TEXT NOT NULL, `mineralGreade` TEXT NOT NULL, `mineralUnit` TEXT NOT NULL, `oreExtractedQuantity` TEXT NOT NULL, `oreProcessedQuantity` TEXT NOT NULL, `recoveredGrade` TEXT NOT NULL, `mineralRecovered` TEXT NOT NULL, `closingStock` TEXT NOT NULL, `remark` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SalesDataEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `address` TEXT NOT NULL, `selectedDate` TEXT NOT NULL, `saleTransactionController` TEXT NOT NULL, `mineralName` TEXT NOT NULL, `mineralType` TEXT NOT NULL, `mineralGreade` TEXT NOT NULL, `mineralUnit` TEXT NOT NULL, `mineralWeightController` TEXT NOT NULL, `soldMineralPriceController` TEXT NOT NULL, `verifiedMineralPriceController` TEXT NOT NULL, `saleTypeController` TEXT NOT NULL, `societyId` TEXT NOT NULL, `societyName` TEXT NOT NULL, `namePurchaserController` TEXT NOT NULL, `addressPurchaserController` TEXT NOT NULL, `exportedMineralController` TEXT NOT NULL, `selectedValue` TEXT NOT NULL, `fileName` TEXT NOT NULL, `pdfName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SyncSalesDataEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `address` TEXT NOT NULL, `selectedDate` TEXT NOT NULL, `saleTransactionController` TEXT NOT NULL, `mineralName` TEXT NOT NULL, `mineralType` TEXT NOT NULL, `mineralGreade` TEXT NOT NULL, `mineralUnit` TEXT NOT NULL, `mineralWeightController` TEXT NOT NULL, `soldMineralPriceController` TEXT NOT NULL, `verifiedMineralPriceController` TEXT NOT NULL, `saleTypeController` TEXT NOT NULL, `societyId` TEXT NOT NULL, `societyName` TEXT NOT NULL, `namePurchaserController` TEXT NOT NULL, `addressPurchaserController` TEXT NOT NULL, `exportedMineralController` TEXT NOT NULL, `selectedValue` TEXT NOT NULL, `fileName` TEXT NOT NULL, `pdfName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PaymentMineralDataEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `userAddress` TEXT NOT NULL, `saleTransactionNo` TEXT NOT NULL, `mineralName` TEXT NOT NULL, `mineralType` TEXT NOT NULL, `mineralGrade` TEXT NOT NULL, `mineralUnit` TEXT NOT NULL, `mineralWeight` TEXT NOT NULL, `saleDate` TEXT NOT NULL, `saleType` TEXT NOT NULL, `purchaserName` TEXT NOT NULL, `purchaserAddress` TEXT NOT NULL, `soldReceivedPrice` TEXT NOT NULL, `saleVerifiedPrice` TEXT NOT NULL, `deductableValueByMinistry` TEXT NOT NULL, `mineralSaleValue` TEXT NOT NULL, `fullRoyalityValue` TEXT NOT NULL, `royalityPaid` TEXT NOT NULL, `royalityPaidDate` TEXT NOT NULL, `royalityPaidAmount` TEXT NOT NULL, `royalityLiability` TEXT NOT NULL, `receiptNumber` TEXT NOT NULL, `invoiceDoc` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductionDao get productionDao {
    return _productionDaoInstance ??= _$ProductionDao(database, changeListener);
  }

  @override
  SyncProductionDao get syncProductionDao {
    return _syncProductionDaoInstance ??=
        _$SyncProductionDao(database, changeListener);
  }

  @override
  SalesDataDao get salesDataDao {
    return _salesDataDaoInstance ??= _$SalesDataDao(database, changeListener);
  }

  @override
  SyncSalesDao get syncSalesDao {
    return _syncSalesDaoInstance ??= _$SyncSalesDao(database, changeListener);
  }

  @override
  PaymentMineralDao get paymentMineralDataDao {
    return _paymentMineralDataDaoInstance ??=
        _$PaymentMineralDao(database, changeListener);
  }
}

class _$ProductionDao extends ProductionDao {
  _$ProductionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productionDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProductionDataEntity',
            (ProductionDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'reportYear': item.reportYear,
                  'period': item.period,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'oreExtractedQuantity': item.oreExtractedQuantity,
                  'oreProcessedQuantity': item.oreProcessedQuantity,
                  'recoveredGrade': item.recoveredGrade,
                  'mineralRecovered': item.mineralRecovered,
                  'closingStock': item.closingStock,
                  'remark': item.remark
                }),
        _productionDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProductionDataEntity',
            ['id'],
            (ProductionDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'reportYear': item.reportYear,
                  'period': item.period,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'oreExtractedQuantity': item.oreExtractedQuantity,
                  'oreProcessedQuantity': item.oreProcessedQuantity,
                  'recoveredGrade': item.recoveredGrade,
                  'mineralRecovered': item.mineralRecovered,
                  'closingStock': item.closingStock,
                  'remark': item.remark
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductionDataEntity>
      _productionDataEntityInsertionAdapter;

  final UpdateAdapter<ProductionDataEntity> _productionDataEntityUpdateAdapter;

  @override
  Future<List<ProductionDataEntity>> retrieveProductionData() async {
    return _queryAdapter.queryList('SELECT * FROM ProductionDataEntity',
        mapper: (Map<String, Object?> row) => ProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String));
  }

  @override
  Future<ProductionDataEntity?> retrieveOneData(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM ProductionDataEntity where id  =?1',
        mapper: (Map<String, Object?> row) => ProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String),
        arguments: [id]);
  }

  @override
  Future<ProductionDataEntity?> deleteUsProductionData(int id) async {
    return _queryAdapter.query('DELETE FROM ProductionDataEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String),
        arguments: [id]);
  }

  @override
  Future<ProductionDataEntity?> syncUsProductionData(int id) async {
    return _queryAdapter.query('DELETE FROM ProductionDataEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertProductionData(ProductionDataEntity user) {
    return _productionDataEntityInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(ProductionDataEntity data) async {
    await _productionDataEntityUpdateAdapter.update(
        data, OnConflictStrategy.abort);
  }
}

class _$SyncProductionDao extends SyncProductionDao {
  _$SyncProductionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _syncProductionDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'SyncProductionDataEntity',
            (SyncProductionDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'reportYear': item.reportYear,
                  'period': item.period,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'oreExtractedQuantity': item.oreExtractedQuantity,
                  'oreProcessedQuantity': item.oreProcessedQuantity,
                  'recoveredGrade': item.recoveredGrade,
                  'mineralRecovered': item.mineralRecovered,
                  'closingStock': item.closingStock,
                  'remark': item.remark
                }),
        _syncProductionDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'SyncProductionDataEntity',
            ['id'],
            (SyncProductionDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'reportYear': item.reportYear,
                  'period': item.period,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'oreExtractedQuantity': item.oreExtractedQuantity,
                  'oreProcessedQuantity': item.oreProcessedQuantity,
                  'recoveredGrade': item.recoveredGrade,
                  'mineralRecovered': item.mineralRecovered,
                  'closingStock': item.closingStock,
                  'remark': item.remark
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SyncProductionDataEntity>
      _syncProductionDataEntityInsertionAdapter;

  final UpdateAdapter<SyncProductionDataEntity>
      _syncProductionDataEntityUpdateAdapter;

  @override
  Future<List<SyncProductionDataEntity>> retrieveSyncProductionData() async {
    return _queryAdapter.queryList('SELECT * FROM SyncProductionDataEntity',
        mapper: (Map<String, Object?> row) => SyncProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String));
  }

  @override
  Future<SyncProductionDataEntity?> deleteSyncProductionData() async {
    return _queryAdapter.query('DELETE FROM SyncProductionDataEntity',
        mapper: (Map<String, Object?> row) => SyncProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String));
  }

  @override
  Future<SyncProductionDataEntity?> deleteSyncProductionDataById(int id) async {
    return _queryAdapter.query(
        'DELETE FROM SyncProductionDataEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SyncProductionDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            reportYear: row['reportYear'] as String,
            period: row['period'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            oreExtractedQuantity: row['oreExtractedQuantity'] as String,
            oreProcessedQuantity: row['oreProcessedQuantity'] as String,
            recoveredGrade: row['recoveredGrade'] as String,
            mineralRecovered: row['mineralRecovered'] as String,
            closingStock: row['closingStock'] as String,
            remark: row['remark'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertSyncProductionData(SyncProductionDataEntity user) {
    return _syncProductionDataEntityInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(SyncProductionDataEntity data) async {
    await _syncProductionDataEntityUpdateAdapter.update(
        data, OnConflictStrategy.abort);
  }
}

class _$SalesDataDao extends SalesDataDao {
  _$SalesDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _salesDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'SalesDataEntity',
            (SalesDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'selectedDate': item.selectedDate,
                  'saleTransactionController': item.saleTransactionController,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'mineralWeightController': item.mineralWeightController,
                  'soldMineralPriceController': item.soldMineralPriceController,
                  'verifiedMineralPriceController':
                      item.verifiedMineralPriceController,
                  'saleTypeController': item.saleTypeController,
                  'societyId': item.societyId,
                  'societyName': item.societyName,
                  'namePurchaserController': item.namePurchaserController,
                  'addressPurchaserController': item.addressPurchaserController,
                  'exportedMineralController': item.exportedMineralController,
                  'selectedValue': item.selectedValue,
                  'fileName': item.fileName,
                  'pdfName': item.pdfName
                }),
        _salesDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'SalesDataEntity',
            ['id'],
            (SalesDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'selectedDate': item.selectedDate,
                  'saleTransactionController': item.saleTransactionController,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'mineralWeightController': item.mineralWeightController,
                  'soldMineralPriceController': item.soldMineralPriceController,
                  'verifiedMineralPriceController':
                      item.verifiedMineralPriceController,
                  'saleTypeController': item.saleTypeController,
                  'societyId': item.societyId,
                  'societyName': item.societyName,
                  'namePurchaserController': item.namePurchaserController,
                  'addressPurchaserController': item.addressPurchaserController,
                  'exportedMineralController': item.exportedMineralController,
                  'selectedValue': item.selectedValue,
                  'fileName': item.fileName,
                  'pdfName': item.pdfName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SalesDataEntity> _salesDataEntityInsertionAdapter;

  final UpdateAdapter<SalesDataEntity> _salesDataEntityUpdateAdapter;

  @override
  Future<List<SalesDataEntity>> retrieveSalesData() async {
    return _queryAdapter.queryList('SELECT * FROM SalesDataEntity',
        mapper: (Map<String, Object?> row) => SalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String));
  }

  @override
  Future<SalesDataEntity?> deleteSalesData() async {
    return _queryAdapter.query('DELETE FROM SalesDataEntity',
        mapper: (Map<String, Object?> row) => SalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String));
  }

  @override
  Future<SalesDataEntity?> deleteSalesDataById(int id) async {
    return _queryAdapter.query('DELETE FROM SalesDataEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertSalesData(SalesDataEntity user) {
    return _salesDataEntityInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(SalesDataEntity data) async {
    await _salesDataEntityUpdateAdapter.update(data, OnConflictStrategy.abort);
  }
}

class _$SyncSalesDao extends SyncSalesDao {
  _$SyncSalesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _syncSalesDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'SyncSalesDataEntity',
            (SyncSalesDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'selectedDate': item.selectedDate,
                  'saleTransactionController': item.saleTransactionController,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'mineralWeightController': item.mineralWeightController,
                  'soldMineralPriceController': item.soldMineralPriceController,
                  'verifiedMineralPriceController':
                      item.verifiedMineralPriceController,
                  'saleTypeController': item.saleTypeController,
                  'societyId': item.societyId,
                  'societyName': item.societyName,
                  'namePurchaserController': item.namePurchaserController,
                  'addressPurchaserController': item.addressPurchaserController,
                  'exportedMineralController': item.exportedMineralController,
                  'selectedValue': item.selectedValue,
                  'fileName': item.fileName,
                  'pdfName': item.pdfName
                }),
        _syncSalesDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'SyncSalesDataEntity',
            ['id'],
            (SyncSalesDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'address': item.address,
                  'selectedDate': item.selectedDate,
                  'saleTransactionController': item.saleTransactionController,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGreade': item.mineralGreade,
                  'mineralUnit': item.mineralUnit,
                  'mineralWeightController': item.mineralWeightController,
                  'soldMineralPriceController': item.soldMineralPriceController,
                  'verifiedMineralPriceController':
                      item.verifiedMineralPriceController,
                  'saleTypeController': item.saleTypeController,
                  'societyId': item.societyId,
                  'societyName': item.societyName,
                  'namePurchaserController': item.namePurchaserController,
                  'addressPurchaserController': item.addressPurchaserController,
                  'exportedMineralController': item.exportedMineralController,
                  'selectedValue': item.selectedValue,
                  'fileName': item.fileName,
                  'pdfName': item.pdfName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SyncSalesDataEntity>
      _syncSalesDataEntityInsertionAdapter;

  final UpdateAdapter<SyncSalesDataEntity> _syncSalesDataEntityUpdateAdapter;

  @override
  Future<List<SyncSalesDataEntity>> retrieveSyncSalesData() async {
    return _queryAdapter.queryList('SELECT * FROM SyncSalesDataEntity',
        mapper: (Map<String, Object?> row) => SyncSalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String));
  }

  @override
  Future<SyncSalesDataEntity?> deleteSyncSalesData() async {
    return _queryAdapter.query('DELETE FROM SyncSalesDataEntity',
        mapper: (Map<String, Object?> row) => SyncSalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String));
  }

  @override
  Future<SyncSalesDataEntity?> deleteSyncSalesDataById(int id) async {
    return _queryAdapter.query('DELETE FROM SyncSalesDataEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SyncSalesDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            address: row['address'] as String,
            selectedDate: row['selectedDate'] as String,
            saleTransactionController:
                row['saleTransactionController'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGreade: row['mineralGreade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeightController: row['mineralWeightController'] as String,
            soldMineralPriceController:
                row['soldMineralPriceController'] as String,
            verifiedMineralPriceController:
                row['verifiedMineralPriceController'] as String,
            saleTypeController: row['saleTypeController'] as String,
            societyId: row['societyId'] as String,
            societyName: row['societyName'] as String,
            namePurchaserController: row['namePurchaserController'] as String,
            addressPurchaserController:
                row['addressPurchaserController'] as String,
            exportedMineralController:
                row['exportedMineralController'] as String,
            selectedValue: row['selectedValue'] as String,
            fileName: row['fileName'] as String,
            pdfName: row['pdfName'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertSyncSalesData(SyncSalesDataEntity user) {
    return _syncSalesDataEntityInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(SyncSalesDataEntity data) async {
    await _syncSalesDataEntityUpdateAdapter.update(
        data, OnConflictStrategy.abort);
  }
}

class _$PaymentMineralDao extends PaymentMineralDao {
  _$PaymentMineralDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _paymentMineralDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'PaymentMineralDataEntity',
            (PaymentMineralDataEntity item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'userAddress': item.userAddress,
                  'saleTransactionNo': item.saleTransactionNo,
                  'mineralName': item.mineralName,
                  'mineralType': item.mineralType,
                  'mineralGrade': item.mineralGrade,
                  'mineralUnit': item.mineralUnit,
                  'mineralWeight': item.mineralWeight,
                  'saleDate': item.saleDate,
                  'saleType': item.saleType,
                  'purchaserName': item.purchaserName,
                  'purchaserAddress': item.purchaserAddress,
                  'soldReceivedPrice': item.soldReceivedPrice,
                  'saleVerifiedPrice': item.saleVerifiedPrice,
                  'deductableValueByMinistry': item.deductableValueByMinistry,
                  'mineralSaleValue': item.mineralSaleValue,
                  'fullRoyalityValue': item.fullRoyalityValue,
                  'royalityPaid': item.royalityPaid,
                  'royalityPaidDate': item.royalityPaidDate,
                  'royalityPaidAmount': item.royalityPaidAmount,
                  'royalityLiability': item.royalityLiability,
                  'receiptNumber': item.receiptNumber,
                  'invoiceDoc': item.invoiceDoc
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PaymentMineralDataEntity>
      _paymentMineralDataEntityInsertionAdapter;

  @override
  Future<List<PaymentMineralDataEntity>> retrievePaymentMineralData() async {
    return _queryAdapter.queryList('SELECT * FROM PaymentMineralDataEntity',
        mapper: (Map<String, Object?> row) => PaymentMineralDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            userAddress: row['userAddress'] as String,
            saleTransactionNo: row['saleTransactionNo'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGrade: row['mineralGrade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeight: row['mineralWeight'] as String,
            saleDate: row['saleDate'] as String,
            saleType: row['saleType'] as String,
            purchaserName: row['purchaserName'] as String,
            purchaserAddress: row['purchaserAddress'] as String,
            soldReceivedPrice: row['soldReceivedPrice'] as String,
            saleVerifiedPrice: row['saleVerifiedPrice'] as String,
            deductableValueByMinistry:
                row['deductableValueByMinistry'] as String,
            mineralSaleValue: row['mineralSaleValue'] as String,
            fullRoyalityValue: row['fullRoyalityValue'] as String,
            royalityPaid: row['royalityPaid'] as String,
            royalityPaidDate: row['royalityPaidDate'] as String,
            royalityPaidAmount: row['royalityPaidAmount'] as String,
            royalityLiability: row['royalityLiability'] as String,
            receiptNumber: row['receiptNumber'] as String,
            invoiceDoc: row['invoiceDoc'] as String));
  }

  @override
  Future<PaymentMineralDataEntity?> retrieveOneData(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM PaymentMineralDataEntity where id  =?1',
        mapper: (Map<String, Object?> row) => PaymentMineralDataEntity(
            id: row['id'] as int?,
            userName: row['userName'] as String,
            userAddress: row['userAddress'] as String,
            saleTransactionNo: row['saleTransactionNo'] as String,
            mineralName: row['mineralName'] as String,
            mineralType: row['mineralType'] as String,
            mineralGrade: row['mineralGrade'] as String,
            mineralUnit: row['mineralUnit'] as String,
            mineralWeight: row['mineralWeight'] as String,
            saleDate: row['saleDate'] as String,
            saleType: row['saleType'] as String,
            purchaserName: row['purchaserName'] as String,
            purchaserAddress: row['purchaserAddress'] as String,
            soldReceivedPrice: row['soldReceivedPrice'] as String,
            saleVerifiedPrice: row['saleVerifiedPrice'] as String,
            deductableValueByMinistry:
                row['deductableValueByMinistry'] as String,
            mineralSaleValue: row['mineralSaleValue'] as String,
            fullRoyalityValue: row['fullRoyalityValue'] as String,
            royalityPaid: row['royalityPaid'] as String,
            royalityPaidDate: row['royalityPaidDate'] as String,
            royalityPaidAmount: row['royalityPaidAmount'] as String,
            royalityLiability: row['royalityLiability'] as String,
            receiptNumber: row['receiptNumber'] as String,
            invoiceDoc: row['invoiceDoc'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertPaymentMineralData(PaymentMineralDataEntity user) {
    return _paymentMineralDataEntityInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }
}
