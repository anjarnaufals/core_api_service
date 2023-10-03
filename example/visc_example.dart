import 'package:visc/visc.dart';

void main() async {
  const getRandomDataUrl = 'random';
  final httpInfras = HttpInfras(
    baseUrl: 'api.publicapis.org',
    headers: null,
  );
  final dioInfras = DioInfras(
    baseUrl: 'https://api.publicapis.org/',
    headers: null,
  );
  try {
    await dioInfras.get(getRandomDataUrl).then((res) {
      res.fold(
        (apiException) {
          print('$apiException');
        },
        (response) {
          print('Response From Dio Infras => $response \n');
        },
      );
    });
  } catch (e, t) {
    print('$e');
    print(t.toString());
  }
  try {
    await httpInfras.get(getRandomDataUrl).then((res) {
      res.fold(
        (apiException) {
          print('$apiException');
        },
        (response) {
          print('Response From Http Infras =>$response \n');
        },
      );
    });
  } catch (e, t) {
    print('$e');
    print(t.toString());
  }
}
