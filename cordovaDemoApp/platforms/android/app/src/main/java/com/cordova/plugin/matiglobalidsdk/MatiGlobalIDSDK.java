package com.cordova.plugin.matiglobalidsdk;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.Nullable;

import com.getmati.mati_sdk.MatiButton;
import com.getmati.mati_sdk.Metadata;
import com.getmati.mati_sdk.kyc.KYCActivity;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.Iterator;

/**
 * This class echoes a string called from JavaScript.
 */
public class MatiGlobalIDSDK extends CordovaPlugin  {

    public static final String SHOW_MATIFLOW = "showMatiFlow";
    public static final String SET_MATI_CALLBACK = "setMatiCallback";
    public static final String SET_PARAMS = "setParams";
    public static final String COOL_METHOD = "coolMethod";
    private MatiButton matiButton;
    CallbackContext mOnCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        switch (action){
            case COOL_METHOD:{
                String message = args.getString(0);
                this.coolMethod(message, callbackContext);
                return true;
            }
            case SET_PARAMS:{
                String clientId = null;
                String flowId = null;
                JSONObject metadata = null;
                if (args != null) {
                    JSONObject params = args.getJSONObject(0);
                    clientId = params.getString("clientId");
                    flowId = params.optString("flowId");
                    metadata = params.optJSONObject("metadata");
                    this.setParams(clientId,flowId,metadata, callbackContext);
                    return true;
                } else {
                    Log.e("Integration error", "Please set yours Mati client ID");
                    return true;
                }
            }
            case SET_MATI_CALLBACK:{
                this.setMatiCallback(callbackContext);
                return true;
            }
            case SHOW_MATIFLOW:{
                this.showMatiFlow(callbackContext);
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

    private void setParams(final String clientId, @Nullable final String flowId , @Nullable final JSONObject metadata, CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                matiButton = new MatiButton(cordova.getContext(), null);
                matiButton.setParams(clientId,
                        flowId,
                        "Default flow",
                        convertToMetadata(metadata));
                callbackContext.success();
            }
        });
    }

    private void showMatiFlow(CallbackContext callbackContext){
        if (matiButton.getVm().getValue() != null) {
            MatiButton.State matiState = matiButton.getVm().getValue();
            if (matiState instanceof MatiButton.SuccessState) {
                MatiButton.SuccessState matiSuccess = (MatiButton.SuccessState) matiState;

                Intent intent = new Intent(cordova.getContext(), KYCActivity.class);
                intent.putExtra("ARG_ID_TOKEN", matiSuccess.getIdToken());
                intent.putExtra("ARG_CLIENT_ID", matiSuccess.getClientId());
                intent.putExtra("ARG_VERIFICATION_ID", matiSuccess.getVerificationId());
                intent.putExtra("ARG_ACCESS_TOKEN", matiSuccess.getAccessToken());
                intent.putExtra("ARG_VOICE_TXT", matiSuccess.getVoiceDataTxt());
                intent.putExtra("STATE_LANGUAGE_ID", matiSuccess.getIdToken());
                cordova.getActivity().startActivityForResult(intent, KYCActivity.REQUEST_CODE);
            } else {
                Log.e("Loading error", "Not ready yet, loading...");
            }
        } else {
            Log.e("Loading error", "Please check yours Mati client ID or internet connection");
        }
        callbackContext.success();
    }

    private void  setMatiCallback(CallbackContext callbackContext) {
        mOnCallback = callbackContext;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == KYCActivity.REQUEST_CODE) {
            if(resultCode == KYCActivity.RESULT_OK) {
                PluginResult result = new PluginResult(PluginResult.Status.OK);
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
