import 'package:flutter/material.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_1.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_2.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_3.dart';
import 'package:wond3rcard/src/cards/views/widgets/color_pallete.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class CardLayoutSelector extends StatefulWidget {
  const CardLayoutSelector({super.key});
  static const String routeName = RouteString.baseDashboard;

  @override
  _CardLayoutSelectorState createState() => _CardLayoutSelectorState();
}

class _CardLayoutSelectorState extends State<CardLayoutSelector> {
  String _selectedLayout = 'Layout 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Layout Selector'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _showLayoutSelection(context),
            child: const Text('Change Card Layout'),
          ),
          Expanded(
            child: _buildCard(),
          ),
        ],
      ),
    );
  }

  void _showLayoutSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Layout 1'),
              subtitle: const Text('A simple blue card layout'),
              leading: _previewCard(Colors.blue, 'Layout 1'),
              onTap: () {
                _selectLayout('Layout 1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Layout 2'),
              subtitle: const Text('A simple green card layout'),
              leading: _previewCard(Colors.green, 'Layout 2'),
              onTap: () {
                _selectLayout('Layout 2');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Layout 3'),
              subtitle: const Text('A simple orange card layout'),
              leading: _previewCard(Colors.orange, 'Layout 3'),
              onTap: () {
                _selectLayout('Layout 3');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _previewCard(Color color, String label) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _selectLayout(String layout) {
    setState(() {
      _selectedLayout = layout;
    });
  }

  Widget _buildCard() {
    switch (_selectedLayout) {
      case 'Layout 1':
        return const CardLayout1();
      case 'Layout 2':
        return const CardLayout2();
      case 'Layout 3':
        return const CardLayout3();
      default:
        return const CardLayout1();
    }
  }
}
