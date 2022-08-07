import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/features/data/models/profile.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:driver/features/presentation/manager/state.dart';
import '../../../../../common/utils/bloc_wrapper.dart';
import '../../data/models/delivers.dart';
import '../../data/models/invoices.dart';
import '../../data/models/statistics.dart';
import 'event.dart';

class SupportContainer extends StatelessWidget {
  final ViewModelBuilder<dynamic> builder;
  const SupportContainer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocSelectorWrapper<dynamic, DriverBloc, DriverState>(
      initChild: builder(context, {}),
      onRetry: () => context.read<DriverBloc>().retry(),
      selector: (state) => state.supportState!,
      builder: builder,
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final ViewModelBuilder<DriverProfile> builder;
  const ProfileContainer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<DriverBloc>().add(GetProfileEvent());

    return BlocSelectorWrapper<DriverProfile, DriverBloc, DriverState>(
      onRetry: () => context.read<DriverBloc>().retry(),
      selector: (state) => state.infoState!,
      builder: builder,
    );
  }
}

class InvoiceContainer extends StatelessWidget {
  final ViewModelBuilder<Invoices> builder;
  const InvoiceContainer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<DriverBloc>().add(GetInvoicesEvent());
      return BlocSelectorWrapper<Invoices, DriverBloc, DriverState>(
        onRetry: () => context.read<DriverBloc>().retry(),
        selector: (state) => state.invoiceState!,
        builder: builder,
      );
    });
  }
}

class StatisticsContainer extends StatelessWidget {
  final ViewModelBuilder<Statistics> builder;
  const StatisticsContainer({Key? key, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<DriverBloc>().add(GetStatisticsEvent());
      return BlocSelectorWrapper<Statistics, DriverBloc, DriverState>(
        onRetry: () => context.read<DriverBloc>().retry(),
        selector: (state) => state.statisticsSate!,
        builder: builder,
      );
    });
  }
}

class HistoryContainer extends StatelessWidget {
  final ViewModelBuilder<List<Delivers>> builder;
  const HistoryContainer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<DriverBloc>().add(GetHistoriesEvent());

    return BlocSelectorWrapper<List<Delivers>, DriverBloc, DriverState>(
      onRetry: () => context.read<DriverBloc>().retry(),
      selector: (state) => state.historyState!,
      builder: builder,
    );
  }
}

class LoginContainer extends StatelessWidget {
  final ViewModelBuilder<dynamic> builder;
  const LoginContainer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocSelectorWrapper<dynamic, DriverBloc, DriverState>(
      initChild: builder(context, {}),
      onRetry: () => context.read<DriverBloc>().retry(),
      selector: (state) => state.loginState!,
      builder: builder,
    );
  }
}

class GetAvailableDeliveriesContainer extends StatelessWidget {
  final ViewModelBuilder<dynamic> builder;
  const GetAvailableDeliveriesContainer({Key? key, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<DriverBloc>().add(GetAvailableDeliveries([]));
      return BlocSelectorWrapper<dynamic, DriverBloc, DriverState>(
        initChild: builder(context, []),
        onRetry: () => context.read<DriverBloc>().retry(),
        selector: (state) => state.getAvailableDeliveriesState!,
        builder: builder,
      );
    });
  }
}
