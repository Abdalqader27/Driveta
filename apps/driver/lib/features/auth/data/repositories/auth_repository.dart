import 'package:driver/common/utils/connectivity.dart';import 'package:network/network.dart';import '../../../../common/utils/helper_method.dart';import '../../domain/entities/driver_info.dart';import '../../domain/repositories/i_auth_repository.dart';import '../data_sources/auth_api.dart';class AuthRepository extends IAuthRepository {  final SConnectivity _connectivity;  final AuthApi _remote;  AuthRepository({    required SConnectivity connectivity,    required AuthApi remote,  })  : _connectivity = connectivity,        _remote = remote;  @override  Future<ApiResult<DriverInfo>> login({    required String username,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return await fetchApiResult<DriverInfo>(      isConnected: _connectivity.isConnected,      fetch: _remote.login(        username: username,        password: password,        deviceToken: deviceToken,        rememberMe: rememberMe,      ),    );  }  @override  Future<ApiResult<String>> signUp({    required String email,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return await fetchApiResult<String>(      isConnected: _connectivity.isConnected,      fetch: _remote.signUP(),    );  }}