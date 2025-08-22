import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/features/homescreen/presentations/screens/homescreen.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../data/data/repossitory_impl/repossitory_impl.dart';
import '../fav_bloc/favourite_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}
class _WishlistState extends State<Wishlist> {
  final fav = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final likeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );


  @override
  void initState() {
    context.read<FavouriteBloc>().add(GetfavouriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      CustomAppBar(
        tittle: TextView(text: "Saved Items",fontSize: 18,fontWeight: FontWeight.w500,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: BlocConsumer<FavouriteBloc, FavouriteState>(
            // bloc: fav,
  listener: _listenToFavState,
  builder: (context, state) {
    if(state is FavouritefailiureState){
    return Center(
      child: AppPromptWidget(
        onTap: (){
          context.read<FavouriteBloc>().add(GetfavouriteEvent());

        },
      ),
    );
    }
    if(state is FavouriteGetSuccessState){
      final favs=state.response.data?.likes;

if(favs!.isEmpty){
  return SizedBox(
    height: 1.sh,
    child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(text: "You have not saved any item yet"),
        20.verticalSpace,
        SizedBox(
          width: 200,
          height: 60,
          child: CustomButton(
            isExpanded: true,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {
              context.goNamed(PageUrl.home);
            },
            bgColor: Color(0xffE67002),
            child: TextView(
              text: "Browse products",
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),),
  );
  
}
      int calculateDiscountPercentage(
          String price,
          String discountPrice,
          ) {
        final double originalPrice =
            double.tryParse(price) ?? 0;
        final double discountedPrice =
            double.tryParse(discountPrice) ?? 0;

        if (discountedPrice <= 0 ||
            discountedPrice >= originalPrice)
          return 0;

        return ((1 - discountedPrice / originalPrice) * 100)
            .round();
      }
   return Padding(
     padding: EdgeInsets.only(bottom: 10),
     child: GridView.builder(
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       padding: EdgeInsets.all(10),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 0.8,
         mainAxisSpacing: 10,
         crossAxisSpacing: 10,
       ),
       itemCount: favs?.length,
       itemBuilder: (context, index) {
         return Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             border: Border.all(color: Pallets.grey95),
           ),
           child: Stack(
               children:[
                 // Row(
                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 //   children: [
                 //     Padding(
                 //       padding: const EdgeInsets.only(left: 5),
                 //       child: Icon(Icons.favorite,size: 18,color: Pallets.red,),
                 //     ),
                 //     Container(
                 //       height: 40,
                 //       width: 40,
                 //       padding: EdgeInsets.all(3),
                 //       decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                 //           bottomLeft:  Radius.circular(10)),
                 //         color:Pallets.successGreen, ),
                 //       child:
                 //       Center(child: TextView(text: "new",color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12,)),)
                 //   ],
                 // ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     InkWell(
                       onTap: () {
                         context.pushNamed(
                           PageUrl.product_details,
                           queryParameters: {
                             PathParam.id:
                             favs?[index].productId.toString(),
                           },
                         );
                       },
                       child: IgnorePointer(
                         child: ImageWidget(
                           onTap: () {
                             context.pushNamed(
                               PageUrl.product_details,
                               queryParameters: {
                                 PathParam.id:
                                 favs?[index].productId.toString(),
                               },
                             );
                           },
                           imageUrl: favs?[index].product?.coverImage??'',
                           size: 100,
                           fit: BoxFit.scaleDown,
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 5),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           InkWell(
                             splashColor: Colors.transparent,
                             onTap: () {
                               context.pushNamed(
                                 PageUrl.product_details,
                                 queryParameters: {
                                   PathParam.id:
                                   favs?[index].productId.toString(),
                                 },
                               );
                             },
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 TextView(text: favs?[index].product?.name??'',fontSize: 13,
                                 maxLines: 3,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(favs?[index].product?.discountPrice??'',style: TextStyle(fontWeight: FontWeight.w700,),),
                                     Text(favs?[index].product?.price??'',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),),
                                   ],
                                 ),
                                 StockIndicator(
                                   stockQuantity:
                                   favs?[index].product?.stockQuantity??'',
                                 ),
                               ],
                             ),
                           ),
                           3.verticalSpace,
                         ],
                       ),
                     )
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 5),
                   child: Row(
                     mainAxisAlignment:
                     MainAxisAlignment.spaceBetween,
                     children: [
                       BlocConsumer<
                           FavouriteBloc,FavouriteState>(
                         bloc: likeproduct,
                         listener: (context, state) {
                           if(state is FavouriteloadingState){
                             CustomDialogs.showLoading(context,
                                 barrierColor: Colors.transparent);
                           }
                           if(state is FavouritefailiureState){
                             context.pop();
                           }
                           if(state is FavouritelikeSuccessState){
                             context.pop();
                             CustomDialogs.showToast("Removed to favourite");
                           }
                         },
                         builder: (context, state) {
                           return CircleAvatar(
                             radius: 15,
                             backgroundColor: Pallets.white,
                             child: GestureDetector(
                               onTap: () {
                                 likeproduct.add(LikeItemEvent( favs?[index].product?.id.toString()??''));
                               },
                               child: Icon(
                                 Icons.remove_circle_outlined,
                                 size: 18,
                               ),
                             ),
                           );
                         },
                       ),
                       Container(
                         height: 30,
                         width: 55,
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topRight: Radius.circular(10),
                             bottomLeft: Radius.circular(10),
                           ),
                           color: Color(0xff3567a6),
                         ),
                         child: Center(
                           child: TextView(
                             text:
                             "${calculateDiscountPercentage(favs?[index].product?.price??'', favs?[index].product?.discountPrice??'')}% OFF",
                             color: Colors.white,
                             fontSize: 10,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),

               ]

           ),
         );
       },
     ),
   );
    }
    return SizedBox();
  },
),
        ),
      ),
    );
  }

  void _listenToFavState(BuildContext context, FavouriteState state) {


    if(state is FavouriteloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is FavouritefailiureState){
      context.pop();
    }
    if(state is FavouriteGetSuccessState){
      context.pop();
    }
  }
}
// NestedScrollView(
//     floatHeaderSlivers: true,
//     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//       return [
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 16.verticalSpace,
//                 Container(
//                   width: 1.sw,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       color: Pallets.white,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Pallets.midblue)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               const TextView(
//                                 text: "Number of Responses:",
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                                 color: Pallets.grey60,
//                               ),
//                               TextView(
//                                 text: 'hhhhf'
//                                     .toString(),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12,
//                               ),
//                             ],
//                           ),
//
//                         ],
//                       ),
//                       32.verticalSpace,
//                       TabBar(
//                         controller: _tabController,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         tabAlignment: TabAlignment.start,
//                         isScrollable: true,
//                         physics: const BouncingScrollPhysics(),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 0, vertical: 2),
//                         dividerColor: Pallets.midblue,
//                         labelStyle:
//                         const TextStyle(color: Pallets.primary),
//                         indicatorColor: Pallets.primary,
//                         labelColor: Pallets.primary,
//                         unselectedLabelColor: Pallets.grey75,
//                         unselectedLabelStyle:
//                         const TextStyle(color: Pallets.grey75),
//                         labelPadding:
//                         const EdgeInsets.only(bottom: 15, right: 20),
//                         tabs: const [
//                           // TextView(text: "Summary"),
//                           Text(
//                             "Summary",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             "Individual Responses",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             "Deleted Responses",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           // TextView(text: "Individual Responses"),
//                           // TextView(text: "Deleted Responses"),
//                         ],
//                       ),
//                       32.verticalSpace,
//                       _tabController.index == 1
//                           ? Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//
//                               SizedBox(),
//                               Builder(builder: (context) {
//                                 return InkWell(
//                                   splashColor: Colors.transparent,
//
//                                   child: const Icon(
//                                       Icons.file_download_outlined),
//                                 );
//                               }),
//                             ],
//                           ),
//                           15.verticalSpace,
//
//                           32.verticalSpace,
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//
//                                 style: ButtonStyle(
//                                     side: MaterialStateProperty
//                                         .resolveWith(
//                                           (states) => const BorderSide(
//                                         color: Pallets.midblue,
//                                       ),
//                                     ),
//                                     shape:
//                                     MaterialStateProperty.all(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius
//                                                 .circular(
//                                                 10)))),
//                                 onPressed: () {  },
//                                 child: const TextView(
//                                   text: "Add Filter",
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                           20.verticalSpace,
//                         ],
//                       )
//                           : SizedBox()
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ];
//     },
//     body: TabBarView(
//         controller: _tabController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//          HomeScreen(),
//          HomeScreen(),
//          HomeScreen(),
//         ],
//       ),
//     ),