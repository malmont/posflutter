import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/core/utils/AmountInputDialog.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:pos_flutter/features/Caisse/presentation/pages/caisse_actions_view_page.dart';
import 'package:pos_flutter/features/caisse/presentation/widgets/caisse_details_page.dart';
import 'package:pos_flutter/features/caisse/presentation/widgets/caisse_list_page.dart';

import 'package:pos_flutter/features/order/presentation/pages/statistic_view_page.dart';

import '../../../../design/design.dart';
import '../../application/blocs/caisse_bloc.dart';

class CaisseView extends StatefulWidget {
  const CaisseView({super.key});

  @override
  State<CaisseView> createState() => _CaisseViewState();
}

class _CaisseViewState extends State<CaisseView> {
  Caisse? selectedCaisse;

  void navigateToDetails(Caisse caisse) {
    setState(() {
      selectedCaisse = caisse;
    });
  }

  void goBackToList() {
    setState(() {
      selectedCaisse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary100,
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                if (selectedCaisse == null)
                  BlocBuilder<CaisseBloc, CaisseState>(
                    builder: (context, state) {
                      if (state is CaisseLoading) {
                        EasyLoading.show(status: 'Chargement...');
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CaisseSuccess) {
                        EasyLoading.dismiss();
                        return CaisseListPage(
                          caisses: state.caisses,
                          onSelectCaisse: navigateToDetails,
                        );
                      } else if (state is CaisseFail) {
                        EasyLoading.dismiss();
                        return const Center(
                            child:
                                Text('Erreur lors du chargement des caisses'));
                      } else {
                        EasyLoading.dismiss();
                        return const Center(
                            child: Text('Aucun état correspondant'));
                      }
                    },
                  ),
                if (selectedCaisse != null)
                  CaisseDetailsPage(
                    caisseDetails: selectedCaisse!,
                    onBack: goBackToList,
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<CaisseBloc, CaisseState>(
              builder: (context, state) {
                if (state is CaisseLoading) {
                  EasyLoading.show(status: 'Chargement...');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CaisseSuccess && state.caisses.isNotEmpty) {
                  EasyLoading.dismiss();
                  Caisse? openCaisse;

                  for (var caisse in state.caisses) {
                    if (caisse.isOpen) {
                      openCaisse = caisse;
                    }
                  }

                  return CaisseActionsPage(
                    caisseDetails: openCaisse,
                    onOpenCaisse: () {
                      context.read<CaisseBloc>().add(const OpenCaisse());
                    },
                    onCloseCaisse: () {
                      context.read<CaisseBloc>().add(const CloseCaisse());
                    },
                    onWithdraw: () {
                      showAmountDialog(context, 'Retrait', (double amount) {
                        if (amount > 0) {
                          context
                              .read<CaisseBloc>()
                              .add(WithDrawCaisse(amount));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Veuillez entrer un montant valide.')),
                          );
                        }
                      });
                    },
                    onDeposit: () {
                      showAmountDialog(context, 'Dépôt', (double amount) {
                        if (amount > 0) {
                          context.read<CaisseBloc>().add(DepositCaisse(amount));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Veuillez entrer un montant valide.')),
                          );
                        }
                      });
                    },
                  );
                } else if (state is CaisseSuccess && state.caisses.isEmpty) {
                  EasyLoading.dismiss();
                  return const Center(child: Text('Aucune caisse disponible'));
                } else if (state is CaisseFail) {
                  EasyLoading.dismiss();
                  return const Center(
                      child: Text('Erreur lors du chargement des caisses'));
                } else {
                  EasyLoading.dismiss();
                  return const Center(child: Text('Aucun état correspondant'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
