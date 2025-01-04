import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testtt_api/model/product_model';
import 'package:testtt_api/pages/product_page.dart';

const baseUrl = "https://dummyjson.com/product";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  bool isLoading = false;
  @override
  void initState() {
    fetchProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Products Details"),
          backgroundColor: Colors.blue,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : products.isEmpty
                ? const Center(
                    child: Text("No product found"),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var productDetails = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                            ),
                            child: Image.network(productDetails.images![0]),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          productModel: productDetails,
                                          // productId: productDetails.id!,
                                        )));
                          },
                        ),
                      );
                    },
                  )
        // : ListView.builder(
        //     itemCount: products.length,
        //     itemBuilder: (context, index) {
        //       final product = products[index];
        //       return ListTile(
        //         title: Text(product.title!),
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const ProductPage()));
        //         },
        //         // title: Image.network(product.images![0])
        //         // title: Text(product[""]),
        //       );
        //     }),
        );
  }

  fetchProductData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final productData = body["products"];
        log(productData.toString());
        List<dynamic> dynamicData = productData;
        List<ProductModel> prod =
            dynamicData.map((e) => ProductModel.fromJson(e)).toList();
        setState(() {
          products = prod;
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
