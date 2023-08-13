import 'package:flutter/material.dart';

class AdminOthersModelManagement extends StatefulWidget {
  const AdminOthersModelManagement({Key? key}) : super(key: key);

  @override
  State<AdminOthersModelManagement> createState() => _AdminOthersModelManagementState();
}

class _AdminOthersModelManagementState extends State<AdminOthersModelManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Model'),
      ),
    );
  }
}
