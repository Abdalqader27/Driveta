// import 'package:flutter/material.dart';
// import 'package:i_am_here/Database/app_db/app_db.dart';
// import 'package:i_am_here/Helper/Utils/storage/shared_preference_user.dart';
// import 'package:i_am_here/Helper/constant/objects.dart';
// import 'package:i_am_here/Models/shop_model.dart';
// import 'package:i_am_here/Views/guide/components/custom_multi_select_grid.dart';
// import 'package:provider/provider.dart';
//
// enum PageName {
//   categories,
//   shops,
//   images,
// }
//
// class ShopFilterProvider extends ChangeNotifier {
//   final TextEditingController areaController = TextEditingController();
//   GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   List<Category> _leafsCategories = [];
//   late final List<Category> cacheLeafsCategories;
//   Map<int, CategoryWithParent> _categoryChildren = {};
//   late final int _rootId;
//   late final int _cityId;
//   int _pageNumber = 1;
//   List<int> _selectedAreasIds = [];
//   List<int> _selectedCategories = [];
//   List<int> _areasIds = [];
//   String? _searchShopText = '';
//   String? _searchImagesText = '';
//   String? _searchCategoriesText = '';
//   String _searchAreaText = '';
//   bool _isFiltered = false;
//   bool _isShown = false;
//   int _shopsCount = 0;
//   int _imagesCount = 0;
//   late PageName _pageName;
//   Stream<List<ShopModel>>? _shopsItemsStream;
//   Future<List<Ad>>? _shopsImagesFuture;
//
//   ShopFilterProvider(List<Category> categories) {
//     if (categories.length == 1) {
//       _rootId = categories.first.id;
//       if (categories.first.isParent) {
//         _pageName = PageName.categories;
//       } else {
//         _pageName = PageName.shops;
//       }
//     } else {
//       _pageName = PageName.shops;
//
//       _rootId = -1;
//     }
//     init(categories);
//   }
//
//   GlobalKey<AnimatedListState> get listKey => _listKey;
//
//   bool get isFiltered => _isFiltered;
//
//   List<int> get areasIds => _areasIds;
//
//   List<int> get selectedAreasIds => _selectedAreasIds;
//
//   int get pageNumber => _pageNumber;
//
//   List<int> get selectedCategories => _selectedCategories;
//
//   Map<int, CategoryWithParent> get categoryChildren => _categoryChildren;
//
//   int? get cityId => _cityId;
//
//   bool get isShown => _isShown;
//
//   Stream<List<ShopModel>>? get shopsItemsStream => _shopsItemsStream;
//
//   Future<List<Ad>>? get shopsImagesFuture => _shopsImagesFuture;
//
//   int get imagesCount => _imagesCount;
//
//   int get shopsCount => _shopsCount;
//
//   PageName get pageName => _pageName;
//
//   String get searchAreaText => _searchAreaText;
//
//   List<Category> get leafsCategories => _leafsCategories;
//
//   set listKey(GlobalKey<AnimatedListState> value) {
//     _listKey = value;
//     notifyListeners();
//   }
//
//   set selectedAreasIds(List<int> value) {
//     _selectedAreasIds = value;
//     notifyListeners();
//   }
//
//   set areasIds(List<int> value) {
//     _areasIds = value;
//
//     notifyListeners();
//   }
//
//   set isFiltered(bool value) {
//     _isFiltered = value;
//     notifyListeners();
//   }
//
//   set rootId(int value) {
//     _rootId = value;
//     notifyListeners();
//   }
//
//   set pageNumber(int value) {
//     _pageNumber = value;
//     notifyListeners();
//   }
//
//   set selectedCategories(List<int> value) {
//     _selectedCategories = value;
//     notifyListeners();
//   }
//
//   set isShown(bool value) {
//     _isShown = value;
//     notifyListeners();
//   }
//
//   set categoryChildren(Map<int, CategoryWithParent> value) {
//     _categoryChildren = value;
//     notifyListeners();
//   }
//
//   set pageName(PageName value) {
//     _pageName = value;
//     notifyListeners();
//   }
//
//   set searchAreaText(String value) {
//     _searchAreaText = value;
//     notifyListeners();
//   } // set searchShopsText(String value) {
//   //   _searchShopsText = value;
//   //   updateShopsCount();
//   //   _shopsItemsStream = appDatabase.shopsDAO.watchAllFiltered(
//   //       _selectedCategories, _selectedAreasIds, [_cityId], searchShopsText);
//   //   notifyListeners();
//   // }
//
//   set shopsCount(int value) {
//     _shopsCount = value;
//     notifyListeners();
//   }
//
//   set imagesCount(int value) {
//     _imagesCount = value;
//     notifyListeners();
//   }
//
//   set leafsCategories(List<Category> value) {
//     _leafsCategories = value;
//     notifyListeners();
//   }
//
//   setShopsItemsStream() {
//     _shopsItemsStream = appDatabase.shopsDAO.watchAllFiltered(
//         _selectedCategories, _selectedAreasIds, [_cityId], _searchShopText);
//     notifyListeners();
//   }
//
//   Future<List<ShopModel>> getShopsItemsMapFuture() async {
//     var result = await appDatabase.shopsDAO.getAllFilteredMap(
//         _selectedCategories, _selectedAreasIds, [_cityId], '');
//     return result;
//   }
//
//   setImagesFuture() {
//     _shopsImagesFuture = appDatabase.shopsDAO.getAllFilteredWithImage(
//         selectedCategories, [cityId], selectedAreasIds,
//         searchText: _searchImagesText);
//     notifyListeners();
//   }
//
//   getCityId() async {
//     _cityId = await UserLocalDataProvider.getUser('userInfo')
//         .then((value) => value.cityId);
//   }
//
//   init(List<Category> categories) async {
//     await getCityId();
//     if (categories.length == 1) {
//       leafsCategories = await getDirectLeaf(categories.first);
//       cacheLeafsCategories = List.from(leafsCategories);
//       await insert(
//         categories.first.id,
//         null,
//         CategoryWithParent(
//             parentCategory: categories.first,
//             parentId: -1,
//             categories: await getDirectLeaf(categories.first),
//             index: 0),
//       );
//     } else {
//       await insert(
//         -1,
//         null,
//         CategoryWithParent(
//
//             ///default category
//             parentCategory: Category(
//                 name: 'التصنيفات',
//                 isParent: true,
//                 id: -1,
//                 parentCategoryId: -2,
//                 image: '',
//                 logo: ''),
//             parentId: -2,
//             categories: categories,
//             index: 0),
//       );
//     }
//     getSelected();
//   }
//
//   insert(int key, int? parentKey, CategoryWithParent value) {
//     ///parent key is null for parent category,
//     ///therefore we don't care for this level (root level which contain all app categories)
//     if (parentKey != null) {
//       _categoryChildren[parentKey]?.children.add(key);
//     }
//
//     ///actually here we add new level
//     _categoryChildren[key] = value;
//
//     ///this condition for first insert because the list_key will not have stable state in init context
//     if (value.index != 0) insertInList(value.index);
//     notifyListeners();
//   }
//
//   remove(int? key) {
//     /// on every deselecting event we need to remove sub levels that is related to this category
//     if (_categoryChildren.containsKey(key)) {
//       /// if level have sub levels we need to remove them
//       if (_categoryChildren[key]!.children.isNotEmpty) {
//         for (int? key in _categoryChildren[key]!.children) {
//           remove(key);
//         }
//       }
//
//       /// this index well helping for removing effect
//       final index = _categoryChildren[key]!.index;
//
//       ///shift all under levels (this for avoid error when we remove intermediate level)
//       for (CategoryWithParent c in _categoryChildren.values) {
//         if (c.index > index) c.index--;
//       }
//
//       ///call remove from list to show remove effect
//       removeFromList(index, _categoryChildren[key]);
//
//       ///remove level
//       _categoryChildren.remove(key);
//     }
//     notifyListeners();
//   }
//
//   ///this well show nice inserting effect ^_^
//   insertInList(int index) {
//     _listKey.currentState?.insertItem(index);
//   }
//
//   ///this well show nice removing effect ^_^
//   removeFromList(int index, CategoryWithParent? categoryWithParent) {
//     _listKey.currentState?.removeItem(index, (_, animation) {
//       return CustomMultiSelectGrid(
//         animation: animation,
//         title: categoryWithParent!.parentCategory.name,
//         items: categoryWithParent.categories!.map((e) => e).toList(),
//         titlesList: categoryWithParent.categories!.map((e) => e.name).toList(),
//         onChange: (_, __, ___) {},
//         selectedItems: categoryWithParent.selectedCategories,
//       );
//     });
//   }
//
//   ///update selected in level[key]
//   updateSelected(int? key, List<Category> value) {
//     _categoryChildren[key]!.selectedCategories = value;
//     notifyListeners();
//   }
//
//   reset() {
//     selectedAreasIds = [];
//     areasIds = [];
//     selectedCategories = [];
//     final root = _categoryChildren.values.first;
//     _categoryChildren.clear();
//     insert(
//         _rootId,
//         null,
//         CategoryWithParent(
//             categories: root.categories,
//             parentCategory: root.parentCategory,
//             parentId: null,
//             index: 0));
//     getSelected();
//   }
//
//   getSelected({bool isMap = false}) async {
//     List<Category> result = [];
//     for (CategoryWithParent categoryWithParent in _categoryChildren.values) {
//       if (categoryWithParent.selectedCategories.isEmpty) {
//         result.add(categoryWithParent.parentCategory);
//       } else {
//         for (Category c in categoryWithParent.selectedCategories) {
//           if (_categoryChildren.containsKey(c.id)) continue;
//           result.add(c);
//         }
//       }
//     }
//     final isSelectCategories = result.first.id != _rootId;
//     List<Category?> finalResult = [];
//     if ((_rootId == -1 && isSelectCategories) || _rootId != -1) {
//       await getAllLeaf(result, finalResult);
//     }
//     selectedCategories = finalResult.map((e) => e!.id).toList();
//     selectedAreasIds = List.from(_areasIds);
//     isFiltered = selectedAreasIds.isNotEmpty || isSelectCategories;
//     if (!isMap) {
//       updateShopsCount();
//       setShopsItemsStream();
//       if (_rootId != -1) {
//         updateImagesCount();
//         setImagesFuture();
//       }
//     }
//   }
//
//   updateShopsCount() async {
//     shopsCount = await appDatabase.shopsDAO.getAllFilteredCount(
//         _selectedCategories, areasIds, [cityId], _searchShopText);
//   }
//
//   updateImagesCount() async {
//     imagesCount = await appDatabase.shopsDAO
//         .getAllFilteredWithImage(
//             _selectedCategories, [cityId], _selectedAreasIds,
//             searchText: _searchImagesText)
//         .then((value) => value.length);
//   }
//
//   Future<List<Category>> getDirectLeaf(Category category) async {
//     List<Category> result = [];
//     if (category.isParent) {
//       result =
//           await appDatabase.categoriesDAO.getAllByParent(category.id, cityId);
//     }
//     return result;
//   }
//
//   getAllLeaf(List<Category> list, List<Category?> result,
//       {bool parentIfLeaf = false}) async {
//     if (list.isEmpty) return;
//     for (Category c in list) {
//       if (c.isParent) {
//         final r = await appDatabase.categoriesDAO.getAllByParent(c.id, cityId);
//         final List<Category> temp = [];
//         for (Category c in r) {
//           if (!c.isParent) {
//             result.add(c);
//           } else {
//             temp.add(c);
//           }
//         }
//         await getAllLeaf(temp, result);
//       } else if (!parentIfLeaf || result.isNotEmpty) {
//         result.add(c);
//       }
//     }
//   }
//
//   onCategoriesSearch() {
//     if (_searchCategoriesText?.trim().isNotEmpty ?? false) {
//       leafsCategories = cacheLeafsCategories
//           .where((element) => element.name.contains(_searchCategoriesText!))
//           .toList();
//     } else {
//       leafsCategories = cacheLeafsCategories;
//     }
//   }
//
//   void onSearch(String? searchText) {
//     switch (pageName) {
//       case PageName.shops:
//         if (!trimCompare(searchText, _searchShopText)) {
//           _searchShopText = searchText;
//           updateShopsCount();
//           setShopsItemsStream();
//         }
//         break;
//       case PageName.images:
//         if (!trimCompare(searchText, _searchImagesText)) {
//           _searchImagesText = searchText;
//           updateImagesCount();
//           setImagesFuture();
//         }
//         break;
//       case PageName.categories:
//         if (!trimCompare(searchText, _searchCategoriesText)) {
//           _searchCategoriesText = searchText;
//           onCategoriesSearch();
//         }
//         break;
//     }
//   }
//
//   bool trimCompare(String? v1, String? v2) {
//     return v1?.trim() == v2?.trim();
//   }
//
//   pageListener(int index) {
//     if (cacheLeafsCategories.isEmpty) index++;
//     switch (index) {
//       case 0:
//         pageName = PageName.categories;
//         break;
//       case 1:
//         pageName = PageName.shops;
//         break;
//       case 2:
//         pageName = PageName.images;
//         break;
//     }
//   }
//
//   static ShopFilterProvider of(BuildContext context) {
//     return Provider.of<ShopFilterProvider>(context, listen: false);
//   }
//
//   String? getSearchValue() {
//     switch (pageName) {
//       case PageName.shops:
//         return _searchShopText;
//       case PageName.images:
//         return _searchImagesText;
//       case PageName.categories:
//         return _searchCategoriesText;
//     }
//   }
// }
//
// class CategoryWithParent {
//   List<Category>? categories = [];
//   List<int?> children = [];
//   List<Category> selectedCategories = [];
//   Category parentCategory;
//   int? parentId;
//   int index;
//
//   CategoryWithParent(
//       {this.categories,
//       this.parentId,
//       required this.parentCategory,
//       required this.index});
//
//   factory CategoryWithParent.copy(CategoryWithParent categoryWithParent) {
//     final copy = CategoryWithParent(
//       parentCategory: categoryWithParent.parentCategory,
//       index: categoryWithParent.index,
//       parentId: categoryWithParent.parentId,
//       categories: categoryWithParent.categories,
//     );
//     copy.selectedCategories = List.from(categoryWithParent.selectedCategories);
//     copy.children = categoryWithParent.children;
//     return copy;
//   }
// }
