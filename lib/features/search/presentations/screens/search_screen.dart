import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/search/data/data/repo_impl/repo_impl.dart';
import 'package:hezmart/features/search/domain/repo.dart';
import 'package:hezmart/features/search/presentations/bloc/all_sub_cat_bloc.dart';

import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../categories/presentations/screens/getsubcatss.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  final _searchController = TextEditingController();
  bool showSuggestions = true;

  final allsubcat = AllSubCatBloc(
    AllSubCategoriesRepositoryImpl(NetworkService()),
  );
  final productSearch = AllSubCatBloc(
    AllSubCategoriesRepositoryImpl(NetworkService()),
  );

  @override
  void initState() {
    super.initState();
    allsubcat.add(GetAllSubCatEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String searchTerm) {
    setState(() {
      query = searchTerm;
      showSuggestions = searchTerm.isEmpty;
    });

    if (searchTerm.isNotEmpty) {
      productSearch.add(SearchProductEvent(searchTerm));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: CupertinoSearchTextField(
          controller: _searchController,
          prefixIcon: const Icon(CupertinoIcons.search, size: 20),
          suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill, size: 18),
          autofocus: true,
          autocorrect: true,
          placeholder: 'Search products only...',
          placeholderStyle: TextStyle(
            color: CupertinoColors.placeholderText.withOpacity(0.7),
            fontSize: 14,
          ),
          style: const TextStyle(fontSize: 14),
          onChanged: performSearch,
          onSubmitted: (val) {
            FocusScope.of(context).unfocus();
            performSearch(val);
          },
          onSuffixTap: () {
            setState(() {
              _searchController.clear();
              query = '';
              showSuggestions = true;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (showSuggestions && query.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'All Categories',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    8.verticalSpace,
                    BlocBuilder<AllSubCatBloc, AllSubCatState>(
                      bloc: allsubcat,
                      builder: (context, state) {
                        if (state is AllSubCatloadingState) {
                          return Row(
                            children: List.generate(
                              3,
                                  (index) => Container(
                                width: 100,
                                height: 30,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Pallets.grey95,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        }
                        if (state is AllSubCatSuccessState) {
                          final suggestions =
                              state.respomse.data?.subcategories ?? [];
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(suggestions.length, (index) {
                              final subCat = suggestions[index];
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    PageUrl.getsubcatss,
                                    extra: SubCatParams(
                                      subCat.categoryId.toString(),
                                      subCat.id.toString(),
                                      subCat.name.toString(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Pallets.grey95,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    subCat.name ?? '',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              );
                            }),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              )
            else if (query.isNotEmpty)
              BlocBuilder<AllSubCatBloc, AllSubCatState>(
                bloc: productSearch,
                builder: (context, state) {
                  if (state is AllSubCatloadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchSuccessState) {
                    final results = state.respomse.data?.results ?? [];

                    // Filter to show only products that match the search query
                    final filteredProducts = results.where((item) {
                      final productName = item.name?.toLowerCase() ?? '';
                      // final categoryName = item.category?.name?.toLowerCase() ?? '';
                      final subCategoryName = item.subCategory?.name?.toLowerCase() ?? '';

                      return productName.contains(query.toLowerCase()) ||
                          // categoryName.contains(query.toLowerCase()) ||
                          subCategoryName.contains(query.toLowerCase());
                    }).toList();

                    if (filteredProducts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: [
                            const Center(
                              child: Text('No products found'),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              logger.w(product.id);
                              print(product.id);
                              context.pushNamed(
                                PageUrl.product_details,
                                queryParameters: {
                                  PathParam.id: product.id.toString(),
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Pallets.grey95.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: product.coverImage != null
                                        ? Image.network(product.coverImage!, fit: BoxFit.cover)
                                        : Icon(Icons.shopping_bag, color: Pallets.grey75),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: product.name ?? '',
                                          maxLines: 2,
                                          textOverflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          ' ${product.subCategory?.name ?? ''}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is AllSubCatfailuireState) {
                    return Center(child: Text('Oops! an error occurred: ${state.error}'));
                  }
                  return const SizedBox();
                },
              )
            else
              const Center(child: Text('No results found')),
          ],
        ),
      ),
    );
  }
}
// class _SearchScreenState extends State<SearchScreen> {
//   String query = "";
//   final _searchController = TextEditingController();
//   bool showSuggestions = true;
//
//   final allsubcat = AllSubCatBloc(
//     AllSubCategoriesRepositoryImpl(NetworkService()),
//   );
//   final search = AllSubCatBloc(
//     AllSubCategoriesRepositoryImpl(NetworkService()),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     allsubcat.add(GetAllSubCatEvent());
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void performSearch(String searchTerm) {
//     setState(() {
//       query = searchTerm;
//       showSuggestions = searchTerm.isEmpty;
//     });
//
//     if (searchTerm.isNotEmpty) {
//       search.add(SearchProductEvent(searchTerm));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         tittle: CupertinoSearchTextField(
//           controller: _searchController,
//           prefixIcon: const Icon(CupertinoIcons.search, size: 20),
//           suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill, size: 18),
//           autofocus: true,
//           autocorrect: true,
//           placeholder: 'Search products only...',
//           placeholderStyle: TextStyle(
//             color: CupertinoColors.placeholderText.withOpacity(0.7),
//             fontSize: 14,
//           ),
//           style: const TextStyle(fontSize: 14),
//           onChanged: performSearch,
//           onSubmitted: (val) {
//             FocusScope.of(context).unfocus();
//             performSearch(val);
//           },
//           onSuffixTap: () {
//             setState(() {
//               _searchController.clear();
//               query = '';
//               showSuggestions = true;
//             });
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if (showSuggestions && query.isEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'All Categories',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     8.verticalSpace,
//                     BlocBuilder<AllSubCatBloc, AllSubCatState>(
//                       bloc: allsubcat,
//                       builder: (context, state) {
//                         if (state is AllSubCatloadingState) {
//                           return Row(
//                             children: List.generate(
//                               3,
//                               (index) => Container(
//                                 width: 100,
//                                 height: 30,
//                                 margin: const EdgeInsets.only(right: 8),
//                                 decoration: BoxDecoration(
//                                   color: Pallets.grey95,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         if (state is AllSubCatSuccessState) {
//                           final suggestions =
//                               state.respomse.data?.subcategories ?? [];
//                           return Wrap(
//                             spacing: 8,
//                             runSpacing: 8,
//                               // children: List.generate(suggestions.take(10).length,
//                             children: List.generate(suggestions.length, (
//                               index,
//                             ) {
//                               final subCat = suggestions[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   context.pushNamed(
//                                     PageUrl.getsubcatss,
//                                     extra: SubCatParams(
//                                       subCat.categoryId.toString(),
//                                       subCat.id.toString(),
//                                       subCat.name.toString(),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 8,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Pallets.grey95,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     subCat.name ?? '',
//                                     style: const TextStyle(fontSize: 13),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           );
//                         }
//                         return const SizedBox();
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             else if (query.isNotEmpty)
//               Expanded(
//                 child: BlocBuilder<AllSubCatBloc, AllSubCatState>(
//                   bloc: search,
//                   builder: (context, state) {
//                     if (state is AllSubCatloadingState) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (state is SearchSuccessState) {
//                       final rawResults = (state.respomse.data?.results ?? []).where((item) {
//                         final name = item.subCategory?.name?.toLowerCase() ?? '';
//                         return name.contains(query.toLowerCase());
//                       }).toList();
//
//                       final seenCategories = <String>{};
//                       final results = rawResults.where((item) {
//                         final categoryName = item.category?.name ?? '';
//                         if (seenCategories.contains(categoryName)) return false;
//                         seenCategories.add(categoryName);
//                         return true;
//                       }).toList();
//
//                       if (results.isEmpty) {
//                         return const Center(
//                           child: Text('No matching category found'),
//                         );
//                       }
//
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: List.generate(
//                           results.length,
//                               (indexcontext) => Padding(
//                                 padding: const EdgeInsets.only(bottom: 10),
//                                 child: InkWell(
//                                   splashColor: Colors.transparent,
//                                                           onTap: () {
//                                 context.pushNamed(
//                                   PageUrl.getsubcatss,
//                                   extra: SubCatParams(
//                                     results[indexcontext].category!.id.toString(),
//                                     results[indexcontext].subCategory!.id.toString(),
//                                     results[indexcontext].category?.name ?? '',
//                                   ),
//                                 );
//                                                           },
//                                                           child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                                 child:
//                                 Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.01),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         width: 50,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Pallets.grey95.withOpacity(0.6),
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Icon(Icons.shopping_bag, color: Pallets.grey75),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               results[indexcontext].name ?? '',
//                                               style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               results[indexcontext].category?.name ?? '',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.grey[600],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//
//                                 // Container(
//                                 //   padding: const EdgeInsets.all(10),
//                                 //   child: Column(
//                                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                                 //     children: [
//                                 //       TextView(
//                                 //         text: results[indexcontext].subCategory?.name ?? '',
//                                 //       ),
//                                 //       const Divider(color: Pallets.grey95),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                                           ),
//                                                         ),
//                                                       ),
//                               ),)
//                       );
//                     }
//
//
//                     if (state is AllSubCatfailuireState) {
//                       return Center(child: Text('Oops! an error occurred'));
//                     }
//                     return const SizedBox();
//                   },
//                 ),
//               )
//             else
//               const Center(child: Text('No results found')),
//           ],
//         ),
//       ),
//     );
//   }
// }
