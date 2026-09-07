// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

/// GET /me/assignment - strictly the caller's own pair (backend-enforced).
@freezed
abstract class Assignment with _$Assignment {
  const factory Assignment({RouteSummary? route, VehicleSummary? vehicle}) =
      _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

@freezed
abstract class RouteSummary with _$RouteSummary {
  const factory RouteSummary({required int id, required String name}) =
      _RouteSummary;

  factory RouteSummary.fromJson(Map<String, dynamic> json) =>
      _$RouteSummaryFromJson(json);
}

@freezed
abstract class VehicleSummary with _$VehicleSummary {
  const factory VehicleSummary({
    required int id,
    required String code,
    required String name,
  }) = _VehicleSummary;

  factory VehicleSummary.fromJson(Map<String, dynamic> json) =>
      _$VehicleSummaryFromJson(json);
}
