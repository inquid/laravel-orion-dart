import 'package:flutter/material.dart';
import 'package:orion_sdk_dart/model.dart';
import 'orion.dart';
import 'post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Post Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Post Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = "Fetching posts...";

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  // Function to fetch, create, update, and delete posts, displaying the results
  Future<void> _fetchPosts() async {
    try {
      Orion.init('https://cooldart.free.beeceptor.com', prefix: 'api/v1');

      // Retrieve a list of posts
      List<Post> posts = await Post.query(Post(attributes: {})).get();
      String firstPostTitle = posts.isNotEmpty
          ? posts.first.title ?? 'No posts available'
          : 'No posts available';
      print('First post title: $firstPostTitle');

      // Create a new post
      Post newPost =
          Post(attributes: {'title': 'New Post', 'body': 'Post content'});
      await newPost.$save();
      String newPostTitle = newPost.title ?? 'No title';
      print('Created post title: $newPostTitle');

      // Retrieve a post
      Model post = await Post.query(Post(attributes: {})).find(1);
      String fetchedPostTitle = post.title ?? 'No title';
      print('Fetched post title: $fetchedPostTitle');

      // Update a post
      newPost.title = 'Updated Post Title';
      await newPost.$save();
      String updatedPostTitle = newPost.title ?? 'No updated title';
      print('Updated post title: $updatedPostTitle');

      // Delete a post
      await newPost.$destroy();
      String deletionResult = "Post deleted successfully";

      setState(() {
        _result = "First Post Title: $firstPostTitle\n"
            "New Post Title: $newPostTitle\n"
            "Fetched Post Title: $fetchedPostTitle\n"
            "Updated Post Title: $updatedPostTitle\n"
            "Deletion Result: $deletionResult";
      });
    } catch (e) {
      setState(() {
        _result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Post API Test Results:',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _result,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
