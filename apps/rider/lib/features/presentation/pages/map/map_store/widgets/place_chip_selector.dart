import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/city.dart';

class PlaceChipSelector extends StatelessWidget {
  final List<CitiesList>? cityList;

  const PlaceChipSelector({Key? key, this.cityList}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      trailing: const Icon(Icons.location_city),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
              child: Text("اختر المحافظة ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Flexible(
              child: TextButton(
                  onPressed: () => cancel(cityList!),
                  child: const Text("إلغاء ")))
        ],
      ),
      subtitle: Container(decoration: DottedDecoration()));

  void cancel(List<CitiesList> list) => {
        list.forEach((CitiesList element) => element.isSelected = false),
      };
}
