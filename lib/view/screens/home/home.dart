import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_tec_task_app_/controller/getx_controller/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: SizedBox(
          height: 42,
          child: TextField(
            onChanged: (value) {
              controller.searchFun(searchText: value);
            },
            controller: controller.searchController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Search here",
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        controller.searchFun(
                            searchText: controller.searchController.text);
                      });
                    },
                    child: const Icon(Icons.search)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.builder(
                  itemCount: controller.searchList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.maxFinite,
                              child: Image.network(
                                "${controller.searchList[index].image}",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${controller.searchList[index].title}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
