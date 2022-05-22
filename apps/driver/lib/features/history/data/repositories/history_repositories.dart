import 'package:network/network.dart';import '../../../../common/utils/connectivity.dart';import '../../../../common/utils/helper_method.dart';import '../../domain/repositories/i_history_repository.dart';import '../data_sources/history_api.dart';class HistoryRepository extends IHistoryRepository {  final SConnectivity _connectivity;  final HistoryApi _remote;  HistoryRepository({    required SConnectivity connectivity,    required HistoryApi remote,  })  : _connectivity = connectivity,        _remote = remote;  @override  Future<ApiResult<dynamic>> getHistories() async {    return await fetchApiResult<dynamic>(      isConnected: _connectivity.isConnected,      fetch: _remote.getHistories(),    );  }}