import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/categories/data/data/category_repo_impl/category_repo.dart';
import 'package:hezmart/features/categories/domain/category_repo/category_repo.dart';
import 'package:hezmart/features/categories/presentations/category_bloc/category_bloc.dart';
import 'package:hezmart/features/categories/presentations/screens/getsubcatss.dart';

import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  int selectedIndex = 0;
  int selectedCategoryIndex = 0;

  final allcat = CategoryBloc(CategoryRepositoryImpl(NetworkService()));
  @override
  void initState() {
    // TODO: implement initState
    selectedCategoryIndex = 0;
    allcat.add(AllCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.grey95.withOpacity(0.5),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: allcat,
        listener: _listenToCategoryState,
        builder: (context, state) {
          if(state is CategoryfailiureState){
            return Center(child: AppPromptWidget(
              onTap: (){
                allcat.add(AllCategoryEvent());
              },
            ),);

          }
          if (state is CategorySuccessState) {
            final cat = state.response.data!.categories;
            return Row(
              children: [
                Container(
                  width: 100,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: cat.length,
                      itemBuilder: (context, index) {
                        bool isSelected = index == selectedCategoryIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          child: Container(
                            color: isSelected
                                ? Pallets.grey95.withOpacity(0.5)
                                : Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                            child: TextView(
                              text: cat[index].name.toString(),
                              fontSize: 13,
                            ),
                          ),
                        );
                      }

                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(PageUrl.all_products);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextView(text: "All Products"),
                                Icon(Icons.arrow_forward_ios_rounded, size: 17),
                              ],
                            ),
                          ),
                        ),
                        10.verticalSpace,

                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 1.sh,
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.verticalSpace,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: TextView(
                                    text: cat[selectedIndex].id.toString(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Divider(color: Pallets.grey95),
                                // GridView.builder(
                                //   shrinkWrap: true,
                                //   physics: NeverScrollableScrollPhysics(),
                                //   itemCount:
                                //       cat[selectedIndex].subcategories.length,
                                //   gridDelegate:
                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 3,
                                //         mainAxisSpacing: 10,
                                //         crossAxisSpacing: 10,
                                //         childAspectRatio: 0.8,
                                //       ),
                                //   itemBuilder: (context, index) {
                                //     return InkWell(
                                //       onTap: () {
                                //         context.pushNamed(
                                //           PageUrl.getsubcatss,
                                //           extra: SubCatParams(
                                //             state
                                //                 .response
                                //                 .data!
                                //                 .categories[index]
                                //                 .id
                                //                 .toString(),
                                //             state
                                //                 .response
                                //                 .data!
                                //                 .categories[index]
                                //                 .subcategories[index]
                                //                 .id
                                //                 .toString(),
                                //           ),
                                //         );
                                //       },
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Container(
                                //             padding: EdgeInsets.all(10),
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(5),
                                //               color: Pallets.grey95.withOpacity(
                                //                 0.5,
                                //               ),
                                //             ),
                                //             child: IgnorePointer(
                                //               child: ImageWidget(
                                //                 onTap: () {
                                //                   context.pushNamed(
                                //                     PageUrl.getsubcatss,
                                //                   );
                                //                 },
                                //                 imageUrl:
                                //                     cat[selectedIndex].icon
                                //                         .toString(),
                                //                 size: 40,
                                //                 fit: BoxFit.cover,
                                //               ),
                                //             ),
                                //           ),
                                //           Expanded(
                                //             child: TextView(
                                //               align: TextAlign.center,
                                //               text:
                                //                   cat[selectedIndex]
                                //                       .subcategories[index]
                                //                       .name
                                //                       .toString(),
                                //               onTap: () {
                                //                 context.pushNamed(
                                //                   PageUrl.getsubcatss,
                                //                 );
                                //               },
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // ),
                                Wrap(
                                  runSpacing: 12,
                                  spacing: 8,
                                  children: List.generate(
                                    cat[selectedCategoryIndex].subcategories.length,
                                        (index) {
                                      final subcat = cat[selectedCategoryIndex].subcategories[index];
                                      return GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                            PageUrl.getsubcatss,
                                            extra: SubCatParams(
                                              cat[selectedCategoryIndex].id.toString(),
                                              subcat.id.toString(),
                                              cat[selectedCategoryIndex].name.toString(),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.transparent,
                                              border: Border.all(
                                                color: Pallets.grey35.withOpacity(0.5),
                                              ),
                                            ),
                                            child: TextView(
                                              align: TextAlign.center,
                                              text: subcat.name.toString(),
                                              fontSize: 12,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  void _listenToCategoryState(BuildContext context, CategoryState state) {
    if (state is CategoryloadinggState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CategoryfailiureState) {
      context.pop();
    }
    if (state is CategorySuccessState) {
      context.pop();
    }
  }
}

//
// return Scaffold(
// body: Padding(
// padding: EdgeInsets.all(16),
// child:
// ),
// );
