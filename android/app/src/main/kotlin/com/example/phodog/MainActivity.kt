package com.example.phodog

import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES


class MainActivity: FlutterActivity() {
    private val CHANNEL = "dev.flutter.deviceinfo/device_info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->
            if (call.method == "getDeviceVersion") {
                val deviceVersion = getDeviceVersion()

                if (deviceVersion != null) {
                    result.success(deviceVersion)
                } else {
                    result.error("UNAVAILABLE", "Device version could not be accessed.", null)
                }
            } else {
                result.notImplemented()
            }
        } 
    }

    private fun getDeviceVersion(): String? {
        return VERSION.RELEASE
    }
}
