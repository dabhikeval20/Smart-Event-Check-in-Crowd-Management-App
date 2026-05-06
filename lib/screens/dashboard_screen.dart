import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/participant_provider.dart';
import '../providers/event_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Color _getCrowdColor(double percent) {
    if (percent < 0.5) return Colors.green;
    if (percent < 0.9) return Colors.orange;
    return Colors.red;
  }

  String _getCrowdLevel(double percent) {
    if (percent < 0.5) return 'Safe';
    if (percent < 0.9) return 'Moderate';
    return 'Full';
  }

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);
    final total = participantProvider.participants.length;
    final checkedIn = participantProvider.participants.where((p) => p.checkedIn).length;
    final event = eventProvider.events.isNotEmpty ? eventProvider.events.first : null;
    final maxCapacity = event?.maxCapacity ?? 1;
    final remaining = (maxCapacity - total).clamp(0, maxCapacity);
    final percent = total / maxCapacity;
    final crowdColor = _getCrowdColor(percent);
    final crowdLevel = _getCrowdLevel(percent);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return Column(
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _StatCard(
                      title: 'Total Participants',
                      value: '$total',
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                    _StatCard(
                      title: 'Checked-in',
                      value: '$checkedIn',
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                    _StatCard(
                      title: 'Remaining Capacity',
                      value: '$remaining',
                      icon: Icons.event_seat,
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text('Crowd Level', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: percent > 1 ? 1 : percent,
                          minHeight: 16,
                          color: crowdColor,
                          backgroundColor: crowdColor.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          crowdLevel,
                          style: TextStyle(
                            color: crowdColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color)),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
