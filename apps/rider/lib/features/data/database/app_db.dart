import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rider/features/data/database/tables/shops_table.dart';

import 'dao/shops_dao/shops_dao.dart';

part 'app_db.g.dart';

@UseMoor(tables: [Shops], daos: [ShopsDAO])
class AppDatabase extends _$AppDatabase {
  AppDatabase()

      /// Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',

          ///prints SQL in the console
          logStatements: true,
        )));
  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) => m.createAll(),
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (m) async {
        await customStatement('PRAGMA foreign_keys = ON;');
        final m = createMigrator();
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      });

  @override
  int get schemaVersion => 0;
}
