import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:q_tec_task_app_/common_widget/background.dart';
import 'package:q_tec_task_app_/service/ui_controller/assignment_controller.dart';
import 'package:q_tec_task_app_/view/widget/produt_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AssingmentController productController =
      Get.put(AssingmentController());

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        image: "assets/images/backgroud5.png",
        child: Obx(
          () => productController.isLoading.isTrue
              ? const Center(
                  child: SpinKitCircle(
                    color: Colors.amberAccent,
                    size: 100,
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: searchController,
                            onChanged: productController.updateSearch,
                            decoration: InputDecoration(
                              hintText: "Search products...",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sort by:",
                                style: TextStyle(
                                    color: Color(0xff34A353),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              DropdownButton<SortOption>(
                                value:
                                    productController.selectedSortOption.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    productController.updateSort(value);
                                  }
                                },
                                items: const [
                                  DropdownMenuItem(
                                    value: SortOption.none,
                                    child: Text(
                                      "None",
                                      style: TextStyle(
                                          color: Color(0xff34A353),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOption.priceLowToHigh,
                                    child: Text(
                                      "Price: Low to High",
                                      style: TextStyle(
                                          color: Color(0xff34A353),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOption.ratingHighToLow,
                                    child: Text(
                                      "Rating: High to Low",
                                      style: TextStyle(
                                          color: Color(0xff34A353),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        itemCount: productController.allProductList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          var data = productController.allProductList[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ProductCard(
                              imagePath: "${data.image}",
                              name: "${data.title}",
                              price: "${data.price}",
                              ratings: '${data.rating?.rate}',
                              totalRatings: '${data.rating?.count}',
                            ),
                          );
                        },
                      ),
                    ),
                    if (productController.hasMore)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () => productController.loadNextPage(),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: Color(0xff34A353),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
