package com.example.android_check_orientation

import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kotlinx.coroutines.ExperimentalCoroutinesApi
import android.provider.Settings
import android.provider.Settings.System.ACCELEROMETER_ROTATION;

class MainActivity: FlutterActivity() {


    companion object {
        private const val CHANNEL = "auto_rotation"
        private const val METHOD = "getAutoRotation"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
                if (methodCall.method == METHOD) {
                    val info = Settings.System.getString(getContentResolver(), ACCELEROMETER_ROTATION)
                    result.success(info);
                } else {
                    result.notImplemented()
                }
            }
    }
}
