import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome ${customerProvider.customer.username}!",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: const [
            Text(
              "Home Page",
            ),
          ],
        ),
      ),
    );
  }
}
