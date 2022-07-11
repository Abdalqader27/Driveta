import 'package:moor/moor.dart';

class Shops extends Table {
  TextColumn get id => text()();

  TextColumn get userName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get lat => text().nullable()();

  TextColumn get long => text().nullable()();

  TextColumn get name => text().nullable()();

  TextColumn get personalImage => text().nullable()();

  TextColumn get storeOwnerName => text()();

  TextColumn get streetId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
