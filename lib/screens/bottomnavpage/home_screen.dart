import 'package:flutter/material.dart';
import 'package:flutter_node_store67/app_router.dart';
import 'package:flutter_node_store67/models/product_model.dart';
import 'package:flutter_node_store67/screens/products/components/product_item.dart';
import 'package:flutter_node_store67/services/rest_api.dart';

// สร้างตัวแปร refreshKey สำหรับการ RefreshIndicator
var refreshKey = GlobalKey<RefreshIndicatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Toggle between ListView and GridView
  bool _isGridView = true;

  // สร้างฟังก์ชันสลับระหว่าง ListView และ GridView
  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: _toggleView,
            icon: Icon(_isGridView ? Icons.list_outlined : Icons.grid_view)),
        title: const Text('สินค้า'),
        actions: [
          IconButton(
              onPressed: () {
                //
                Navigator.pushNamed(context, AppRouter.productAdd);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      // body: _isGridView ? _gridView(): _listView(),
      // body: FutureBuilder(
      //   future: CallAPI().getAllProducts(),
      //   builder: (context, AsyncSnapshot snapshot) {
      //       // กรณีที่มี error
      //       if (snapshot.hasError) {
      //         return const Center(
      //           child: Center(child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง')),
      //         );
      //       } else if (snapshot.connectionState == ConnectionState.done) {
      //         // กรณีที่โหลดข้อมูลสำเร็จ
      //         List<ProductModel> products = snapshot.data;
      //         return _isGridView ? _gridView(products) : _listView(products);
      //       } else {
      //         // กรณีที่กำลังโหลดข้อมูล
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     },
      //   ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: CallAPI().getAllProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            // กรณีที่มี error
            if (snapshot.hasError) {
              return const Center(
                child: Center(child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง')),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // กรณีที่โหลดข้อมูลสำเร็จ
              List<ProductModel> products = snapshot.data;
              return _isGridView ? _gridView(products) : _listView(products);
            } else {
              // กรณีที่กำลังโหลดข้อมูล
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  // _gridView Widget -----------------------------------------------------------
  Widget _gridView(List<ProductModel> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // จำนวนคอลัมน์
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        mainAxisExtent: 200,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(
          isGrid: true,
          product: products[index],
          onTap: () {
            Navigator.pushNamed(
                  context, 
                  AppRouter.productDetail,
                  arguments: {
                    'products': products[index].toJson()
                  }
                );
          },
        );
      },
    );
  }
  // ---------------------------------------------------------------------------

  // _listView Widget -----------------------------------------------------------
  Widget _listView(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 400,
            child: ProductItem(
              product: products[index],
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  AppRouter.productDetail,
                  arguments: {
                    'products': products[index].toJson()
                  }
                );
              },
            ),
          ),
        );
      },
    );
  }
  // ---------------------------------------------------------------------------
}
