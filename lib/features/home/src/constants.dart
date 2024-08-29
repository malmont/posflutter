

import 'package:pos_flutter/features/home/infrastucture/models/menu_item.dart';
import 'package:pos_flutter/features/home/infrastucture/models/service.dart';
import 'package:pos_flutter/features/home/src/assets.dart';

List<MenuItemModel> menuItems = [
  
  MenuItemModel(
      icon: AppAssets.home, title: 'Home', index: 0),
  MenuItemModel(icon: AppAssets.calendar, title: 'Calendar', index: 1),
  MenuItemModel(icon: AppAssets.dashboard, title: 'Dashboard', index: 2),
  MenuItemModel(icon: AppAssets.mail, title: 'Mail', index: 3),
  MenuItemModel(icon: AppAssets.notification, title: 'Notification', index: 4),
  MenuItemModel(icon: AppAssets.sales, title: 'Sales', index: 5),
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
