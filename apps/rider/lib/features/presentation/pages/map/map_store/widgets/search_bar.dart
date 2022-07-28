import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../../../common/widgets/progress-Indicator.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../bloc/map_source/map_source.dart';

final typeAheadController = TextEditingController();

class SearchBarMap extends StatelessWidget {
  // final MapBloc? gMapBloc;

  const SearchBarMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: RPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).cardColor
                                    : Colors.grey[200]!,
                            // offset: const Offset(1.0, 1.0),
                            blurRadius: 0,
                            spreadRadius: 0)
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TypeAheadFormField(
                      noItemsFoundBuilder: (_) => Container(),
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      getImmediateSuggestions: false,
                      hideOnEmpty: true,
                      hideOnError: true,
                      direction: AxisDirection.down,
                      hideOnLoading: true,
                      loadingBuilder: (_) => const ProgressIndicatorLoading(),
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: typeAheadController,
                          decoration: InputDecoration(
                              hintText: "   ابحث عن متجر...",
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                  child: const Icon(
                                    Icons.close,
                                    size: (24),
                                  ),
                                  onTap: () {
                                    typeAheadController.clear();
                                    MapSource.mapBloc!.filterMarkers("");
                                    // gMapBloc!.changeFilter(false);
                                  }))),
                      itemBuilder: (context, dynamic suggestion) => ListTile(
                          title: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(suggestion))),
                      suggestionsCallback: (pattern) {
                        if (typeAheadController.text.isNotEmpty) {
                          return MapSource.mapBloc!.getSuggestions(pattern);
                        }
                        return Future.value(<String>[]);
                      },
                      transitionBuilder:
                          (context, suggestionsBox, controller) =>
                              suggestionsBox,
                      onSuggestionSelected: (dynamic suggestion) {
                        typeAheadController.text = suggestion;
                        MapSource.mapBloc!.filterMarkers(suggestion);
                        MapSource.mapBloc!.setFilter(false);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ))),
          ),
        ],
      ),
    );
  }

  onTap(BuildContext context) async {
    // final provider = Provider.of<ShopFilterProvider>(context, listen: false);
    if (typeAheadController.text.trim().isNotEmpty) {
      typeAheadController.clear();
      MapSource.mapBloc!.filterMarkers("");
      MapSource.mapBloc!.setFilter(false);
    }
    FocusScope.of(context).requestFocus(FocusNode());
    // Functions.openIntent(
    //     screen: ChangeNotifierProvider.value(
    //         value: provider,
    //         child: const SearchScreen(
    //           isMapFilter: true,
    //         )),
    //     replace: false,
    //     context: context);
  }
}
