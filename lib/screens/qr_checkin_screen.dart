import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/participant_provider.dart';
import '../providers/event_provider.dart';
import '../models/participant_model.dart';

class QRCheckInScreen extends StatefulWidget {
  const QRCheckInScreen({Key? key}) : super(key: key);

  @override
  State<QRCheckInScreen> createState() => _QRCheckInScreenState();
}

class _QRCheckInScreenState extends State<QRCheckInScreen> {
  final TextEditingController _manualIdController = TextEditingController();
  bool _isProcessing = false;

  void _handleCheckIn(String participantId) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    final participantProvider = Provider.of<ParticipantProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final event = eventProvider.events.isNotEmpty ? eventProvider.events.first : null;
    if (event == null) {
      _showSnackBar('No event found.');
      setState(() => _isProcessing = false);
      return;
    }
    final alreadyExists = participantProvider.participants.any((p) => p.id == participantId);
    if (alreadyExists) {
      final checkedIn = participantProvider.participants.firstWhere((p) => p.id == participantId).checkedIn;
      if (checkedIn) {
        _showSnackBar('Participant already checked in.');
      } else {
        await participantProvider.checkInParticipant(participantId);
        _showSnackBar('Check-in successful!');
      }
      setState(() => _isProcessing = false);
      return;
    }
    if (participantProvider.participants.length >= event.maxCapacity) {
      _showSnackBar('Event capacity reached!');
      setState(() => _isProcessing = false);
      return;
    }
    final newParticipant = ParticipantModel(
      id: participantId,
      name: 'Guest', // You can enhance this to fetch name from QR or input
      checkedIn: true,
      checkInTime: DateTime.now(),
      syncStatus: false,
    );
    await participantProvider.addParticipant(newParticipant, event.maxCapacity);
    _showSnackBar('Check-in successful!');
    setState(() => _isProcessing = false);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Check-In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      final String? code = barcode.rawValue;
                      if (code != null && !_isProcessing) {
                        _handleCheckIn(code);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _manualIdController,
              decoration: InputDecoration(
                labelText: 'Enter Participant ID',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final id = _manualIdController.text.trim();
                    if (id.isNotEmpty && !_isProcessing) {
                      _handleCheckIn(id);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isProcessing) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
