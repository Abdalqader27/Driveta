import 'dart:async';

import 'package:core/core.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../main.dart';

class SignalRService {
  SignalRService()
      : connections = {},
        _startCompleters = {};

  final Map<String, HubConnection> connections;
  final Map<String, Completer<void>> _startCompleters;

  Future<HubConnection> openHub(
    String hubUrl, {
    String? name,
    bool start = true,
    HttpConnectionOptions? options,
  }) async {
    if (connections[hubUrl] == null) {
      final hubName = name ?? hubUrl.split('/').last;
      final hubConnection = HubConnectionBuilder()
          .withUrl(
            hubUrl,
            options: options ?? _defaultHttpConnectionOptions(hubName),
          )
          .withAutomaticReconnect()
          .build();
      connections[hubUrl] = hubConnection;
    }
    if (start && !isConnected(hubUrl)) {
      await startHub(hubUrl);
    }

    return connections[hubUrl]!;
  }

  bool isConnected(String hub) {
    return connections[hub] != null &&
        connections[hub]!.state == HubConnectionState.Connected;
  }

  onReconnecting(String hub, Function(Exception? e) onRec) {
    return connections[hub]!.onreconnecting(({error}) {
      onRec(error);
    });
  }

  onReconnected(String hub, Function(String? id) onRec) {
    return connections[hub]!.onreconnected(({connectionId}) {
      onRec(connectionId);
    });
  }

  onClose(String hub, Function(Exception? e) onRec) {
    return connections[hub]!.onclose(({error}) {
      onRec(error);
    });
  }

  Future<void> startHub(String hubUrl) async {
    _assertHubIsBuilt(hubUrl);
    var completer = _startCompleters[hubUrl];
    if (completer == null) {
      completer = Completer();
      completer.complete(connections[hubUrl]!.start());
      _startCompleters[hubUrl] = completer;
    }
    await completer.future;
  }

  Future<void> closeHub(String hubUrl) async {
    final hubConnection = connections[hubUrl];
    if (hubConnection != null) {
      await connections[hubUrl]!.stop();
      connections.remove(hubUrl);
      _startCompleters.remove(hubUrl);
    }
  }

  void on({
    required String hubUrl,
    required String methodName,
    required MethodInvocationFunc method,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.on(methodName, method);
  }

  void invoke({
    required String hubUrl,
    required String methodName,
    required List<Object>? args,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.invoke(methodName, args: args);
  }

  void off({
    required String hubUrl,
    required String methodName,
    MethodInvocationFunc? method,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.off(methodName, method: method);
  }

  _assertHubIsBuilt(String hubUrl) {
    final hubConnection = connections[hubUrl];
    assert(hubConnection != null, 'Make sure you opened the hub');
  }

  HttpConnectionOptions _defaultHttpConnectionOptions(String hubName) {
    return HttpConnectionOptions(
      logMessageContent: true,
      requestTimeout: 90000,
      transport: HttpTransportType.WebSockets,
      accessTokenFactory: () async {
        print("Token : ${si<SStorage>().get(
          key: kAccessToken,
          type: ValueType.string,
        )}");
        return si<SStorage>().get(
          key: kAccessToken,
          type: ValueType.string,
        );
      },
      logger: Logger('SignalR($hubName)'),
    );
  }
}

void main() async {
  final s = SignalRService();
  final hub =
      await s.openHub('http://passengers-001-site1.gtempurl.com/orderHub');
  hub.onclose(({error}) {
    print(error);
  });

  print(hub.connectionId);
  print('connected');
  hub.on("Test", osama);
  hub.invoke("BroadcastMessage", args: ['7ssam']);
  hub.invoke("BroadcastMessage", args: ['ttt']);

  await Future.delayed(Duration(seconds: 90));
}

void osama(List<Object>? args) {
  print(args?[0]);
}
