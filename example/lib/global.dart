import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

final ScaffoldKey = new GlobalKey<ScaffoldState>();
final sentry =
    SentryClient(dsn: "https://65081ee149d04d8b81ec78a3f09c1d6f@o455652.ingest.sentry.io/5447525");
