import 'package:flutter/material.dart';
import 'package:nesthub/delete_account_page.dart';
import 'package:nesthub/payment_methods_page.dart';
import 'package:nesthub/shared_data_page.dart';
import 'package:nesthub/your_payments_page.dart';

class PersonalDataSettingsPage extends StatelessWidget {
  const PersonalDataSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de datos personales',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildListItem(
                title: 'Datos compartidos',
                description: 'Decide cómo se meustra tu perfil y actividad en NestHub.',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SharedDataPage(),
                      ),
                    );
                },
              ),
              _buildListItem(
                title: 'Eliminiar cuenta',
                description: 'Si lo haces, tu cuenta y datos se borrarán permanentemente.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountContent(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required VoidCallback onTap,
    required String description,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}