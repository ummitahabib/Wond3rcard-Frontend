import 'package:flutter/material.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_1.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_2.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_3.dart';
import 'package:wond3rcard/src/cards/views/widgets/card_layout_app_bar.dart';
import 'package:wond3rcard/src/cards/views/widgets/layout_selection.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CardLayoutSelector extends StatefulWidget {
  const CardLayoutSelector({super.key});
  static const String routeName = RouteString.cardLayout;

  @override
  _CardLayoutSelectorState createState() => _CardLayoutSelectorState();
}

class _CardLayoutSelectorState extends State<CardLayoutSelector> {
  String _selectedLayout = 'Layout 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardLayoutAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: _buildCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    switch (_selectedLayout) {
      case 'Layout 1':
        return CardLayout1(onLayoutSelected: _updateLayout);
      case 'Layout 2':
        return CardLayout2(onLayoutSelected: _updateLayout);
      case 'Layout 3':
        return CardLayout3(onLayoutSelected: _updateLayout);
      default:
        return CardLayout1(onLayoutSelected: _updateLayout);
    }
  }

  void _updateLayout(String layout) {
    setState(() {
      _selectedLayout = layout;
    });
  }

  void showLayoutSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LayoutSelection(
          selectedLayout: _selectedLayout,
          onLayoutSelected: _updateLayout,
        );
      },
    );
  }
}
