// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:jjimkong/common/widget/bottom_button.dart' as _i2;
import 'package:jjimkong/common/widget/button.dart' as _i3;
import 'package:jjimkong/common/widget/description.dart' as _i4;
import 'package:jjimkong/common/widget/input_field.dart' as _i5;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'common',
    children: [
      _i1.WidgetbookFolder(
        name: 'widget',
        children: [
          _i1.WidgetbookComponent(
            name: 'BottomButton',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Default',
                builder: _i2.defaultBottomButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'Disabled',
                builder: _i2.disabledBottomButton,
              ),
            ],
          ),
          _i1.WidgetbookComponent(
            name: 'Button',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Default',
                builder: _i3.defaultButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'Disabled',
                builder: _i3.disabledButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'OutlineDefault',
                builder: _i3.outlineButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'OutlineSecondary',
                builder: _i3.outlineSecondaryButton,
              ),
              _i1.WidgetbookUseCase(
                name: 'Secondary',
                builder: _i3.secondaryButton,
              ),
            ],
          ),
          _i1.WidgetbookLeafComponent(
            name: 'Description',
            useCase: _i1.WidgetbookUseCase(
              name: 'Description',
              builder: _i4.description,
            ),
          ),
          _i1.WidgetbookComponent(
            name: 'InputField',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Default',
                builder: _i5.defaultInputField,
              ),
              _i1.WidgetbookUseCase(
                name: 'Mulitline',
                builder: _i5.mulitlineInputField,
              ),
              _i1.WidgetbookUseCase(
                name: 'Search',
                builder: _i5.searchInputField,
              ),
            ],
          ),
        ],
      )
    ],
  )
];
