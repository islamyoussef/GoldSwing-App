class ModelApiStatus {
  int requestsToday;
  int requestsYesterday;
  int requestsMonth;
  int requestsLastMonth;
  int statusCode;
  String statusMsg;

  ModelApiStatus({
    required this.requestsToday,
    required this.requestsYesterday,
    required this.requestsMonth,
    required this.requestsLastMonth,
    this.statusCode = 0,
    this.statusMsg = '',
  });

  factory ModelApiStatus.fromJson(Map<String, dynamic> json) => ModelApiStatus(
    requestsToday: json["requests_today"],
    requestsYesterday: json["requests_yesterday"],
    requestsMonth: json["requests_month"],
    requestsLastMonth: json["requests_last_month"],
  );
}

/*
 End point:  https://www.goldapi.io/api/stat
{
  "requests_today": 3,
  "requests_yesterday": 7,
  "requests_month": 29,
  "requests_last_month": 36
}
 */
