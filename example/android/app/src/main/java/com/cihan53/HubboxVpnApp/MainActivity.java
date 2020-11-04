package com.cihan53.HubboxVpnApp;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onDestroy() {
        super.onDestroy();

        System.out.println("App close oldu =========================== >");
    }
}
