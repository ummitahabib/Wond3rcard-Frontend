import 'package:flutter/material.dart';


class LayoutSelection extends StatelessWidget {
  final String selectedLayout;
  final Function(String) onLayoutSelected;

  const LayoutSelection({
    super.key,
    required this.selectedLayout,
    required this.onLayoutSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildListTile(context, 'Layout 1', Colors.blue),
        _buildListTile(context, 'Layout 2', Colors.green),
        _buildListTile(context, 'Layout 3', Colors.orange),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, String layout, Color color) {
    return ListTile(
      title: Text(layout),
      subtitle: Text('A simple $layout'),
      leading: _previewCard(color, layout),
      onTap: () {
        onLayoutSelected(layout);
        Navigator.pop(context);
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
}
