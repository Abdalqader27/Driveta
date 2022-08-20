// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Shop extends DataClass implements Insertable<Shop> {
  final String id;
  final String userName;
  final String? description;
  final String? email;
  final String? lat;
  final String? long;
  final String? name;
  final String? personalImage;
  final String storeOwnerName;
  final String streetId;
  Shop(
      {required this.id,
      required this.userName,
      this.description,
      this.email,
      this.lat,
      this.long,
      this.name,
      this.personalImage,
      required this.storeOwnerName,
      required this.streetId});
  factory Shop.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Shop(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      lat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat']),
      long: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}long']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      personalImage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}personal_image']),
      storeOwnerName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}store_owner_name'])!,
      streetId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_name'] = Variable<String>(userName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<String?>(lat);
    }
    if (!nullToAbsent || long != null) {
      map['long'] = Variable<String?>(long);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || personalImage != null) {
      map['personal_image'] = Variable<String?>(personalImage);
    }
    map['store_owner_name'] = Variable<String>(storeOwnerName);
    map['street_id'] = Variable<String>(streetId);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      userName: Value(userName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      long: long == null && nullToAbsent ? const Value.absent() : Value(long),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      personalImage: personalImage == null && nullToAbsent
          ? const Value.absent()
          : Value(personalImage),
      storeOwnerName: Value(storeOwnerName),
      streetId: Value(streetId),
    );
  }

  factory Shop.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<String>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      description: serializer.fromJson<String?>(json['description']),
      email: serializer.fromJson<String?>(json['email']),
      lat: serializer.fromJson<String?>(json['lat']),
      long: serializer.fromJson<String?>(json['long']),
      name: serializer.fromJson<String?>(json['name']),
      personalImage: serializer.fromJson<String?>(json['personalImage']),
      storeOwnerName: serializer.fromJson<String>(json['storeOwnerName']),
      streetId: serializer.fromJson<String>(json['streetId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userName': serializer.toJson<String>(userName),
      'description': serializer.toJson<String?>(description),
      'email': serializer.toJson<String?>(email),
      'lat': serializer.toJson<String?>(lat),
      'long': serializer.toJson<String?>(long),
      'name': serializer.toJson<String?>(name),
      'personalImage': serializer.toJson<String?>(personalImage),
      'storeOwnerName': serializer.toJson<String>(storeOwnerName),
      'streetId': serializer.toJson<String>(streetId),
    };
  }

  Shop copyWith(
          {String? id,
          String? userName,
          String? description,
          String? email,
          String? lat,
          String? long,
          String? name,
          String? personalImage,
          String? storeOwnerName,
          String? streetId}) =>
      Shop(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        description: description ?? this.description,
        email: email ?? this.email,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        name: name ?? this.name,
        personalImage: personalImage ?? this.personalImage,
        storeOwnerName: storeOwnerName ?? this.storeOwnerName,
        streetId: streetId ?? this.streetId,
      );
  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('description: $description, ')
          ..write('email: $email, ')
          ..write('lat: $lat, ')
          ..write('long: $long, ')
          ..write('name: $name, ')
          ..write('personalImage: $personalImage, ')
          ..write('storeOwnerName: $storeOwnerName, ')
          ..write('streetId: $streetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userName, description, email, lat, long,
      name, personalImage, storeOwnerName, streetId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.description == this.description &&
          other.email == this.email &&
          other.lat == this.lat &&
          other.long == this.long &&
          other.name == this.name &&
          other.personalImage == this.personalImage &&
          other.storeOwnerName == this.storeOwnerName &&
          other.streetId == this.streetId);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<String> id;
  final Value<String> userName;
  final Value<String?> description;
  final Value<String?> email;
  final Value<String?> lat;
  final Value<String?> long;
  final Value<String?> name;
  final Value<String?> personalImage;
  final Value<String> storeOwnerName;
  final Value<String> streetId;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.description = const Value.absent(),
    this.email = const Value.absent(),
    this.lat = const Value.absent(),
    this.long = const Value.absent(),
    this.name = const Value.absent(),
    this.personalImage = const Value.absent(),
    this.storeOwnerName = const Value.absent(),
    this.streetId = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required String userName,
    this.description = const Value.absent(),
    this.email = const Value.absent(),
    this.lat = const Value.absent(),
    this.long = const Value.absent(),
    this.name = const Value.absent(),
    this.personalImage = const Value.absent(),
    required String storeOwnerName,
    required String streetId,
  })  : id = Value(id),
        userName = Value(userName),
        storeOwnerName = Value(storeOwnerName),
        streetId = Value(streetId);
  static Insertable<Shop> custom({
    Expression<String>? id,
    Expression<String>? userName,
    Expression<String?>? description,
    Expression<String?>? email,
    Expression<String?>? lat,
    Expression<String?>? long,
    Expression<String?>? name,
    Expression<String?>? personalImage,
    Expression<String>? storeOwnerName,
    Expression<String>? streetId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (description != null) 'description': description,
      if (email != null) 'email': email,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
      if (name != null) 'name': name,
      if (personalImage != null) 'personal_image': personalImage,
      if (storeOwnerName != null) 'store_owner_name': storeOwnerName,
      if (streetId != null) 'street_id': streetId,
    });
  }

  ShopsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userName,
      Value<String?>? description,
      Value<String?>? email,
      Value<String?>? lat,
      Value<String?>? long,
      Value<String?>? name,
      Value<String?>? personalImage,
      Value<String>? storeOwnerName,
      Value<String>? streetId}) {
    return ShopsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      email: email ?? this.email,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      name: name ?? this.name,
      personalImage: personalImage ?? this.personalImage,
      storeOwnerName: storeOwnerName ?? this.storeOwnerName,
      streetId: streetId ?? this.streetId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (lat.present) {
      map['lat'] = Variable<String?>(lat.value);
    }
    if (long.present) {
      map['long'] = Variable<String?>(long.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (personalImage.present) {
      map['personal_image'] = Variable<String?>(personalImage.value);
    }
    if (storeOwnerName.present) {
      map['store_owner_name'] = Variable<String>(storeOwnerName.value);
    }
    if (streetId.present) {
      map['street_id'] = Variable<String>(streetId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('description: $description, ')
          ..write('email: $email, ')
          ..write('lat: $lat, ')
          ..write('long: $long, ')
          ..write('name: $name, ')
          ..write('personalImage: $personalImage, ')
          ..write('storeOwnerName: $storeOwnerName, ')
          ..write('streetId: $streetId')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String?> userName = GeneratedColumn<String?>(
      'user_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<String?> lat = GeneratedColumn<String?>(
      'lat', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _longMeta = const VerificationMeta('long');
  @override
  late final GeneratedColumn<String?> long = GeneratedColumn<String?>(
      'long', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _personalImageMeta =
      const VerificationMeta('personalImage');
  @override
  late final GeneratedColumn<String?> personalImage = GeneratedColumn<String?>(
      'personal_image', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _storeOwnerNameMeta =
      const VerificationMeta('storeOwnerName');
  @override
  late final GeneratedColumn<String?> storeOwnerName = GeneratedColumn<String?>(
      'store_owner_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _streetIdMeta = const VerificationMeta('streetId');
  @override
  late final GeneratedColumn<String?> streetId = GeneratedColumn<String?>(
      'street_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userName,
        description,
        email,
        lat,
        long,
        name,
        personalImage,
        storeOwnerName,
        streetId
      ];
  @override
  String get aliasedName => _alias ?? 'shops';
  @override
  String get actualTableName => 'shops';
  @override
  VerificationContext validateIntegrity(Insertable<Shop> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    }
    if (data.containsKey('long')) {
      context.handle(
          _longMeta, long.isAcceptableOrUnknown(data['long']!, _longMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('personal_image')) {
      context.handle(
          _personalImageMeta,
          personalImage.isAcceptableOrUnknown(
              data['personal_image']!, _personalImageMeta));
    }
    if (data.containsKey('store_owner_name')) {
      context.handle(
          _storeOwnerNameMeta,
          storeOwnerName.isAcceptableOrUnknown(
              data['store_owner_name']!, _storeOwnerNameMeta));
    } else if (isInserting) {
      context.missing(_storeOwnerNameMeta);
    }
    if (data.containsKey('street_id')) {
      context.handle(_streetIdMeta,
          streetId.isAcceptableOrUnknown(data['street_id']!, _streetIdMeta));
    } else if (isInserting) {
      context.missing(_streetIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Shop.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ShopsTable shops = $ShopsTable(this);
  late final ShopsDAO shopsDAO = ShopsDAO(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [shops];
}
