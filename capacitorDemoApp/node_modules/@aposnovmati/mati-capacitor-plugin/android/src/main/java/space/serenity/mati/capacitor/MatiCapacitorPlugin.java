package space.serenity.mati.capacitor;

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
import com.getmati.mati_sdk.MatiButton;
import com.getmati.mati_sdk.MatiSdk;
import com.getmati.mati_sdk.Metadata;
import com.getmati.mati_sdk.ui.data_prefetch.DataPrefetchActivity;

import org.json.JSONObject;

@CapacitorPlugin(name = "MatiCapacitor")
public class MatiCapacitorPlugin extends Plugin {

    @SuppressWarnings("unused")
    @PluginMethod
    public void showMatiFlow(PluginCall call) {
        Log.e("MatiCapacitorPlugin", "showMatiFlow");
        bridge.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {

                final String clientId = call.getString("clientId");
                final String flowId = call.getString("flowId");
                final JSONObject metadata = call.getObject("metadata", null);
                metadata.put("sdkType", "capacitor");

                Intent intent = new Intent(bridge.getActivity(), DataPrefetchActivity.class);

                intent.putExtra("ARG_CLIENT_ID", clientId);
                if(flowId != null) {
                    intent.putExtra("ARG_FLOW_ID", flowId);
                }
                if(metadata != null) {
                    intent.putExtra("ARG_METADATA", metadata.toString());
                }

//                MatiSdk.INSTANCE.startFlow(bridge.getActivity(), clientId, flowId, Metadata.fromJson(metadata.toString()));

                startActivityForResult(call, intent, "callback");
            }
        });
    }

    @Override
    protected void handleOnActivityResult(int requestCode, int resultCode, Intent data) {
        super.handleOnActivityResult(requestCode, resultCode, data);
        Log.e("MatiCapacitorPlugin", "WILL NOT BE CALLED");
    }

    @SuppressWarnings("unused")
    @ActivityCallback
    public void callback(PluginCall call, ActivityResult activityResult) {
        if(activityResult.getResultCode() == Activity.RESULT_OK) {
            JSObject result = new JSObject();
            result.put("verificationId", activityResult.getData().getStringExtra(MatiSdk.ARG_VERIFICATION_ID));
            call.resolve(result);
            Log.e("MatiCapacitorPlugin", "Activity.RESULT_OK");
        } else {
            call.reject("Verification cancelled");
            Log.e("MatiCapacitorPlugin", "Activity.RESULT_CANCELLED");
        }
    }
}
