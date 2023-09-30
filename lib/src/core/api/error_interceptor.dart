import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class ErrorInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Intercepted Request: ${data.url}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Intercepted Response: ${data.statusCode}');
    if (data.statusCode == 404) {
      // Handle 'Page Not Found' universally
    }
    if (data.statusCode == 401) {
      // Handle 'Unauthorized' universally
    }
    return data;
  }
}
