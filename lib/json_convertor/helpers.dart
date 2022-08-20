// ignore_for_file: avoid_dynamic_calls, inference_failure_on_instance_creation

import 'dart:math';
import 'package:flutter_postman/json_convertor/syntax.dart';
import 'package:flutter_postman/json_convertor/warning.dart';
import 'package:json_ast/json_ast.dart';

const primitiveTypes = {
  'int': true,
  'double': true,
  'String': true,
  'bool': true,
  'DateTime': false,
  'List<DateTime>': false,
  'List<int>': true,
  'List<double>': true,
  'List<String>': true,
  'List<bool>': true,
  'Null': true,
};

enum ListType { object, string, double, int, nullType }

class MergeableListType {
  MergeableListType({required this.listType, required this.isAmbiguous});

  final ListType listType;
  final bool isAmbiguous;
}

MergeableListType mergeableListType(List<dynamic> list) {
  var t = ListType.nullType;
  var isAmbiguous = false;
  for (final e in list) {
    final inferredType = getInferredType(e);
    if (t != ListType.nullType && t != inferredType) {
      isAmbiguous = true;
    }
    t = inferredType ?? ListType.nullType;
  }
  return MergeableListType(listType: t, isAmbiguous: isAmbiguous);
}

ListType? getInferredType(dynamic d) {
  if (d.runtimeType == int) {
    return ListType.int;
  } else if (d.runtimeType == double) {
    return ListType.double;
  } else if (d.runtimeType == String) {
    return ListType.string;
  } else if (d is Map) {
    return ListType.object;
  }
  return null;
}

String camelCase(String text) {
  String capitalize(Match m) =>
      m[0]!.substring(0, 1).toUpperCase() + m[0]!.substring(1);
  String skip(String s) => '';
  return text.splitMapJoin(
    RegExp('[a-zA-Z0-9]+'),
    onMatch: capitalize,
    onNonMatch: skip,
  );
}

String camelCaseFirstLower(String text) {
  final camelCaseText = camelCase(text);
  final firstChar = camelCaseText.substring(0, 1).toLowerCase();
  final rest = camelCaseText.substring(1);
  return '$firstChar$rest';
}

WithWarning<Map<dynamic, dynamic>> mergeObj(
  dynamic obj,
  dynamic other,
  String path,
) {
  final warnings = <Warning>[];
  final clone = Map<dynamic, dynamic>.from(obj as Map<dynamic, dynamic>);
  other.forEach((dynamic k, dynamic v) {
    if (clone[k] == null) {
      clone[k] = v;
    } else {
      final otherType = getTypeName(v);
      final t = getTypeName(clone[k]);
      if (t != otherType) {
        if (t == 'int' && otherType == 'double') {
          // if double was found instead of int, assign the double
          clone[k] = v;
        } else if ((clone[k].runtimeType as String) != 'double' &&
            (v.runtimeType as String) != 'int') {
          // if types are not equal, then
          warnings.add(newAmbiguousType('$path/$k'));
        }
      } else if (t == 'List') {
        final l = List<dynamic>.from(clone[k] as List<dynamic>)
          ..addAll(other[k] as List<dynamic>);
        final mergeableType = mergeableListType(l);
        if (ListType.object == mergeableType.listType) {
          final mergedList = mergeObjectList(l, path);
          warnings.addAll(mergedList.warnings);
          clone[k] = List.filled(1, mergedList.result);
        } else {
          if (l.isNotEmpty) {
            clone[k] = List.filled(1, l[0]);
          }
          if (mergeableType.isAmbiguous) {
            warnings.add(newAmbiguousType('$path/$k'));
          }
        }
      } else if (t == 'Class') {
        final mergedObj = mergeObj(clone[k], other[k], '$path/$k');
        warnings.addAll(mergedObj.warnings);
        clone[k] = mergedObj.result;
      }
    }
  });
  return WithWarning(clone, warnings);
}

WithWarning<Map<dynamic, dynamic>> mergeObjectList(
  List<dynamic> list,
  String path, [
  int idx = -1,
]) {
  final warnings = <Warning>[];
  // ignore: prefer_collection_literals
  final obj = Map();
  for (var i = 0; i < list.length; i++) {
    final toMerge = list[i];
    if (toMerge is Map) {
      toMerge.forEach((k, v) {
        final t = getTypeName(obj[k]);
        if (obj[k] == null) {
          obj[k] = v;
        } else {
          final otherType = getTypeName(v);
          if (t != otherType) {
            if (t == 'int' && otherType == 'double') {
              // if double was found instead of int, assign the double
              obj[k] = v;
            } else if (t != 'double' && otherType != 'int') {
              // if types are not equal, then
              var realIndex = i;
              if (idx != -1) {
                realIndex = idx - i;
              }
              final ambiguousTypePath = '$path[$realIndex]/$k';
              warnings.add(newAmbiguousType(ambiguousTypePath));
            }
          } else if (t == 'List') {
            final l = List<dynamic>.from(obj[k] as List<dynamic>);
            final beginIndex = l.length;
            l.addAll(v as List<dynamic>);
            // bug is here
            final mergeableType = mergeableListType(l);
            if (ListType.object == mergeableType.listType) {
              final mergedList = mergeObjectList(l, '$path[$i]/$k', beginIndex);
              warnings.addAll(mergedList.warnings);
              obj[k] = List.filled(1, mergedList.result);
            } else {
              if (l.isNotEmpty) {
                obj[k] = List.filled(1, l[0]);
              }
              if (mergeableType.isAmbiguous) {
                warnings.add(newAmbiguousType('$path[$i]/$k'));
              }
            }
          } else if (t == 'Class') {
            var properIndex = i;
            if (idx != -1) {
              properIndex = i - idx;
            }
            final mergedObj = mergeObj(
              obj[k],
              v,
              '$path[$properIndex]/$k',
            );
            warnings.addAll(mergedObj.warnings);
            obj[k] = mergedObj.result;
          }
        }
      });
    }
  }
  return WithWarning(obj, warnings);
}

bool isPrimitiveType(String typeName) {
  final isPrimitive = primitiveTypes[typeName];
  if (isPrimitive == null) {
    return false;
  }
  return isPrimitive;
}

String fixFieldName(
  String name, {
  required TypeDefinition typeDef,
  bool privateField = false,
}) {
  var properName = name;
  if (name.startsWith('_') || name.startsWith(RegExp('[0-9]'))) {
    final firstCharType = typeDef.name.substring(0, 1).toLowerCase();
    properName = '$firstCharType$name';
  }
  final fieldName = camelCaseFirstLower(properName);
  if (privateField) {
    return '_$fieldName';
  }
  return fieldName;
}

String getTypeName(dynamic obj) {
  if (obj is String) {
    return 'String';
  } else if (obj is int) {
    return 'int';
  } else if (obj is double) {
    return 'double';
  } else if (obj is bool) {
    return 'bool';
  } else if (obj == null) {
    return 'Null';
  } else if (obj is List) {
    return 'List';
  } else {
    // assumed class
    return 'Class';
  }
}

Node? navigateNode(Node? astNode, String path) {
  Node? node;
  if (astNode is ObjectNode) {
    final objectNode = astNode;
    PropertyNode? propertyNode;
    for (var i = 0; i < objectNode.children.length; i++) {
      final prop = objectNode.children[i];
      if (prop.key != null && prop.key?.value == path) {
        propertyNode = prop;
        break;
      }
    }
    if (propertyNode != null) {
      node = propertyNode.value;
    }
  }
  if (astNode is ArrayNode) {
    final arrayNode = astNode;
    final index = int.tryParse(path);
    if (index != null && arrayNode.children.length > index) {
      node = arrayNode.children[index];
    }
  }
  return node;
}

final _pattern = RegExp(r'([0-9]+)\.{0,1}([0-9]*)e(([-0-9]+))');

bool isASTLiteralDouble(Node? astNode) {
  if (astNode != null && astNode is LiteralNode) {
    final literalNode = astNode;
    if (literalNode.raw != null) {
      final containsPoint = literalNode.raw!.contains('.');
      final containsExponent = literalNode.raw!.contains('e');
      if (containsPoint || containsExponent) {
        var isDouble = containsPoint;
        if (containsExponent) {
          final matches = _pattern.firstMatch(literalNode.raw!);
          if (matches != null) {
            final integer = matches[1]!;
            final comma = matches[2]!;
            final exponent = matches[3]!;
            isDouble = _isDoubleWithExponential(integer, comma, exponent);
          }
        }
        return isDouble;
      }
    }
  }
  return false;
}

bool _isDoubleWithExponential(String integer, String comma, String exponent) {
  final integerNumber = int.tryParse(integer) ?? 0;
  final exponentNumber = int.tryParse(exponent) ?? 0;
  final commaNumber = int.tryParse(comma) ?? 0;
  if (exponentNumber == 0) {
    return commaNumber > 0;
  }
  if (exponentNumber > 0) {
    return exponentNumber < comma.length && commaNumber > 0;
  }
  return commaNumber > 0 ||
      ((integerNumber.toDouble() * pow(10, exponentNumber)).remainder(1) > 0);
}
