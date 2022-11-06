import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/promotion.dart';
import 'package:share_plus/share_plus.dart';

class MerchantPromotionDetailsScreen extends StatefulWidget {
  Promotion promotion;

  MerchantPromotionDetailsScreen({
    super.key,
    required this.promotion,
  });

  @override
  State<MerchantPromotionDetailsScreen> createState() =>
      _MerchantPromotionDetailsScreenState();
}

class _MerchantPromotionDetailsScreenState
    extends State<MerchantPromotionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: BackButton(color: Colors.white),
              title: Text(
                "Promotion",
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Share.share(widget.promotion.bannerUrl!);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],

              floating: true,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,

              // flexibleSpace: Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         Colors.green.shade200,
              //         Colors.green.shade300,
              //         Colors.green,
              //       ],
              //     ),
              //   ),
              //   child: FlexibleSpaceBar(
              //     title: Text(
              //       widget.merchantName,
              //       style: Theme.of(context).textTheme.headline6,
              //     ),
              //   ),
              // ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.promotion.bannerUrl!),
              SizedBox(
                height: 50,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  widget.promotion.description!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption!.copyWith(),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  child: const Text(
                    "Claim Now!",
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
