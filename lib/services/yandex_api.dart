import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class YandexApi {
  static const _clientId = 'taxi/park/906afb361f724266a88988a4e08eacb2';
  static const _apiKey = 'MoQbtEMrDZSkDiNBguPwfwqBKlKCjsJFEEKJamJL';
  static const _partnerId = '906afb361f724266a88988a4e08eacb2';

  static Future<dynamic> _yandexApiPost({required String url, required Map requestBody}) async {
    final headers = {
      'X-Client-ID': _clientId,
      'X-Api-Key': _apiKey,
      'X-Park-ID': _partnerId,
      'Content-Type': 'application/json',
    };

    try {
      final  response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Successfully received a response
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return Future.error('Error: ${response.statusCode}');
      }

    } on SocketException catch (e) {
      return Future.error('No Internet Connection');
    } on Exception catch  (e){
      return Future.error(e.toString());
    }


  }

  static Future<dynamic> fetchDriverProfiles() async {

    String url = 'https://fleet-api.taxi.yandex.net/v1/parks/driver-profiles/list';

    final requestBody = {
      'query': {
        'park': {
          'id': _partnerId,
          "driver_profile": {
            "work_status": ["working"]
          },
        },
      },
    };

    return _yandexApiPost(url: url, requestBody: requestBody) ;
  }

  static Future<dynamic> fetchVehicles() async {

    String url = 'https://fleet-api.taxi.yandex.net/v1/parks/cars/list';

    final requestBody = {

      "limit": 1000,
      "fields": {
        "car" : [
          "brand",
          "model",
          "normalized_number"

        ]

      },

      "query": {
        "park": {
          "car": {
            "status": [
              "working"
            ]
          },
          "id": _partnerId
        }

      }
    };

    return _yandexApiPost(url: url, requestBody: requestBody) ;
  }



// Future<dynamic> fetchDriverHandCash(String driverId,String fromTime,String toTime) async {
  //   final url = Uri.parse('https://fleet-api.taxi.yandex.net/v2/parks/driver-profiles/transactions/list');
  //
  //   final headers = {
  //     'X-Client-ID': _clientId,
  //     'X-Api-Key': _apiKey,
  //     'X-Park-ID':_partnerId,
  //     'Content-Type': 'application/json',
  //   };
  //
  //   final requestBody = {
  //     "limit": 1000,
  //     "query": {
  //       "park": {
  //         "driver_profile": {
  //           "id": driverId
  //         },
  //         "id": _partnerId,
  //         "transaction": {
  //           "category_ids": [
  //             "cash_collected"
  //           ],
  //           "event_at": {
  //             "from": fromTime,
  //             "to": toTime
  //           }
  //         }
  //       }
  //     }
  //   };
  //
  //   final response = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode(requestBody),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Successfully received a response
  //     final jsonResponse = json.decode(response.body);
  //     double handCash = 0;
  //      jsonResponse['transactions'].forEach((val){
  //        handCash += double.parse(val['amount']);
  //      });
  //
  //      return handCash;
  //
  //   } else {
  //     // Handle the error
  //     print('Request failed with status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }
  //
  // Future<dynamic> fetchDriverWorkingHours(String driverId,String fromTime,String toTime) async {
  //   final url = Uri.parse('https://fleet-api.taxi.yandex.net/v2/parks/contractors/supply-hours?contractor_profile_id=$driverId&period_from=$fromTime&period_to=$toTime');
  //
  //   final headers = {
  //     'X-Client-ID': _clientId,
  //     'X-Api-Key': _apiKey,
  //     'X-Park-ID':_partnerId,
  //     'Content-Type': 'application/json',
  //   };
  //
  //
  //   final response = await http.get(
  //     url,
  //     headers: headers
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Successfully received a response
  //     final jsonResponse = json.decode(response.body);
  //     final workingHours = (jsonResponse['supply_duration_seconds']/(60 * 60 )).toStringAsFixed(1);
  //
  //     return double.parse(workingHours);
  //
  //   } else {
  //     // Handle the error
  //     print('Request failed with status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }
  //
  // Future<dynamic> fetchDriverOrders(String driverId,String fromTime,String toTime) async {
  //   final url = Uri.parse('https://fleet-api.taxi.yandex.net/v1/parks/orders/list');
  //
  //   final headers = {
  //     'X-Client-ID': _clientId,
  //     'X-Api-Key': _apiKey,
  //     'X-Park-ID':_partnerId,
  //     'Content-Type': 'application/json',
  //   };
  //
  //   final requestBody = {
  //     "limit": 500,
  //     "query": {
  //       "park": {
  //         "driver_profile": {
  //           "id": driverId
  //         },
  //         "id": _partnerId,
  //         "order": {
  //           "ended_at": {
  //             "from": fromTime,
  //             "to": toTime
  //           }
  //         }
  //       }
  //     }
  //   };
  //
  //   final response = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode(requestBody),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Successfully received a response
  //     final jsonResponse = json.decode(response.body);
  //     List<Order> orders = [];
  //     jsonResponse['orders'].forEach((val){
  //
  //      if ( val['cancellation_description'] == 'requestconfirm status Not Found' ||
  //           val['cancellation_description'] == 'user')  {
  //        val['status'] = 'cancelled' ;
  //       }
  //       orders.add(Order(id: val['id'],status: val['status'])) ;
  //     });
  //
  //     return orders;
  //
  //   } else {
  //     // Handle the error
  //     print('Request failed with status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }
  //
  // Future<dynamic> _fetchOrderDistance(String orderId) async {
  //   final url = Uri.parse('https://fleet-api.taxi.yandex.net/v1/parks/orders/track?park_id=$_partnerId&order_id=$orderId');
  //
  //   final headers = {
  //     'X-Client-ID': _clientId,
  //     'X-Api-Key': _apiKey,
  //     'X-Park-ID':_partnerId,
  //     'Content-Type': 'application/json',
  //   };
  //
  //   final response = await http.post(
  //     url,
  //     headers: headers
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Successfully received a response
  //     final jsonResponse = json.decode(response.body);
  //
  //     DateTime maxTrackedAt = DateTime.utc(0, 1, 1);
  //     double maxDistance = 0 ;
  //
  //     for(final snapshot in  jsonResponse['track'] ){
  //       if(DateTime.parse(snapshot['tracked_at']).isAfter(maxTrackedAt)) {
  //         maxTrackedAt = DateTime.parse(snapshot['tracked_at']) ;
  //
  //         maxDistance = snapshot['distance'] ?? 0  ;
  //       }
  //     }
  //
  //     return maxDistance;
  //
  //   } else {
  //     // Handle the error
  //     print('Request failed with status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }
  //
  // Future<dynamic> fetchOrdersDistance(List<Order> orders) async {
  //   final futures = <Future<dynamic>>[];
  //
  //   for (Order order in orders) {
  //     futures.add(_fetchOrderDistance(order.id));
  //   }
  //
  //   var results = await Future.wait(futures);
  //
  //   double totalDistance = 0;
  //   for (var result in results) {
  //     totalDistance += result;
  //   }
  //   totalDistance = double.parse((totalDistance/1000).toStringAsFixed(1))  ;
  //
  //  return totalDistance;
  // }
}
