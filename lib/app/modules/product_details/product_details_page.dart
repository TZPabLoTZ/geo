import 'package:flutter/material.dart';
import 'package:geo/app/widgets/text_default.dart';
import 'package:get/get.dart';

import '../../infra/models/product_model.dart';
import '../../theme/app_colors.dart';
import '../../widgets/size.dart';
import 'product_details_controller.dart';

class ProductDetailsPage extends GetView<ProductDetailsController> {
  final ProductModel? product;
  const ProductDetailsPage({super.key, this.product});

  static const route = '/product-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Detalhes'),
        centerTitle: true,
        backgroundColor: AppColors.backgroundLight,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product?.listImages?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset(
                    product?.listImages?[index] ?? "",
                    width: size(context).width,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            width: size(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                TextDefault(text: product?.name ?? "", fontSize: 24),
                const SizedBox(height: 8),
                TextDefault(
                  text: product?.description ?? "",
                  fontSize: 16,
                  color: AppColors.text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
