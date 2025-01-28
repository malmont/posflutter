import 'package:pos_flutter/features/home/infrastucture/models/menu_item.dart';
import 'package:pos_flutter/features/home/infrastucture/models/service.dart';
import 'package:pos_flutter/design/assets_images_and_icones.dart';

List<MenuItemModel> menuItems = [
  MenuItemModel(icon: AppAssets.home, title: 'Home', index: 0),
  MenuItemModel(icon: AppAssets.order, title: 'Order', index: 1),
  MenuItemModel(icon: AppAssets.caisse, title: 'Caisse', index: 2),
  MenuItemModel(icon: AppAssets.paiement, title: 'paiement', index: 3),
  MenuItemModel(
    icon: AppAssets.logout,
    title: 'Disconect',
    index: 4,
  ),
];

List<ServiceModel> services = [
  ServiceModel(icon: AppAssets.jira, name: 'Jira software'),
  ServiceModel(icon: AppAssets.slack, name: 'Slack'),
  ServiceModel(icon: AppAssets.intercom, name: 'Intercom'),
  ServiceModel(icon: AppAssets.intercom, name: 'Add new plugin'),
];

List<String> settings = [
  AppAssets.document,
  AppAssets.swap,
  AppAssets.profile,
  AppAssets.graph,
  AppAssets.settings,
  AppAssets.chat,
];
