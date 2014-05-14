package com.egame.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.egame.ane.function.EGamePay;
/**
 * EGAME extension
 * @author CZQ
 *
 */
public class EGameContext extends FREContext {
	
	private static final String EGAME_PAY = "egame-pay";//与java端中Map里的key一致
	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		// TODO Auto-generated method stub
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
		//映射
		map.put(EGAME_PAY, new EGamePay());
		return map;
	}

}
