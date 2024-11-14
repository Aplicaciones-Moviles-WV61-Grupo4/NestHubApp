import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final Map<String, bool> _isEditing = {
    'name': false,
    'preferredName': false,
    'email': false,
    'phone': false,
    'document': false,
    'address': false,
  };

  final _firstNameController = TextEditingController(text: 'Cesar');
  final _lastNameController = TextEditingController(text: 'Saalas');
  final _preferredNameController = TextEditingController(text: 'No proporcionado');
  final _emailController = TextEditingController(text: 'No proporcionado');
  final _phoneController = TextEditingController(text: 'No proporcionado');
  final _documentController = TextEditingController(text: 'No proporcionado');
  final _addressController = TextEditingController(text: 'No proporcionado');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Información personal',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection(
                'Nombre legal',
                _firstNameController.text + ' ' + _lastNameController.text,
                'name',
                _buildNameEditingSection,
              ),
              _buildInfoSection(
                'Nombre preferido',
                _preferredNameController.text,
                'preferredName',
                _buildPreferredNameEditingSection,
              ),
              _buildInfoSection(
                'Dirección de correo electrónico',
                _emailController.text,
                'email',
                _buildEmailEditingSection,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                    'Número de teléfono',
                    _phoneController.text,
                    'phone',
                    _buildPhoneEditingSection,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Número de contacto (para Airbnb y los huéspedes con reservaciones confirmadas). Puedes agregar otros números y elegir cómo usarlos.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              _buildInfoSection(
                'Documento oficial de identidad',
                _documentController.text,
                'document',
                _buildDocumentEditingSection,
              ),
              _buildInfoSection(
                'Dirección',
                _addressController.text,
                'address',
                _buildAddressEditingSection,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String value, String editingKey, Widget Function() buildEditingSection) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_isEditing[editingKey]!) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => setState(() => _isEditing[editingKey] = true),
                  child: Text(
                    'Edita',
                    style: TextStyle(
                      color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: value == 'No proporcionado' ? Colors.grey : Colors.black,
              ),
            ),
          ] else ...[
            buildEditingSection(),
          ],
          Divider(height: 32),
        ],
      ),
    );
  }

  Widget _buildNameEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre legal',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Asegúrate de que coincide con el nombre que aparece en tu documento de identidad oficial.',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _firstNameController,
          decoration: InputDecoration(
            labelText: 'Nombre que aparece en el documento de identidad',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(
            labelText: 'Apellidos que aparecen en el documento de identidad',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('name'),
      ],
    );
  }

  Widget _buildPreferredNameEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre preferido',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _preferredNameController,
          decoration: InputDecoration(
            labelText: 'Nombre preferido',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('preferredName'),
      ],
    );
  }

  Widget _buildEmailEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dirección de correo electrónico',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('email'),
      ],
    );
  }

  Widget _buildPhoneEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Número de teléfono',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Número de teléfono',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('phone'),
      ],
    );
  }

  Widget _buildDocumentEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Documento oficial de identidad',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _documentController,
          decoration: InputDecoration(
            labelText: 'Número de documento',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('document'),
      ],
    );
  }

  Widget _buildAddressEditingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dirección',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _addressController,
          decoration: InputDecoration(
            labelText: 'Dirección',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildEditingButtons('address'),
      ],
    );
  }

  Widget _buildEditingButtons(String editingKey) {
    return Row(
      children: [
        TextButton(
          onPressed: () => setState(() => _isEditing[editingKey] = false),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (editingKey == 'preferredName') {
              final preferredName = _preferredNameController.text;
              Navigator.pop(context, preferredName);
            }
            setState(() => _isEditing[editingKey] = false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB44101),
          ),
          child: const Text(
            'Guardar',
             style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _preferredNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _documentController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}