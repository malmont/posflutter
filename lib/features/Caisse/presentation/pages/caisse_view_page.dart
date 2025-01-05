import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'package:pos_flutter/features/Caisse/infrastucture/models/transaction_caisse_response_model.dart';
import 'package:pos_flutter/features/Caisse/presentation/pages/caisse_actions_view_page.dart';
import 'package:pos_flutter/features/Caisse/presentation/widgets/show_transaction_dialog.dart';

import 'package:pos_flutter/features/caisse/presentation/widgets/caisse_details_page.dart';
import 'package:pos_flutter/features/caisse/presentation/widgets/caisse_list_page.dart';

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

  void _handleTransaction(
      BuildContext context, String title, String transactiontype) {
    showTransactionDialog(
      context: context,
      title: title,
      onSubmit: (TransactionCaisseResponseModel transaction) {
        if (transaction.amount > 0) {
          switch (transactiontype) {
            case 'withdrawCaisse':
              context.read<CaisseBloc>().add(WithDrawCaisse(transaction));
              break;
            case 'depositCaisse':
              context.read<CaisseBloc>().add(DepositCaisse(transaction));
              break;
            case 'cashFundWithdraw':
              context
                  .read<CaisseBloc>()
                  .add(CashFundWithdrawCaisse(transaction));
              break;
            case 'cashFundDeposit':
              context
                  .read<CaisseBloc>()
                  .add(CashFundDepositCaisse(transaction));
              break;
            default:
              print('Transaction type invalide');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Type de transaction invalide.'),
                ),
              );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Veuillez entrer un montant valide.'),
            ),
          );
        }
      },
    );
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
                } else if ((state is CaisseSuccess &&
                        state.caisses.isNotEmpty) ||
                    state is CaisseMouvement) {
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

                      if (openCaisse?.amountTotal != 0) {
                        _showReplenishFundDialog(context).then((value) {
                          if (value == true) {
                            _handleTransaction(
                              context,
                              'Dépôt fond de caisse',
                              'cashFundDeposit',
                            );
                          }
                        });
                      }
                    },
                    onCloseCaisse: () {
                      if (openCaisse?.fondDeCaisse != 0) {
                        _showWithdrawFundDialog(context).then((value) {
                          if (value == true) {
                            _handleTransaction(
                              context,
                              'Retrait fond de caisse',
                              'cashFundWithdraw',
                            );
                          }
                        });
                        return;
                      }

                      if (openCaisse?.amountTotal != 0) {
                        _showWithdrawFundDialog(context).then((value) {
                          if (value == true) {
                            _handleTransaction(
                              context,
                              'Retrait',
                              'withdrawCaisse',
                            );
                          }
                        });
                        return;
                      }

                      context.read<CaisseBloc>().add(const CloseCaisse());
                    },
                    onWithdraw: () => _handleTransaction(
                      context,
                      'Retrait',
                      'withdrawCaisse',
                    ),
                    onDeposit: () => _handleTransaction(
                      context,
                      'Dépôt',
                      'depositCaisse',
                    ),
                    onCashFundWithdraw: () => _handleTransaction(
                      context,
                      'Retrait fond de caisse',
                      'cashFundWithdraw',
                    ),
                    onCashFundDeposit: () => _handleTransaction(
                      context,
                      'Dépôt fond de caisse',
                      'cashFundDeposit',
                    ),
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

  Future<bool?> _showReplenishFundDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Action requise',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Veuillez réapprovisionner le fond de caisse.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Retourne "false" pour annuler
              },
              style: TextButton.styleFrom(
                foregroundColor: Colours.colorsButtonMenu,
              ),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Retourne "true" pour confirmer
              },
              style: TextButton.styleFrom(
                backgroundColor: Colours.colorsButtonMenu,
                foregroundColor: Colours.primaryPalette,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showWithdrawFundDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colours.primaryPalette,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Action requise',
            style: TextStyles.interBoldH6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Veuillez vider le fond de caisse avant de fermer la caisse.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Retourne "false" pour annuler
              },
              style: TextButton.styleFrom(
                foregroundColor: Colours.colorsButtonMenu,
              ),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Retourne "true" pour confirmer
              },
              style: TextButton.styleFrom(
                backgroundColor: Colours.colorsButtonMenu,
                foregroundColor: Colours.primaryPalette,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
