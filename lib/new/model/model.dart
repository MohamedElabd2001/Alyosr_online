class PageData {
  final int id;
  final String date;
  final String title;
  final String content;
  final String uagb_excerpt;
/*final String excerpt;*/
  final String imageUrl; // Add this line

  PageData({
    /*required this.excerpt,*/
    required this.uagb_excerpt,
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.imageUrl, // Add this line
  });

  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      /* excerpt:json['excerpt'],*/
      id: json['id'],
      uagb_excerpt:json['uagb_excerpt'],
      date: json['date'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      imageUrl: json['jetpack_featured_media_url'], // Add this line
    );
  }
}


class Category {
  final int id;
  final String name;
  final String link;

  Category({required this.id, required this.name, required this.link});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      link: json['link'],
    );
  }
}



class Post {
  final int id;
  final String title;
  final String content;
  // Add other fields as needed

  Post({required this.id, required this.title, required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      // Initialize other fields
    );
  }
}