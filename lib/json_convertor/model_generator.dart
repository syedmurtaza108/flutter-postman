// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'dart:collection';
import 'dart:convert';

import 'package:dart_style/dart_style.dart';
import 'package:flutter_postman/json_convertor/helpers.dart';
import 'package:flutter_postman/json_convertor/syntax.dart';
import 'package:flutter_postman/json_convertor/warning.dart';
import 'package:json_ast/json_ast.dart' show parse, Settings, Node;

class DartCode extends WithWarning<String> {
  DartCode(super.result, super.warnings);

  String get code => result;
}

/// A Hint is a user type correction.
class Hint {
  Hint(this.path, this.type);
  final String path;
  final String type;
}

class ModelGenerator {
  ModelGenerator({
    this.rootClassName = '',
    this.privateFields = false,
    this.hints = const [],
  });
  final String rootClassName;
  final bool privateFields;
  final allClasses = <ClassDefinition>[];
  final Map<String, String> sameClassMapping = HashMap<String, String>();
  late List<Hint> hints;

  Hint? _hintForPath(String path) {
    final hint =
        hints.firstWhere((h) => h.path == path, orElse: () => Hint('', ''));
    if (hint.path == '') {
      return null;
    }
    return null;
  }

  List<Warning> _generateClassDefinition(
    String className,
    dynamic jsonRawDynamicData,
    String path,
    Node? astNode,
  ) {
    final warnings = <Warning>[];
    if (jsonRawDynamicData is List) {
      // if first element is an array, start in the first element.
      final node = navigateNode(astNode, '0');
      _generateClassDefinition(className, jsonRawDynamicData[0], path, node);
    } else {
      final jsonRawData = jsonRawDynamicData;
      final keys = jsonRawData.keys;
      final classDefinition = ClassDefinition(
        className,
        privateFields: privateFields,
      );
      keys.forEach((key) {
        TypeDefinition typeDef;
        final hint = _hintForPath('$path/$key');
        final node = navigateNode(astNode, key as String);
        if (hint != null) {
          typeDef = TypeDefinition(hint.type, astNode: node);
        } else {
          typeDef = TypeDefinition.fromDynamic(
            jsonRawData[key] as List<dynamic>,
            node,
          );
        }
        if (typeDef.name == 'Class') {
          typeDef.name = camelCase(key);
        }
        if (typeDef.name == 'List' && typeDef.subtype == 'Null') {
          warnings.add(newEmptyListWarn('$path/$key'));
        }
        if (typeDef.subtype != null && typeDef.subtype == 'Class') {
          typeDef.subtype = camelCase(key);
        }
        if (typeDef.isAmbiguous) {
          warnings.add(newAmbiguousListWarn('$path/$key'));
        }
        classDefinition.addField(key, typeDef);
      });
      final similarClass = allClasses.firstWhere(
        (cd) => cd == classDefinition,
        orElse: () => ClassDefinition(''),
      );
      if (similarClass.name != '') {
        final similarClassName = similarClass.name;
        final currentClassName = classDefinition.name;
        sameClassMapping[currentClassName] = similarClassName;
      } else {
        allClasses.add(classDefinition);
      }
      final dependencies = classDefinition.dependencies;
      for (final dependency in dependencies) {
        var warns = <Warning>[];
        if (dependency.typeDef.name == 'List') {
          // only generate dependency class if the array is not empty
          if ((jsonRawData[dependency.name] as List<dynamic>).isNotEmpty) {
            dynamic toAnalyze;
            if (!dependency.typeDef.isAmbiguous) {
              final mergeWithWarning = mergeObjectList(
                jsonRawData[dependency.name] as List<dynamic>,
                '$path/${dependency.name}',
              );
              toAnalyze = mergeWithWarning.result;
              warnings.addAll(mergeWithWarning.warnings);
            } else {
              toAnalyze = jsonRawData[dependency.name][0];
            }
            final node = navigateNode(astNode, dependency.name);
            warns = _generateClassDefinition(
              dependency.className,
              toAnalyze,
              '$path/${dependency.name}',
              node,
            );
          }
        } else {
          final node = navigateNode(astNode, dependency.name);
          warns = _generateClassDefinition(
            dependency.className,
            jsonRawData[dependency.name],
            '$path/${dependency.name}',
            node,
          );
        }
        warnings.addAll(warns);
      }
    }
    return warnings;
  }

  /// generateUnsafeDart will generate all classes and append one after another
  /// in a single string. The [rawJson] param is assumed to be a properly
  /// formatted JSON string. The dart code is not validated so invalid dart code
  /// might be returned
  DartCode generateUnsafeDart(String rawJson) {
    final jsonRawData = jsonDecode(rawJson);
    final astNode = parse(rawJson, Settings());
    final warnings =
        _generateClassDefinition(rootClassName, jsonRawData, '', astNode);
    for (final c in allClasses) {
      final fieldsKeys = c.fields.keys;
      for (final f in fieldsKeys) {
        final typeForField = c.fields[f];
        if (typeForField != null) {
          if (sameClassMapping.containsKey(typeForField.name)) {
            c.fields[f]!.name = sameClassMapping[typeForField.name] ?? '';
          }
        }
      }
    }
    return DartCode(allClasses.map((c) => c.toString()).join('\n'), warnings);
  }

  DartCode generateDartClasses(String rawJson) {
    final unsafeDartCode = generateUnsafeDart(rawJson);
    final formatter = DartFormatter();
    return DartCode(
      formatter.format(unsafeDartCode.code),
      unsafeDartCode.warnings,
    );
  }
}
