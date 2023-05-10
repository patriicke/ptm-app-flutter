part of 'report_list_bloc.dart';

abstract class ReportListState extends Equatable {
  const ReportListState();

  @override
  List<Object> get props => [];
}

class ReportListLoadInProgress extends ReportListState {}

class ReportListLoadSuccess extends ReportListState {
  final List<ReportListItemDto> reports;
  const ReportListLoadSuccess(this.reports);

  @override
  List<Object> get props => [reports];
}

class ReportListLoadFailure extends ReportListState {
  final String error;
  const ReportListLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
