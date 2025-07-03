import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.5:3000/api';

  // For Android emulator, use 10.0.2.2 instead of localhost
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  // For localhost testing: 'http://localhost:3000/api'

  // Users CRUD Operations
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        List<dynamic> jsonData;

        if (decodedData is List) {
          // Direct array response
          jsonData = decodedData;
        } else if (decodedData is Map<String, dynamic>) {
          // Object response - check common property names for the array
          if (decodedData.containsKey('users')) {
            jsonData = decodedData['users'] as List<dynamic>;
          } else if (decodedData.containsKey('data')) {
            jsonData = decodedData['data'] as List<dynamic>;
          } else if (decodedData.containsKey('results')) {
            jsonData = decodedData['results'] as List<dynamic>;
          } else {
            // If it's a single user object, wrap it in a list
            jsonData = [decodedData];
          }
        } else {
          throw Exception('Unexpected response format');
        }

        return jsonData
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  static Future<User> getUserById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> userData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the user data is wrapped in an object
          if (decodedData.containsKey('user')) {
            userData = decodedData['user'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            userData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct user object response
            userData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return User.fromJson(userData);
      } else if (response.statusCode == 404) {
        throw Exception('User with ID $id not found');
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  static Future<User> updateUser(int id, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> userData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the user data is wrapped in an object
          if (decodedData.containsKey('user')) {
            userData = decodedData['user'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            userData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct user object response
            userData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return User.fromJson(userData);
      } else if (response.statusCode == 404) {
        throw Exception('User with ID $id not found');
      } else if (response.statusCode == 400) {
        throw Exception('Invalid user data provided');
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  static Future<bool> deleteUser(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        throw Exception('User with ID $id not found');
      } else {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  static Future<User> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> userData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the user data is wrapped in an object
          if (decodedData.containsKey('user')) {
            userData = decodedData['user'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            userData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct user object response
            userData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return User.fromJson(userData);
      } else if (response.statusCode == 400) {
        throw Exception('Invalid user data provided');
      } else {
        throw Exception('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  // Posts CRUD Operations
  static Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        List<dynamic> jsonData;

        if (decodedData is List) {
          // Direct array response
          jsonData = decodedData;
        } else if (decodedData is Map<String, dynamic>) {
          // Object response - check common property names for the array
          if (decodedData.containsKey('posts')) {
            jsonData = decodedData['posts'] as List<dynamic>;
          } else if (decodedData.containsKey('data')) {
            jsonData = decodedData['data'] as List<dynamic>;
          } else if (decodedData.containsKey('results')) {
            jsonData = decodedData['results'] as List<dynamic>;
          } else {
            // If it's a single post object, wrap it in a list
            jsonData = [decodedData];
          }
        } else {
          throw Exception('Unexpected response format');
        }

        return jsonData
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  static Future<Post> getPostById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> postData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the post data is wrapped in an object
          if (decodedData.containsKey('post')) {
            postData = decodedData['post'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            postData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct post object response
            postData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return Post.fromJson(postData);
      } else if (response.statusCode == 404) {
        throw Exception('Post with ID $id not found');
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  static Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> postData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the post data is wrapped in an object
          if (decodedData.containsKey('post')) {
            postData = decodedData['post'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            postData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct post object response
            postData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return Post.fromJson(postData);
      } else if (response.statusCode == 400) {
        throw Exception('Invalid post data provided');
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  static Future<Post> updatePost(int id, Post post) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        // Handle different response formats
        Map<String, dynamic> postData;

        if (decodedData is Map<String, dynamic>) {
          // Check if the post data is wrapped in an object
          if (decodedData.containsKey('post')) {
            postData = decodedData['post'] as Map<String, dynamic>;
          } else if (decodedData.containsKey('data')) {
            postData = decodedData['data'] as Map<String, dynamic>;
          } else {
            // Direct post object response
            postData = decodedData;
          }
        } else {
          throw Exception(
            'Unexpected response format: Expected object, got ${decodedData.runtimeType}',
          );
        }

        return Post.fromJson(postData);
      } else if (response.statusCode == 404) {
        throw Exception('Post with ID $id not found');
      } else if (response.statusCode == 400) {
        throw Exception('Invalid post data provided');
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating post: $e');
    }
  }

  static Future<bool> deletePost(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        throw Exception('Post with ID $id not found');
      } else {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }
}
