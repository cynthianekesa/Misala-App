import 'package:flutter/material.dart';
import '../models/community_submission.dart';
import '../helpers/database_helper.dart';

class CommunitySubmissionScreen extends StatefulWidget {
  const CommunitySubmissionScreen({super.key});

  @override
  State<CommunitySubmissionScreen> createState() => 
      _CommunitySubmissionScreenState();
}

class _CommunitySubmissionScreenState extends State<CommunitySubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _englishNameController = TextEditingController();
  final _scientificNameController = TextEditingController();
  final _localNameController = TextEditingController();
  final _ailmentTreatedController = TextEditingController();
  final _preparationMethodController = TextEditingController();

  @override
  void dispose() {
    _englishNameController.dispose();
    _scientificNameController.dispose();
    _localNameController.dispose();
    _ailmentTreatedController.dispose();
    _preparationMethodController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final submission = CommunitySubmission(
        englishName: _englishNameController.text,
        scientificName: _scientificNameController.text,
        localName: _localNameController.text,
        ailmentTreated: _ailmentTreatedController.text,
        preparationMethod: _preparationMethodController.text,
        submittedBy: "Current User", // Replace with actual user
        isVerified: false,
        submissionDate: DateTime.now(), // Added submission date
      );

      await DatabaseHelper.instance.insertCommunitySubmission(submission);
      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Remedy'),
        backgroundColor: const Color(0xFF2D6A4F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _englishNameController,
                decoration: const InputDecoration(
                  labelText: 'English Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _scientificNameController,
                decoration: const InputDecoration(
                  labelText: 'Scientific Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localNameController,
                decoration: const InputDecoration(
                  labelText: 'Local Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ailmentTreatedController,
                decoration: const InputDecoration(
                  labelText: 'Ailment Treated',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _preparationMethodController,
                decoration: const InputDecoration(
                  labelText: 'Preparation Method',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Submit Remedy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}