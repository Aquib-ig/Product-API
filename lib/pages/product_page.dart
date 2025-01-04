// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:testtt_api/model/product_model';
// import 'package:http/http.dart' as http;

// const baseUrl = "https://dummyjson.com/product/";

class ProductPage extends StatefulWidget {
  final ProductModel productModel;
  const ProductPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map<String, dynamic>? productDetails = {};
  bool isLoading = false;
  @override
  void initState() {
    // fetchProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.productModel.images![0]),
                  Text(widget.productModel.title!),
                  Text(widget.productModel.description!),
                  Text(widget.productModel.brand!),

                  Text(widget.productModel.price!.toString()),
                  // Image.network(productDetails!["images"][0]),
                  // Text("Name : ${productDetails!["title"]}"),
                  // Text("Description : ${productDetails!["description"]}"),
                  // Text("Price : ${productDetails!["price"].toString()}"),
                ],
              ),
            ),
    );
  }

  // fetchProductDetails() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     final response =
  //         await http.get(Uri.parse("$baseUrl/${widget.productId}"));
  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       print(body);
  //       setState(() {
  //         productDetails = body;
  //       });
  //     } else {
  //       throw Exception("Failed to load product");
  //     }
  //   } catch (e) {
  //     throw Exception("You have error $e");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
}
