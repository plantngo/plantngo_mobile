import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MerchantPromotionDetailsScreen extends StatefulWidget {
  String merchantName;
  String merchantPromotionImage;

  MerchantPromotionDetailsScreen({
    super.key,
    required this.merchantName,
    required this.merchantPromotionImage,
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
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Share.share(widget.merchantPromotionImage);
                    },
                    icon: const Icon(
                      Icons.share,
                    ),
                  ),
                ),
              ],
              floating: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade200,
                      Colors.green.shade300,
                      Colors.green,
                    ],
                  ),
                ),
                child: FlexibleSpaceBar(
                  title: Text(
                    widget.merchantName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.merchantPromotionImage),
            SizedBox(
              height: 50,
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: ElevatedButton(
                child: Text(
                  "Claim Now!",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
