import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'report_list_event.dart';
part 'report_list_state.dart';

class ReportListBloc extends Bloc<ReportListEvent, ReportListState> {
  ReportListBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(ReportListLoadInProgress());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ReportListState> mapEventToState(
    ReportListEvent event,
  ) async* {
    if (event is ReportListLoaded) {
      yield* _mapReportListLoadedToState();
    }
  }

  Stream<ReportListState> _mapReportListLoadedToState() async* {
    yield ReportListLoadInProgress();
    try {
      var reportApi = ReportApi();
      var authKey = _authenticationRepository.authKey;
      var response = await reportApi.getReportList(authKey);

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling ReportApi->getReportList. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling ReportApi->getReportList. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }

      yield ReportListLoadSuccess(response.data);
    } catch (e) {
      yield ReportListLoadFailure(e.toString());
    }
  }
}
