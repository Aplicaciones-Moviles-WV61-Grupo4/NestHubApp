import 'package:flutter/material.dart';

class DeleteAccountContent extends StatefulWidget {
  const DeleteAccountContent({Key? key}) : super(key: key);

  @override
  _DeleteAccountContentState createState() => _DeleteAccountContentState();
}

class _DeleteAccountContentState extends State<DeleteAccountContent> {
  String? selectedReason;
  final List<String> deleteReasons = [
    'No me gustó mi experiencia en NestHub',
    'No confío en cómo trata NestHub mi información privada',
    'Quiero eliminar una cuenta duplicada',
    'No uso NestHub lo suficiente',
    'Otro',
  ];

  void _showReasonPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Seleccionar motivo (opcional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: deleteReasons.length,
                  itemBuilder: (context, index) {
                    return RadioListTile<String>(
                      title: Text(deleteReasons[index]),
                      value: deleteReasons[index],
                      groupValue: selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          selectedReason = value;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eliminar tu cuenta',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Antes de que eliminemos tus datos, debes responder algunas preguntas. Para confirmar que eres el verdadero titular de esta cuenta, también podemos contactarte a gamiobrenda@gmail.com.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Implementar navegación a más información
            },
            child: const Text(
              'Conoce más sobre las solicitudes para eliminar cuentas.',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            '¿Por qué eliminarás tu cuenta?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _showReasonPicker,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedReason ?? 'Seleccionar motivo',
                    style: TextStyle(
                      color: selectedReason != null ? Colors.black : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedReason != null
                  ? () {
                      // Implementar lógica de eliminación de cuenta
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Eliminar cuenta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
