import 'package:flutter/material.dart';

abstract class TableRowBuilder {
  TableRow buildTableRow(String label, String value);
}

class ItemTableRowBuilder implements TableRowBuilder {
  @override
  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class UserTableRowBuilder implements TableRowBuilder {
  @override
  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
