import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantShopUpdateOrder extends StatefulWidget {
  Product merchantProduct;
  Order? order;
  Future Function(int, int) updateCustomerMerchantOrder;
  MerchantShopUpdateOrder({
    super.key,
    required this.merchantProduct,
    required this.order,
    required this.updateCustomerMerchantOrder,
  });

  @override
  State<MerchantShopUpdateOrder> createState() =>
      _MerchantShopUpdateOrderState();
}

class _MerchantShopUpdateOrderState extends State<MerchantShopUpdateOrder> {
  late int quantity;
  late int originalQuantity;
  bool itemExisted = false;

  setInitialQuantity() {
    if (widget.order == null ||
        widget.order!.orderItems == null ||
        widget.order!.orderItems!
            .where((e) => e.productId == widget.merchantProduct.id)
            .isEmpty) {
      return 0;
    }

    return widget.order!.orderItems!
        .where((e) => e.productId == widget.merchantProduct.id)
        .first
        .quantity;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = setInitialQuantity();
    originalQuantity = quantity;
    if (quantity > 0) {
      itemExisted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            stretch: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.merchantProduct.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          widget.merchantProduct.name!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        CarbonTag(
                            text: formatEmissionLong.format(
                                widget.merchantProduct.carbonEmission!)),
                        SizedBox(width: 5),
                        Tag(
                          text:
                              formatMoney.format(widget.merchantProduct.price!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      children: [
                        Text(
                          widget.merchantProduct.description!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 0) {
                        setState(() {
                          quantity -= 1;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      color: quantity <= 0
                          ? Colors.grey.shade200
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text("$quantity"),
                  IconButton(
                    onPressed: () {
                      if (quantity < 99) {
                        setState(() {
                          quantity += 1;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: itemExisted && quantity <= 0
                          ? MaterialStateProperty.all(Colors.red)
                          : quantity == originalQuantity
                              ? MaterialStateProperty.all(Colors.grey.shade400)
                              : MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary)),
                  onPressed: originalQuantity == quantity
                      ? null
                      : () {
                          if (quantity <= 0 && !itemExisted) {
                            // error
                            showSnackBar(
                                context, "Please enter an amount more than 0!");
                          } else {
                            widget.updateCustomerMerchantOrder(
                              widget.merchantProduct.id!,
                              quantity,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                  child: Text(
                    itemExisted && quantity <= 0
                        ? "Remove from cart"
                        : itemExisted
                            ? "Update cart"
                            : "Add to cart",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
