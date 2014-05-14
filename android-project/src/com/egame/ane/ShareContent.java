package com.egame.ane;

import android.util.Log;

import com.adobe.fre.FREContext;

public class ShareContent {
	public static FREContext context = null;
	
	public static void event(String code,String level  ){
		Log.d(code, "event" + ":"+level );
		context.dispatchStatusEventAsync(code, level );
	}
}
