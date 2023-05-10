part of 'report_list_bloc.dart';

abstract class ReportListEvent extends Equatable {
  const ReportListEvent();

  @override
  List<Object> get props => [];
}

class ReportListLoaded extends ReportListEvent {
  const ReportListLoaded();
}
