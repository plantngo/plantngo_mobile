import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/services/merchant_search_service.dart';

class OrderDetailsScreen extends StatelessWidget {
  Order order;
  OrderDetailsScreen({
    super.key,
    required this.order,
  });
  DraggableScrollableController scrollController =
      DraggableScrollableController();

  Map<String, String> orderStatusMessage = {
    "CREATED":
        "Your Order has not been confirmed yet!\n Please checkout the items in your cart to confirm the order.",
    "PENDING":
        "Your order is Pending the merchant's confirmation!\nPlease hold while the merchant reviews your order.",
    "FULFILLED": "Order has been fulfilled!",
    "CANCELLED": "Your order is has been Cancelled by the merchant!"
  };

  Map<String, String> orderStatusImage = {
    "CREATED": "assets/graphics/created_order.svg",
    "PENDING": "assets/graphics/pending_order.svg",
    "FULFILLED": "assets/graphics/fulfilled_order.svg",
    "CANCELLED": "assets/graphics/cancelled_order.svg"
  };

  Map<String, String> orderStatusState = {
    "CREATED": "Order Created",
    "PENDING": "Order Pending",
    "FULFILLED": "Order Fulfilled",
    "CANCELLED": "Order Cancelled"
  };

  renderOrderStatus(context, Order order) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 200,
          child: SvgPicture.asset(orderStatusImage[order.orderStatus!]!),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            orderStatusMessage[order.orderStatus!]!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Order #${order.id!.toString().padLeft(5, '0')}",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (p0, p1) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    orderStatusState[order.orderStatus!]!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  renderOrderStatus(context, order),
                ],
              );
            },
          ),
          DraggableScrollableSheet(
            controller: scrollController,
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.25)),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 19,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey.shade300,
                        ),
                        child: SizedBox(
                          height: 5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            order.merchant!.company,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.orderItems!.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        final result = order.orderItems![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: Image.network(
                                        result.product!.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              Spacer(flex: 1),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  result.product!.name!,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Spacer(flex: 1),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${result.quantity!} pc(s)",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Spacer(flex: 1),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "S\$${(result.price! * result.quantity!).toStringAsFixed(2)}",
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.isDineIn!
                                    ? "Dining-In"
                                    : "Takeaway/Self-Collection",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Carbon Emission:",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${order.orderItems!.fold<double>(0, (p, e) => p + e.product!.carbonEmission!).toStringAsFixed(2)} gCO2e",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price:",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "S\$${order.orderItems!.fold<double>(0, (p, e) => p + e.price!).toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
