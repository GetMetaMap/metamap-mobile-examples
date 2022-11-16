package com.cordova.plugin.metaMapglobalidsdk;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.Nullable;
import java.lang.Exception;
import com.metamap.metamap_sdk.MetamapSdk;
import com.metamap.metamap_sdk.Metadata;
import android.graphics.Color;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import org.json.*;
import static android.app.Activity.RESULT_OK;
import java.util.HashMap;

/**
 * This class echoes a string called from JavaScript.
 */
public class MetaMapGlobalIDSDK extends CordovaPlugin  {

    public static final String SHOW_METAMAPFLOW = "showMetaMapFlow";
    public static final String SET_CALLBACK = "setMetaMapCallback";
    public static final String SDK_TYPE = "sdkType";
    CallbackContext mOnCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        switch (action) {
            case SHOW_METAMAPFLOW:
                String clientId = null;
                String flowId = null;
                JSONObject metadata = (new JSONObject()).put("sdkType", "cordova");
                if (args != null) {
                    JSONObject params = args.getJSONObject(0);
                    clientId = params.getString("clientId");
                    flowId = params.optString("flowId");
                    metadata = params.optJSONObject("metadata");

                    this.showMetaMapFlow(clientId, flowId, metadata, callbackContext);
                } else {
                    Log.e("Integration error", "Please set yours MetaMap client ID");
                }
                return true;

            case SET_CALLBACK:
                mOnCallback = callbackContext;
                return true;

            default:
                return false;
        }
    }

    private void showMetaMapFlow(final String clientId, @Nullable final String flowId , @Nullable final JSONObject metadata, CallbackContext callbackContext) {
        cordova.setActivityResultCallback(this);
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                MetamapSdk.INSTANCE.startFlow(cordova.getActivity(),
                        clientId,
                        flowId,
                        convertToMetadata(metadata));
                callbackContext.success();
            }
        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == MetamapSdk.DEFAULT_REQUEST_CODE) {
            if(resultCode == RESULT_OK) {
                HashMap<String,String> map = new HashMap<String,String>();
                map.put("identityId", data.getStringExtra(MetamapSdk.ARG_VERIFICATION_ID));
                map.put("verificationID", data.getStringExtra(MetamapSdk.ARG_IDENTITY_ID));
                JSONObject json = new JSONObject(map);
                PluginResult result = new PluginResult(PluginResult.Status.OK,json);
                result.setKeepCallback(true);
                mOnCallback.sendPluginResult(result);
            } else {
                PluginResult result = new PluginResult(PluginResult.Status.ERROR, "Verification cancelled");
                result.setKeepCallback(true);
                mOnCallback.sendPluginResult(result);
            }
        }
    }

    public Metadata convertToMetadata(final JSONObject metadata) {
        if (metadata == null)
            return null;

        Metadata.Builder metadataBuilder = new Metadata.Builder();
        Iterator<String> keys = metadata.keys();
        String key;
        while (keys.hasNext()) {
            key = keys.next();
            if (key.toLowerCase().contains("color")) {
                String hexColor = null;
                try {
                    hexColor = (String) metadata.get(key);
                } catch (JSONException e) {
                    throw new RuntimeException(e);
                }
                int color = Color.parseColor(hexColor);
                if (hexColor.length() == 9) {
                    color = Color.argb(Color.blue(color), Color.alpha(color), Color.red(color), Color.green(color));
                }
                try {
                    metadataBuilder.with(key, color);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    metadataBuilder.with(key, metadata.get(key));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return metadataBuilder.build();
    }
}
