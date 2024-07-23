class Response {
  int? timestamp;

  Response({this.timestamp});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      timestamp: json['time'] as int
    );
  }
}