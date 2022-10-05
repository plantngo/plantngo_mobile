import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_delegate.dart';
import 'package:plantngo_frontend/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  fetchLocation() async {
    Future<dynamic> position = determinePosition();
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    const searchFieldPlaceholder = "Vegetarian Pizza ...";

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[800],
                    ),
                    fillColor: Colors.white,
                    hintText: searchFieldPlaceholder,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: MerchantSearchDelegate(
                        searchFieldPlaceholder: searchFieldPlaceholder,
                      ),
                    );
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
