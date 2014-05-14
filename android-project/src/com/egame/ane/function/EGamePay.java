package com.egame.ane.function;

import android.util.Log;
import cn.egame.terminal.paysdk.EgamePay;
import cn.egame.terminal.paysdk.EgamePayListener;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.egame.ane.ShareContent;

public class EGamePay implements FREFunction {

	public static final String PAY_SUCCESS = "pay-success";
	public static final String PAY_FAIL = "pay-fail";
	public static final String PAY_CANCEL = "pay-cancel";
	
	public static final String TAG = "EGamePay";
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		Log.e(TAG, "start pay!~~");
		ShareContent.context = arg0;
				
		String payAlias;
		
		try
		{
			payAlias = arg1[0].getAsString();
		}
		catch(Exception e)
		{
			ShareContent.event("ARG_ERROR", "could not get from args");
			return null;
		}
		ShareContent.event(TAG, "pay "+ payAlias);
		EgamePay.pay(ShareContent.context.getActivity(), payAlias, new EgamePayListener() {
			@Override
			public void paySuccess(String alias) {
				ShareContent.event(EGamePay.PAY_SUCCESS, "" + alias);
			}

			@Override
			public void payFailed(String alias, int errorInt) {
				ShareContent.event(EGamePay.PAY_FAIL, "" + alias);
			}

			@Override
			public void payCancel(String alias) {
				ShareContent.event(EGamePay.PAY_CANCEL, "" + alias);
			}
		});
		
		
        return null;
	}

}
