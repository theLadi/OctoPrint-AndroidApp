package android.app.printerapp.octoprint;

import android.app.ProgressDialog;
import android.app.printerapp.ItemListActivity;
import android.app.printerapp.R;
import android.app.printerapp.devices.database.DatabaseController;
import android.app.printerapp.model.ModelPrinter;
import android.content.Context;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.loopj.android.http.JsonHttpResponseHandler;
import com.loopj.android.http.RequestParams;

import org.apache.http.Header;
import org.apache.http.entity.StringEntity;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;

public class OctoprintSlicing {

    /**
     * Upload a profile to the server with custom parameters
     * @param context
     * @param p
     * @param profile
     */
	public static void sendProfile(final Context context, final ModelPrinter p, JSONObject profile){

        StringEntity entity = null;
        String key = null;

        try {
            entity = new StringEntity(profile.toString(), "UTF-8");
            key = profile.getString("key");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }


        //Progress dialog to notify command events
		final ProgressDialog pd = new ProgressDialog(context);
		pd.setMessage(context.getString(R.string.devices_command_waiting));
		pd.show();

		
		HttpClientHandler.put(context,p.getAddress() + HttpUtils.URL_SLICING + "/" + key,
				entity, "application/json", new JsonHttpResponseHandler(){
			
			@Override
					public void onProgress(int bytesWritten, int totalSize) {
					}
			
			@Override
					public void onSuccess(int statusCode, Header[] headers,
							JSONObject response) {
						super.onSuccess(statusCode, headers, response);
						
						Log.i("OUT",response.toString());
						//Dismiss progress dialog
						pd.dismiss();


                        //Reload profiles
                        retrieveProfiles(context,p);



            }
			
			@Override
			public void onFailure(int statusCode, Header[] headers,
					String responseString, Throwable throwable) {

				super.onFailure(statusCode, headers, responseString, throwable);
				Log.i("OUT",responseString.toString());
				//Dismiss progress dialog
				pd.dismiss();
				ItemListActivity.showDialog(responseString);
			}
		});
		
	
	}

    /**
     * Delete the profile selected by the profile parameter
     * @param context
     * @param profile
     */
    public static void deleteProfile(final Context context, final ModelPrinter p, String profile){

        HttpClientHandler.delete(context,p.getAddress() + HttpUtils.URL_SLICING + "/" + profile, new JsonHttpResponseHandler(){

            @Override
            public void onProgress(int bytesWritten, int totalSize) {
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers,
                                  JSONObject response) {
                super.onSuccess(statusCode, headers, response);

                //Reload profiles
                retrieveProfiles(context,p);

            }



        });

    }


    /**
     * Method to retrieve slice profiles before sending the file to the actual printer
     *
     */
	public static void retrieveProfiles(final Context context, final ModelPrinter p){
		
		HttpClientHandler.get(p.getAddress() + HttpUtils.URL_SLICING, null, new JsonHttpResponseHandler(){
			
			@Override
					public void onProgress(int bytesWritten, int totalSize) {
					}
			
			@Override
					public void onSuccess(int statusCode, Header[] headers,
							JSONObject response) {
                super.onSuccess(statusCode, headers, response);

                Log.i("PROFILES", response.toString());

                p.getProfiles().clear();

                Iterator<String> keys = response.keys();


                while(keys.hasNext()) {

                    String current = keys.next();

                    try {

                        if (response.getJSONObject(current).getBoolean("default")){
                            Log.i("OUT","Selected item is " + response.getJSONObject(current).getString("key"));
                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    HttpClientHandler.get(p.getAddress() + HttpUtils.URL_SLICING + "/" + current , null, new JsonHttpResponseHandler() {


                        @Override
                        public void onSuccess(int statusCode, Header[] headers,
                                              JSONObject response) {
                            super.onSuccess(statusCode, headers, response);


                            /**
                             * Check if the profile is already added because auto-refresh
                             */
                            for (JSONObject o : p.getProfiles()){

                                try {
                                    if (o.getString("key").equals(response.getString("key"))) return;
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }

                            }


                            if (!p.getProfiles().contains(response)){

                                p.getProfiles().add(response);

                                Intent intent = new Intent("notify");
                                intent.putExtra("message", "Profile");
                                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);

                                Log.i("OUT","Adding profile");
                            } else Log.i("OUT","NOPEEEYAYAYA");


                        }


                    });

                }


            }
			
			@Override
			public void onFailure(int statusCode, Header[] headers,
					String responseString, Throwable throwable) {

				super.onFailure(statusCode, headers, responseString, throwable);
				Log.i("OUT",responseString.toString());
			}
		});
		
	}


    /**
     * Send a slice command by uploading the file first and then send the command, the result
     * will be handled in the socket payload response
     * @param context
     * @param url
     * @param file
     */
	public static void sliceCommand(final Context context, final String url, final File file, final JSONObject extras){

        RequestParams params = new RequestParams();
        try {
            params.put("file", file);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }


        Log.i("Slicer","Uploading " + file.getAbsolutePath());

        HttpClientHandler.post(url + HttpUtils.URL_FILES + "/local",
                params, new JsonHttpResponseHandler(){

                    //Override onProgress because it's faulty
                    @Override
                    public void onProgress(int bytesWritten, int totalSize) {
                    }

                    //If success, the file was uploaded correctly
                    @Override
                    public void onSuccess(int statusCode, Header[] headers,
                                          JSONObject response) {
                        super.onSuccess(statusCode, headers, response);


                        Log.i("Slicer","Upload successful");

                        JSONObject object = extras ;
                        StringEntity entity = null;

                        try {
                            object.put("command", "slice");
                            object.put("slicer", "cura");

                            //TODO select profile

                            //object.put("profile", profile);
                            object.put("gcode", "temp.gco");
                            entity = new StringEntity(object.toString(), "UTF-8");

                            Log.i("OUT","Uploading " + object.toString());

                        } catch (JSONException e) {		e.printStackTrace();
                        } catch (UnsupportedEncodingException e) {	e.printStackTrace();
                        }



                        Log.i("Slicer","Send slice command for " + file.getName());

                        if (DatabaseController.getPreference("Slicing","Last")!=null)
                        if ((DatabaseController.getPreference("Slicing","Last")).equals(file.getName()))
                        HttpClientHandler.post(context,url + HttpUtils.URL_FILES + "/local/" + file.getName(),
                                entity, "application/json", new JsonHttpResponseHandler(){

                                    @Override
                                    public void onProgress(int bytesWritten,
                                                           int totalSize) {
                                    }

                                    @Override
                                    public void onSuccess(int statusCode,
                                                          Header[] headers, JSONObject response) {
                                        super.onSuccess(statusCode, headers, response);



                                        Log.i("Slicer","Slicing started");

                                        /*if (DatabaseController.isPreference("Slicing","Last")){

                                            Log.i("Slicer","Deleting original STL");
                                            Log.i("OUT","We have a preference already yo! deleting yo! " + DatabaseController.getPreference("Slicing","Last"));
                                            OctoprintFiles.deleteFile(context,url,DatabaseController.getPreference("Slicing","Last"), "/local/");

                                        }*/



                                        //DatabaseController.handlePreference("Slicing","Last", file.getName(), true);

                                    }



                                    @Override
                                    public void onFailure(int statusCode, Header[] headers,
                                                          String responseString, Throwable throwable) {

                                        super.onFailure(statusCode, headers, responseString, throwable);
                                        Log.i("OUT",responseString.toString());
                                    }
                                });

                    }

                });








						
		
		
	}
	

}
