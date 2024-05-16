import 'package:flareline/components/buttons/button_widget.dart';
import 'package:flareline/components/card/common_card.dart';
import 'package:flareline/components/forms/outborder_text_form_field.dart';
import 'package:flareline/components/tables/table_widget.dart';
import 'package:flareline/core/theme/global_colors.dart';
import 'package:flareline/entity/table_data_entity.dart';
import 'package:flareline/pages/dictionary/dictionary_child_page.dart';
import 'package:flareline/pages/dictionary/dictionary_edit_page.dart';
import 'package:flareline/pages/layout.dart';
import 'package:flareline/utils/firebase_store_utils.dart';
import 'package:flareline/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactsPage extends LayoutWidget {
  ContactsPage({super.key});

  @override
  // TODO: implement isContentScroll
  bool get isContentScroll => false;

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement breakTabTitle
    return 'Contacts';
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return DataTableWidget();
  }
}

class DataTableWidget extends TableWidget<ContactsViewModel> {

  @override
  ContactsViewModel viewModelBuilder(BuildContext context) {
    return ContactsViewModel(context);
  }
}

class ContactsViewModel extends BaseTableProvider {
  @override
  String get TAG => 'ContactsViewModel';

  ContactsViewModel(super.context);

  @override
  loadData(BuildContext context) async {
    const headers = [
      "Contact Name",
      "Last Contacted",
      "Company",
      "Contact",
      "Lead Score"
    ];

    List rows = [];

    for (int i = 0; i < 50; i++) {
      List<List<Map<String, dynamic>>> list = [];

      List<Map<String, dynamic>> row = [];
      var id = i;
      var item = {
        'contactName': 'Tom${id}',
        'lastContacted': '1 Feb, 2020',
        'company': 'Starbucks',
        'contact': 'nathan.roberts@example.com',
        'phone': '(201) 555-0124',
        'leadScore': 'Online store',
      };
      row.add(getItemValue('contactName', item));
      row.add(getItemValue('lastContacted', item));
      row.add(getItemValue('company', item));
      row.add(getItemValue('contact', item));
      row.add(getItemValue('leadScore', item, dataType: CellDataType.TAG.type));
      list.add(row);

      rows.addAll(list);
    }

    Map<String, dynamic> map = {'headers': headers, 'rows': rows};
    TableDataEntity data = TableDataEntity.fromJson(map);
    tableDataEntity = data;
  }
}
