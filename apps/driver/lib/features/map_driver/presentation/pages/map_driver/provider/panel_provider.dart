import 'package:driver/common/networks/api_result/api_result.dart';
import 'package:flutter/material.dart';

import '../../../../../../Assistants/requestAssistant.dart';
import '../../../../domain/entities/driver_panel.dart';

class PanelProvider extends ChangeNotifier {
  late Future<ApiResult<DriverPanel>>? _future;

  Future<ApiResult<DriverPanel>>? get future => _future;

  PanelProvider() {
    reBuildWidget();
  }

  reBuildWidget() async {
    //_future = await RequestAssistant.getRequest('/api/Statistics/GetDriverStatistics');
    notifyListeners();
  }
}
