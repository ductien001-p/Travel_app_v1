import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';

void openPlaceDetail(BuildContext context, String placeId) {
  final id = placeId.trim();
  if (id.isEmpty) return;
  context.pushNamed(RouteNames.placeDetail, pathParameters: {'placeId': id});
}
