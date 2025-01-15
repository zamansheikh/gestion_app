import 'package:flutter/material.dart';

class RevervationDetailScreen extends StatefulWidget {
  const RevervationDetailScreen({super.key});

  @override
  State<RevervationDetailScreen> createState() =>
      _RevervationDetailScreenState();
}

class _RevervationDetailScreenState extends State<RevervationDetailScreen> {
  // ignore: unused_field
  final int _selectedRoomIndex = 0;
  List<String> reservedRooms = [
    'Room 1',
    'Room 2',
    'Room 3',
    'Room 4',
    'Room 5',
    'Room 6',
    'Room 7',
    'Room 8',
    'Room 9',
    'Room 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text('Reservations'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 8),
                ReservationDetailRow(
                  label: 'Room Name:',
                  value: 'EL WIRO 1',
                ),
                ReservationDetailRow(
                  label: 'Name:',
                  value: 'RH',
                ),
                ReservationDetailRow(
                  label: 'Checkin:',
                  value: '24-01-2024',
                ),
                ReservationDetailRow(
                  label: 'Checkout:',
                  value: '01-02-2025',
                ),
                ReservationDetailRow(
                  label: 'Number of nights:',
                  value: '2 Nights',
                ),
                ReservationDetailRow(
                  label: 'Channel:',
                  value: 'Booking',
                ),
                ReservationDetailRow(
                  label: 'Occupancy:',
                  value: '2 persons',
                ),
                ReservationDetailRow(
                  label: 'Guest Phone:',
                  value: '+34 673 722 947',
                ),
                ReservationDetailRow(
                  label: 'Remarks:',
                  value: 'highchair',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReservationDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ReservationDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
