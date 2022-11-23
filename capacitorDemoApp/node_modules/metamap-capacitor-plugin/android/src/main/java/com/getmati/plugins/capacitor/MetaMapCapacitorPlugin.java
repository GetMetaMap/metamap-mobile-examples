package com.getmati.plugins.capacitor;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import androidx.activity.result.ActivityResult;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.ActivityCallback;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.metamap.metamap_sdk.MetamapSdk;
import com.metamap.metamap_sdk.Metadata;
import org.json.JSONObject;
import org.json.JSONException;

@CapacitorPlugin(name = "MetaMapCapacitor")
public class MetaMapCapacitorPlugin extends Plugin {

    @SuppressWarnings("unused")
    @PluginMethod
    public void showMetaMapFlow(PluginCall call) {
        Log.e("MetaMapCapacitorPlugin", "showMetaMapFlow");
        bridge.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {

                final String clientId = call.getString("clientId");
                final String flowId = call.getString("flowId");
                final JSONObject metadata = call.getObject("metadata", new JSObject());
                try {
                    metadata.put("sdkType", "capacitor");
                    if (clientId == null) {
                      Log.e("MetaMapCapacitorPlugin", "\"Client Id should be not null\"");
                    } else {
                        Intent flowIntent = MetamapSdk.INSTANCE.createFlowIntent(bridge.getActivity(), clientId, flowId, Metadata.fromJson(metadata.toString(2)));
                        startActivityForResult(call, flowIntent, "callback");
                    }
                } catch(JSONException excepion) {
                    call.reject("Verification failed");
                }
            }
        });
    }

    @Override
    protected void handleOnActivityResult(int requestCode, int resultCode, Intent data) {
        super.handleOnActivityResult(requestCode, resultCode, data);
        Log.e("MetaMapCapacitorPlugin", "WILL NOT BE CALLED");
    }

    @SuppressWarnings("unused")
    @ActivityCallback
    public void callback(PluginCall call, ActivityResult activityResult) {
        if(activityResult.getResultCode() == Activity.RESULT_OK && activityResult.getData() != null) {
            JSObject result = new JSObject();
            String identityId = activityResult.getData().getStringExtra("ARG_IDENTITY_ID");
            String verificationID = activityResult.getData().getStringExtra("ARG_VERIFICATION_ID");
            result.put("identityId", identityId);
            result.put("verificationID", verificationID);
            call.resolve(result);
            Log.e("MetaMapCapacitorPlugin", "Activity.RESULT_OK");
        } else {
            call.reject("verificationCancelled");
            Log.e("MetaMapCapacitorPlugin", "Activity.RESULT_CANCELLED");
        }
    }
}
