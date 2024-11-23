import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Confirma y paga',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/profile_icons/image_confirmation.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vivienfa rentada entero',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Loft en Barranco'),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 16),
                                  Text('4.92'),
                                  Text('(10)'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Tu viaje',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                _buildInfoRow('Fechas', '15 - 23 de sept', 'Edita'),
                _buildInfoRow(
                    'Hora de llegada', '6:00 p.m - 8:00 p.m', 'Edita'),
                _buildInfoRow('Huéspedes', '2 huéspedes', 'Edita'),
                const SizedBox(height: 16),
                const Text('Información del precio',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                _buildPriceRow('\$35.88 x 8 noches', '\$287.00'),
                _buildPriceRow('Descuentos', '\$0.0'),
                _buildPriceRow('Tarifa de limpieza', '\$XXX.XX'),
                const Divider(),
                _buildPriceRow('Total', '\$317.00', isBold: true),
                const SizedBox(height: 16),
                const Text('Paga con',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                _buildPaymentOption('Tarjeta de crédito o débito'),
                _buildPaymentOption('Paypal'),
                const SizedBox(height: 16),
                const Text('Requerido',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Número de teléfono'),
                const Text(
                    'Agrega y confirma tu número de teléfono para recibir actualizaciones del viaje'),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFB44101),
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Color(0xFFB44101)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0), // Increased horizontal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(.0), // Less rounded
                    ),
                  ),
                  child: const Text('Agregar'),
                ),
                const SizedBox(height: 16),
                const Text('Política de cancelación',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text(
                    'Si cancelas antes del 15 de sept. recibirás un rembolzo completo'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7A436), // Color hex
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Less rounded
                      ),
                    ),
                    child: const Text('Confirma y paga'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(action, style: const TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title) {
    return ListTile(
      leading: const Icon(Icons.credit_card),
      title: Text(title),
      trailing: Radio(
        value: true,
        groupValue: false,
        onChanged: (value) {},
      ),
    );
  }
}
