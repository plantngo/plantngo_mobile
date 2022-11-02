//  openDialog(
//                   context,
//                   merchantProductList[i],
//                   customerMerchantOrder != null &&
//                           customerMerchantOrder!.orderItems!.isNotEmpty &&
//                           customerMerchantOrder!.orderItems!
//                               .where((element) =>
//                                   element.productId ==
//                                   merchantProductList[i].id)
//                               .isNotEmpty
//                       ? customerMerchantOrder!.orderItems!
//                           .where((element) =>
//                               element.productId == merchantProductList[i].id)
//                           .first
//                           .quantity!
//                       : 0,
//                 );





//                  void updateOrderItem(int productId, int updatedQuantity) {}
//   final TextEditingController textEditingController = TextEditingController();
//   Future openDialog(
//     BuildContext context,
//     Product merchantProduct,
//     int quantity,
//   ) =>
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             actionsAlignment: MainAxisAlignment.center,
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//               Radius.circular(8),
//             )),
//             actions: [
//               ElevatedButton(onPressed: () {}, child: Text("Add to cart")),
//             ],
//             title: Text(
//               merchantProduct.name!,
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             content: Builder(
//               builder: (context) {
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 15,
//                     ),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(
//                         merchantProduct.imageUrl!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     // Text(
//                     //   "\$${merchantProduct.price!.toStringAsFixed(2)}",
//                     //   style: Theme.of(context).textTheme.caption,
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.remove)),
//                         ConstrainedBox(
//                           constraints: const BoxConstraints(minWidth: 50),
//                           child: IntrinsicWidth(
//                             child: TextField(
//                               controller: textEditingController,
//                               textAlign: TextAlign.center,
//                               textAlignVertical: TextAlignVertical.center,
//                               decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.zero,
//                                 border: OutlineInputBorder(),
//                               ),
//                               keyboardType: TextInputType.number,
//                               inputFormatters: <TextInputFormatter>[
//                                 FilteringTextInputFormatter.digitsOnly
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             updateOrderItem(merchantProduct.id!, quantity);
//                           },
//                           icon: const Icon(
//                             Icons.add,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       );