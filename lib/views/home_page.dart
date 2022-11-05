import 'package:flutter/material.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:laundry_app/views/loading_page.dart';
import 'package:laundry_app/views/transaction/create_transaction.dart';
import 'package:laundry_app/views/transaction/list_transaction.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> submit() async {
    await Provider.of<AuthAPI>(context, listen: false).logOut();
  }

  @override
  void initState() {
    super.initState();
    getAllTransaction();
  }

  Future<void> getAllTransaction() async {
    await Provider.of<TransactionViewModel>(context, listen: false)
        .getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[300]),
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('My Laundry'),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListTransaction(),
                  ),
                );
              },
              leading: const Icon(Icons.receipt_long),
              title: const Text('Your Transaction'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTransaction(),
                  ),
                );
              },
              leading: const Icon(Icons.add_card_outlined),
              title: const Text('Create Transaction'),
            ),
            ListTile(
              onTap: submit,
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Welcome To My Laundry'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/laundry_image.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.topCenter,
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 100,
                ),
                color: Colors.green[200],
                child: Column(
                  children: const [
                    Text(
                      'About Us :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
