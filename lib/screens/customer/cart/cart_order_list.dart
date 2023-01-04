import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/orderitem.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_screen.dart';
import 'package:plantngo_frontend/services/customer_order_service.dart';
import 'package:plantngo_frontend/services/merchant_search_service.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';

class CartOrderList extends StatelessWidget {
  Order order;
  bool selected;
  int index;
  Function(bool, int) onCheckboxChanged;
  Function() refreshHook;
  bool isDineIn;
  Function(bool newValue, int i) onIsDineInChanged;
  CartOrderList(
      {super.key,
      required this.order,
      required this.selected,
      required this.index,
      required this.onCheckboxChanged,
      required this.refreshHook,
      required this.isDineIn,
      required this.onIsDineInChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor:
                        Theme.of(context).colorScheme.secondary,
                  ),
                  child: Checkbox(
                    checkColor: Theme.of(context).colorScheme.secondary,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: selected,
                    onChanged: (value) {
                      onCheckboxChanged(value!, index);
                    },
                  ),
                ),
                Text(
                  order.merchant!.company,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  MerchantSearchService()
                      .searchMerchantByUsername(
                          context, order.merchant!.username)
                      .then(
                        (merchant) => Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => MerchantShopScreen(
                                  merchant: merchant!,
                                ),
                              ),
                            )
                            .then((value) => {refreshHook()}),
                      );
                },
                child: Text(
                  "Edit Order",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
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
                      formatMoney.format(result.price!),
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
                    isDineIn ? "Dining-In" : "Takeaway/Self-Collection",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Wrap(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Takeaway/Self-Collection",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  onTap: () {
                                    onIsDineInChanged(false, index);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                order.merchant!.username != 'fairprice'
                                    ? ListTile(
                                        title: Text(
                                          "Dining-In",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        onTap: () {
                                          onIsDineInChanged(true, index);
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "Change Dining Mode",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
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
                    formatEmissionLong.format(order.orderItems!.fold<double>(
                        0,
                        (p, e) =>
                            p + e.product!.carbonEmission! * e.quantity!)),
                    style: Theme.of(context).textTheme.caption!.copyWith(),
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
                    formatMoney.format(order.orderItems!
                        .fold<double>(0, (p, e) => p + (e.price!))),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
