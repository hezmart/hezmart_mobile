import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/my_orders/data/data/order_repo_impl/ordeer_repository_impl.dart';
import 'package:hezmart/features/my_orders/presentations/order_bloc/order_bloc.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/theme/pallets.dart';

class Ongoing extends StatefulWidget {
  const Ongoing({super.key});

  @override
  State<Ongoing> createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  final orderbloc = OrderBloc(OrderRepositoryImpl(NetworkService()));

  @override
  void initState() {
    orderbloc.add(GetAllOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<OrderBloc, OrderState>(
          bloc: orderbloc,
          listener: _listentoOrderstate,
          builder: (context, state) {
            if (state is OrderFailiureState) {
              return SizedBox(
                height: 1.sh,
                child: Center(
                  child: AppPromptWidget(
                    onTap: () {
                      orderbloc.add(GetAllOrdersEvent());
                    },
                  ),
                ),
              );
            }
            if (state is GetAllOrderSuccesState) {
              final validStatuses = ['delivered', 'processing', 'pending', 'completed', "partially_received"];


              final pendingDelivered = state.reponse.data?.orders
                  ?.where((order) =>
              validStatuses.contains(order.status?.toLowerCase() ?? '') &&
                  order.items != null &&
                  order.items!.isNotEmpty)
                  .toList()
                ?..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

              if (pendingDelivered == null || pendingDelivered.isEmpty) {
                return SizedBox(
                  width: 1.sw,
                  height: 1.sh,
                  child: Center(child: TextView(text: "You have no orders.")),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(
                    pendingDelivered.length,
                        (onggoingContext) => InkWell(
                      onTap: () {
                        context.pushNamed(
                          PageUrl.order_details,
                          queryParameters: {
                            PathParam.id: pendingDelivered[onggoingContext].items?.first.orderId.toString() ?? ''
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              height: 110,
                              width: 90,
                              child: ImageWidget(
                                imageUrl: pendingDelivered[onggoingContext].items?.first.product?.coverImage ?? '',
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      TextView(
                                        text: "Total Item(s)",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      5.horizontalSpace,
                                      TextView(
                                        text: "${pendingDelivered[onggoingContext].items.length.toString()}",
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  TextView(
                                    text: "Order: ${pendingDelivered[onggoingContext].orderNumber ?? ''}",
                                  ),
                                  10.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: pendingDelivered[onggoingContext].status == "delivered" ||
                                          pendingDelivered[onggoingContext].status == "completed" ||
                                          pendingDelivered[onggoingContext].status == "partially_received"
                                          ? Pallets.successGreen
                                          : Pallets.grey35,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextView(
                                      text: pendingDelivered[onggoingContext].status?.toUpperCase() ?? '',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                  2.verticalSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void _listentoOrderstate(BuildContext context, OrderState state) {
    if (state is OrderLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OrderFailiureState) {
      context.pop();
    }
    if (state is GetAllOrderSuccesState) {
      context.pop();
    }
  }
}