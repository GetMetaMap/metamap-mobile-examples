package com.cordova.plugin.matiglobalidsdk;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.Nullable;

import com.getmati.mati_sdk.Metadata;
import com.getmati.mati_sdk.MatiSdk;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.Iterator;
import static android.app.Activity.RESULT_OK;

/**
 * This class echoes a string called from JavaScript.
 */
public class MatiGlobalIDSDK extends CordovaPlugin  {

    public static final String SHOW_MATIFLOW = "showMatiFlow";
    public static final String COOL_METHOD = "coolMethod";
    public static final String SET_CALLBACK = "setMatiCallback";
    CallbackContext mOnCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        switch (action){
            case COOL_METHOD:{
                String message = args.getString(0);
                this.coolMethod(message, callbackContext);
                return true;
            }
            case SHOW_MATIFLOW:{
                String clientId = null;
                String flowId = null;
                JSONObject metadata = null;
                if (args != null) {
                    JSONObject params = args.getJSONObject(0);
                    clientId = params.getString("clientId");
                    flowId = params.optString("flowId");
                    metadata = params.optJSONObject("metadata");
                    this.showMatiFlow(clientId,flowId,metadata, callbackContext);
                    return true;
                } else {
                    Log.e("Integration error", "Please set yours Mati client ID");
                    return true;
                }
            }
            case SET_CALLBACK:{
                mOnCallback = callbackContext;
                return true;
            }
        }
        return false;
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private void showMatiFlow(final String clientId, @Nullable final String flowId , @Nullable final JSONObject metadata, CallbackContext callbackContext) {
        cordova.setActivityResultCallback(this);
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                MatiSdk.INSTANCE.startFlow(cordova.getActivity(),
                        clientId,
                        flowId,
                        convertToMetadata(metadata));
                callbackContext.success();
            }
        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == MatiSdk.REQUEST_CODE) {
            if(resultCode == RESULT_OK) {
                 PluginResult result = new PluginResult(PluginResult.Status.OK, data.getStringExtra(MatiSdk.ARG_VERIFICATION_ID));
                result.setKeepCallback(true);
                mOnCallback.sendPluginResult(result);
            } else {
                PluginResult result = new PluginResult(PluginResult.Status.ERROR, "Verification cancelled");
                result.setKeepCallback(true);
                mOnCallback.sendPluginResult(result);
            }
        }
    }

    public Metadata convertToMetadata(final JSONObject metadata)
    {
        if (metadata == null)
            return null;

                Metadata.Builder metadataBuilder = new Metadata.Builder();
                Iterator<String> keys = metadata.keys();
                String key;
                while(keys.hasNext()) {
                     key = keys.next();
                    try {
                        metadataBuilder.with(key, metadata.get (key));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
        return metadataBuilder.build();
    }
}
