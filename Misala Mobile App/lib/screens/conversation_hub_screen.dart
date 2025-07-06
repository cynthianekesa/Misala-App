import 'package:flutter/material.dart';
import '../models/conversation_post.dart';
import '../helpers/database_helper.dart';
import 'package:intl/intl.dart';

class ConversationHubScreen extends StatefulWidget {
  const ConversationHubScreen({super.key});

  @override
  State<ConversationHubScreen> createState() => _ConversationHubScreenState();
}

class _ConversationHubScreenState extends State<ConversationHubScreen> {
  List<ConversationPost> _posts = []; // Changed from final to mutable
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'General';

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = await DatabaseHelper.instance.getConversationPosts();
    setState(() {
      _posts = posts; // Now this works because _posts is not final
    });
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    final newPost = ConversationPost(
      title: _titleController.text,
      content: _contentController.text,
      author: "Current User", // Replace with actual user
      timestamp: DateTime.now(),
      category: _selectedCategory,
    );

    await DatabaseHelper.instance.insertConversationPost(newPost);
    _titleController.clear();
    _contentController.clear();
    await _loadPosts(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Hub'),
        backgroundColor: const Color(0xFF2D6A4F),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCreatePostCard(),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) => _buildPostCard(_posts[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePostCard() {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Post Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'What would you like to share?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: ['General', 'Questions', 'Tips', 'Remedies']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                  ),
                  child: const Text('Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(ConversationPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          // Navigate to post detail screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2D6A4F),
                    child: Text(post.author[0]),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('MMM d, y • h:mm a').format(post.timestamp),
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(post.category),
                    backgroundColor: const Color(0xFFE8F5E9),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(post.content),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () async {
                      await DatabaseHelper.instance.likePost(post.id!);
                      await _loadPosts();
                    },
                  ),
                  Text(post.likes.toString()),
                  const SizedBox(width: 16),
                  const Icon(Icons.comment_outlined),
                  const SizedBox(width: 4),
                  Text(post.comments.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}