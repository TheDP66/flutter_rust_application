package com.inout.name

import android.content.BroadcastReceiver
import android.content.Context;
import android.util.Log;
import android.content.Intent;

class BootReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        // ? Immediatly run app on BACKGROUND after reboot
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            val i = Intent(context, MainActivity::class.java)
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(i)
        }
    }
}