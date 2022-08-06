import 'package:core/core.dart';import 'package:design/design.dart';import 'package:rider/features/presentation/manager/bloc.dart';import 'package:rider/features/presentation/manager/event.dart';import 'package:rider/features/presentation/manager/state.dart';import 'package:rider/features/presentation/pages/map/widgets/choice_cars.dart';import '../../../common/utils/bloc_wrapper.dart';import '../../data/models/delivers.dart';import '../../data/models/delivers_product.dart';import '../../data/models/store.dart';class LoginContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const LoginContainer({Key? key, required this.builder}) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      initChild: builder(context, {}),      onRetry: () => context.read<RiderBloc>().retry(),      selector: (state) => state.loginState!,      builder: builder,    );  }}class SignUpContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const SignUpContainer({Key? key, required this.builder}) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      initChild: builder(context, {}),      onRetry: () => context.read<RiderBloc>().retry(),      selector: (state) => state.signUpState!,      builder: builder,    );  }}class SupportContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const SupportContainer({Key? key, required this.builder}) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      initChild: builder(context, {}),      onRetry: () => context.read<RiderBloc>().retry(),      selector: (state) => state.supportState!,      builder: builder,    );  }}class GetDeliveriesContainer extends StatelessWidget {  final ViewModelBuilder<List<Delivers>> builder;  const GetDeliveriesContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<List<Delivers>, RiderBloc, RiderState>(      onRetry: () {        context.read<RiderBloc>().add(GetDeliveriesEvent());      },      onInit: () {        context.read<RiderBloc>().add(GetDeliveriesEvent());      },      selector: (state) => state.getDeliveriesState!,      builder: builder,    );  }}class GetDeliveriesProductContainer extends StatelessWidget {  final ViewModelBuilder<List<DeliversProduct>> builder;  const GetDeliveriesProductContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<List<DeliversProduct>, RiderBloc, RiderState>(      onRetry: () {        context.read<RiderBloc>().add(GetDeliveriesProductEvent());      },      onInit: () {        context.read<RiderBloc>().add(GetDeliveriesProductEvent());      },      selector: (state) => state.getDeliveriesProductState!,      builder: builder,    );  }}class GetStoresContainer extends StatelessWidget {  final ViewModelBuilder<List<Store>> builder;  const GetStoresContainer({Key? key, required this.builder}) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<List<Store>, RiderBloc, RiderState>(      onRetry: () {        context.read<RiderBloc>().add(GetStoresEvent());      },      onInit: () {        context.read<RiderBloc>().add(GetStoresEvent());      },      selector: (state) => state.getStoresState!,      builder: builder,    );  }}class GetStoreContainer extends StatelessWidget {  final String id;  final ViewModelBuilder<StoreDetails> builder;  const GetStoreContainer({    Key? key,    required this.builder,    required this.id,  }) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<StoreDetails, RiderBloc, RiderState>(      onRetry: () {        context.read<RiderBloc>().add(GetStoreDetailsEvent(id));      },      onInit: () {        context.read<RiderBloc>().add(GetStoreDetailsEvent(id));      },      selector: (state) => state.getStoreDetailsState!,      builder: builder,    );  }}class GetProfileContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const GetProfileContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      onInit: () {        context.read<RiderBloc>().add(GetProfileEvent());      },      onRetry: () {        context.read<RiderBloc>().add(GetProfileEvent());      },      selector: (state) => state.getProfileState!,      builder: builder,    );  }}class EndDeliveryContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const EndDeliveryContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      initChild: builder(context, {}),      onRetry: () => context.read<RiderBloc>().retry(),      selector: (state) => state.endDeliveryState!,      builder: builder,    );  }}class RemoveDeliveryContainer extends StatelessWidget {  final ViewModelBuilder<dynamic> builder;  const RemoveDeliveryContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<dynamic, RiderBloc, RiderState>(      initChild: builder(context, {}),      onRetry: () => context.read<RiderBloc>().retry(),      selector: (state) => state.removeDeliveryState!,      builder: builder,    );  }}class GetVehicleTypesContainer extends StatelessWidget {  final ViewModelBuilder<List<CarDetails>> builder;  const GetVehicleTypesContainer({Key? key, required this.builder})      : super(key: key);  @override  Widget build(BuildContext context) {    return BlocSelectorWrapper<List<CarDetails>, RiderBloc, RiderState>(      onRetry: () => context.read<RiderBloc>().add(GetVehicleTypesEvent()),      onInit: () => context.read<RiderBloc>().add(GetVehicleTypesEvent()),      selector: (state) => state.getVehicleTypesState!,      builder: builder,    );  }}