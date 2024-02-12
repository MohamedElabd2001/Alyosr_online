import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'details_screen.dart';
import '../model/model.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PostScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  PostScreen({super.key, required this.categoryId, required this.categoryName});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late List<PageData> posts;
  List<Map<String, dynamic>>? subCategories; // Make subCategories nullable
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchPostsByCategoryId();
    fetchSubCategories(); // Fetch subcategories when the screen initializes
  }

  Future<void> fetchPostsByCategoryId() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'https://alyosr.online/wp-json/wp/v2/posts?per_page=100&&categories=${widget.categoryId}',
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data);
        List<PageData> pageDataList =
            data.map((item) => PageData.fromJson(item)).toList();

        setState(() {
          posts = pageDataList;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchSubCategories() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'https://alyosr.online/wp-json/wp/v2/categories?parent=${widget.categoryId}',
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data);

        setState(() {
          subCategories = data;
        });
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Container(
                  height: 50,
                  width: 50,
                  child: Lottie.asset('assets/lottie/laww.json')))
          : SafeArea(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: posts.length + (subCategories?.length ?? 0),
                itemBuilder: (context, index) {
                  if (index < posts.length) {
                    // It's a post
                    PageData post = posts[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(page: post),
                        ),
                      ),
                      child: buildPostCard(post),
                    );
                  } else if (subCategories != null) {
                    // It's a subcategory
                    Map<String, dynamic> subCategory =
                        subCategories![index - posts.length];
                    return GestureDetector(
                      onTap: () {
                        // Handle subcategory tap
                        String subCategoryName = subCategory['name'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(
                              categoryId: subCategory['id'],
                              categoryName: subCategoryName,
                            ),
                          ),
                        );
                      },
                      child: buildSubcategoryCard(subCategory),
                    );
                  } else {
                    // Loading state or fallback
                    return Container();
                  }
                },
              ),
            ),
    );
  }

  Widget buildPostCard(PageData post) {
    String cleanedTitle = post.title.replaceAll(RegExp(r'&#8211;|;'), '');

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100, // Adjust the height as needed
              child: Animate(
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                ),
              ).animate().fade().scale(),
            ),
            SizedBox(
              height: 5,
            ),
            Animate(
              child: AutoSizeText(
                cleanedTitle,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ).animate().fade().scale(),
            ),
            // Display other data as needed
          ],
        ),
      ),
    );
  }

  Widget buildSubcategoryCard(Map<String, dynamic> subCategory) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Animate(
              child: Image.asset(
                'assets/images/banner.jpg',
              ),
            ).animate().fade().scale(),
            SizedBox(
              height: 15,
            ),
            // You can customize the subcategory display as needed
            Animate(
              child: AutoSizeText(
                subCategory['name'],
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ).animate().fade().scale(),
            ),
          ],
        ),
      ),
    );
  }
}
