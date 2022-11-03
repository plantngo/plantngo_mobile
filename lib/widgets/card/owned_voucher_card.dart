import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/voucher_shop_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

import '../../providers/customer_provider.dart';

class OwnedVoucherCard extends StatefulWidget {
  final Voucher voucher;

  OwnedVoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  State<OwnedVoucherCard> createState() => _OwnedVoucherCardState();
}

class _OwnedVoucherCardState extends State<OwnedVoucherCard> {
  int hash32(int h) {
    h ^= h >>> 33;
    h *= 0x0c34ff51;
    h ^= h >>> 33;
    h ^= h >>> 33;
    return h;
  }

  String formatVoucher(int h) {
    String converted = h.toString();
    String result = "";
    for (var i = 0; i < converted.length; i++) {
      if (i % 4 == 0 && i != 0) {
        result = "$result-";
      }
      result = result + converted[i];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var voucherShopProvider =
        Provider.of<VoucherShopProvider>(context, listen: true);
    var rewardName = widget.voucher.description ?? "";

    int voucherID = hash32(widget.voucher.id!);

    rewardName = rewardName.toUpperCase();

    String voucherID_string = formatVoucher(voucherID);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              stops: [0.02, 0.02],
              colors: [Colors.greenAccent, Colors.white],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ListTile(
                          leading: const Image(
                              image: AssetImage('assets/icon/voucher.png')),
                          title: Text(rewardName,
                              style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, bottom: 4, top: 10),
                              child: SizedBox(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    backgroundColor: const Color.fromARGB(
                                        255, 213, 116, 230),
                                  ).copyWith(
                                    elevation: ButtonStyleButton.allOrNull(0.0),
                                  ),
                                  child: const Text(
                                    'Redeem',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Center(
                                            child: Text(
                                              "$rewardName",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        content: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxHeight: 120),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 10,
                                                child: SizedBox.expand(
                                                  child: Container(
                                                    color: Colors.green[100],
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Redemption Code",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "$voucherID_string",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  "(NOTE: Voucher will be used upon Confirm)",
                                                  style: TextStyle(
                                                    color: Colors.red[900],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actionsAlignment: MainAxisAlignment.end,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, "Cancel");
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              customerProvider.useVoucher(
                                                  context, widget.voucher);

                                              Navigator.pop(context, "Confirm");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content:
                                                      Text('Voucher Redeemed!'),
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                ),
                                              );
                                            },
                                            child: const Text("Confirm"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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
  }
}
