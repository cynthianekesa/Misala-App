import 'package:flutter/material.dart';
import '../models/community_submission.dart';
import '../helpers/database_helper.dart';
import 'community_submission_screen.dart';

class CommunityWisdomScreen extends StatefulWidget {
  const CommunityWisdomScreen({super.key});

  @override
  State<CommunityWisdomScreen> createState() => _CommunityWisdomScreenState();
}

class _CommunityWisdomScreenState extends State<CommunityWisdomScreen> {
  late Future<List<CommunitySubmission>> _submissionsFuture;
  String _filter = 'all';
  bool _isDoctor = true; // Set based on actual user role

  @override
  void initState() {
    super.initState();
    _refreshSubmissions();
  }

  void _refreshSubmissions() {
    setState(() {
      _submissionsFuture = _filter == 'all'
          ? DatabaseHelper.instance.getCommunitySubmissions()
          : _filter == 'verified'
              ? DatabaseHelper.instance.getVerifiedSubmissions()
              : DatabaseHelper.instance.getPendingSubmissions();
    });
  }

  Widget _buildSubmissionCard(CommunitySubmission submission) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              submission.englishName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (submission.scientificName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  submission.scientificName,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            if (submission.localName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  submission.localName,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            const SizedBox(height: 12),
            const Text(
              'Ailment Treated:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(submission.ailmentTreated),
            const SizedBox(height: 12),
            const Text(
              'Preparation Method:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(submission.preparationMethod),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Submitted by ${submission.submittedBy}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                submission.isVerified
                    ? Chip(
                        label: const Text('Verified'),
                        backgroundColor: Colors.green[100],
                      )
                    : Row(
                        children: [
                          Chip(
                            label: const Text('Pending'),
                            backgroundColor: Colors.orange[100],
                          ),
                          if (_isDoctor) ...[
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _verifySubmission(submission.id!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                              child: const Text(
                                'Verify',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifySubmission(int submissionId) async {
    try {
      await DatabaseHelper.instance.verifySubmission(submissionId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remedy verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _refreshSubmissions();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildFilterDropdown() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() => _filter = value);
        _refreshSubmissions();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'all',
          child: Text('All Submissions'),
        ),
        const PopupMenuItem(
          value: 'verified',
          child: Text('Verified Only'),
        ),
        const PopupMenuItem(
          value: 'pending',
          child: Text('Pending Only'),
        ),
      ],
      icon: const Icon(Icons.filter_list),
    );
  }

  Future<void> _navigateToSubmissionScreen(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const CommunitySubmissionScreen(),
      ),
    );
    if (result == true) _refreshSubmissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Wisdom Hub'),
        backgroundColor: const Color(0xFF2D6A4F),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToSubmissionScreen(context),
          ),
          _buildFilterDropdown(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _refreshSubmissions(),
        child: FutureBuilder<List<CommunitySubmission>>(
          future: _submissionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _refreshSubmissions,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.eco, size: 50, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      _filter == 'all'
                          ? 'No submissions yet'
                          : _filter == 'verified'
                              ? 'No verified submissions'
                              : 'No pending submissions',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _navigateToSubmissionScreen(context),
                      child: const Text('Share Your Wisdom'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => 
                  _buildSubmissionCard(snapshot.data![index]),
            );
          },
        ),
      ),
    );
  }
}