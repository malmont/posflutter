import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/design/design.dart';
import 'package:pos_flutter/features/Caisse/application/blocs/caisse_bloc.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:pos_flutter/features/order/presentation/widgets/day_selection_card.dart';
import 'package:pos_flutter/features/payment/presentation/widgets/payments_list_page_view.dart';
import 'package:pos_flutter/features/products/presentation/widgets/generic_list.dart';
import 'package:pos_flutter/widget/detail_row.dart';
import 'package:pos_flutter/widget/header_row.dart';

class CaisseListPage extends StatefulWidget {
  final List<Caisse> caisses;
  final Function(Caisse) onSelectCaisse;

  const CaisseListPage(
      {super.key, required this.caisses, required this.onSelectCaisse});

  @override
  State<CaisseListPage> createState() => _CaisseListPageState();
}

int selectedDayIndex = 0;
final List<DaySelection> daySelections = [
  DaySelection(name: "1 jours", days: 1),
  DaySelection(name: "10 jours", days: 10),
  DaySelection(name: "20 jours", days: 20),
  DaySelection(name: "2 mois", days: 60),
  DaySelection(name: "6 mois", days: 180),
];

class _CaisseListPageState extends State<CaisseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      appBar: AppBar(
        title: Text(
          'Caisses',
          style: TextStyles.interRegularH5
              .copyWith(color: Colours.colorsButtonMenu),
        ),
        backgroundColor: Colours.primary100,
      ),
      body: Column(
        children: [
          GenericList<DaySelection>(
            items: daySelections,
            selectedIndex: selectedDayIndex,
            onItemSelected: (index) {
              setState(() {
                selectedDayIndex = index;
                final selectedDays = daySelections[index].days;
                context.read<CaisseBloc>().add(
                      GetCaisse(days: selectedDays),
                    );
              });
            },
            itemBuilder: (daySelection, isSelected) => DaySelectionCard(
              name: daySelection.name,
              isSelected: isSelected,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Units.edgeInsetsLarge),
              height: double.infinity,
              color: Colours.primary100,
              child: widget.caisses.isEmpty
                  ? Center(
                      child: Text(
                        'Pas de caisse ouverte aujourd\'hui',
                        style: TextStyles.interRegularH5.copyWith(
                          color: Colours.colorsButtonMenu,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.caisses.length,
                      itemBuilder: (context, index) {
                        final caisse = widget.caisses[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onSelectCaisse(caisse);
                          },
                          child: Card(
                            color: Colours.primaryPalette,
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(
                                vertical: Units.edgeInsetsLarge,
                                horizontal: Units.edgeInsetsLarge),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(Units.edgeInsetsLarge),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeaderRow(caisse),
                                  const SizedBox(width: Units.sizedbox_80),
                                  _buildDetailsRow(
                                      'Montant Total',
                                      '\$${(caisse.amountTotal / 100).toStringAsFixed(2)}',
                                      Colors.greenAccent),
                                  const SizedBox(width: Units.sizedbox_80),
                                  _buildDetailsRow(
                                      'Date de création',
                                      caisse.createdAt,
                                      Colours.colorsButtonMenu),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(Caisse caisse) {
    return HeaderRow(
      title: 'Caisse ID: ${caisse.id}',
      subtitle: caisse.isOpen ? 'Ouverte' : 'Fermée',
      titleStyle: TextStyles.interBoldBody1.copyWith(color: Colors.white),
      subtitleStyle: TextStyles.interRegularBody1
          .copyWith(color: caisse.isOpen ? Colors.green : Colors.red),
    );
  }

  Widget _buildDetailsRow(String label, String value, Color valueColor) {
    return DetailsRow(
      label: label,
      value: value,
      labelStyle: TextStyles.interRegularBody1.copyWith(color: Colors.white),
      valueStyle: TextStyles.interRegularBody1.copyWith(color: valueColor),
    );
  }
}
