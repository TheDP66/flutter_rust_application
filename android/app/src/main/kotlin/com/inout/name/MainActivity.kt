package com.inout.name

import io.flutter.embedding.android.FlutterActivity
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.content.Context;
import android.content.Intent;
import android.util.Log;

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        var REQUEST_OVERLAY_PERMISSIONS = 100
        if (!Settings.canDrawOverlays(this)) {
            Log.i("MASUK", "Info message")
            val myIntent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
            startActivityForResult(myIntent, REQUEST_OVERLAY_PERMISSIONS)
            return
        }
    }
}