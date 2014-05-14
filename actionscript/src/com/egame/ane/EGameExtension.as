package com.egame.ane 
{ 
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * 电信爱游戏扩展
	 * @author CZQ
	 * 
	 */	
	public class EGameExtension extends EventDispatcher 
	{ 
		private static const EGAME_PAY:String = "egame-pay";//与java端中Map里的key一致
		
		private static const EXTENSION_ID:String = "com.egame.ane";//与extension.xml中的id标签一致
		private var extContext:ExtensionContext;
		
		
		private static var _instance:EGameExtension; 
		public function EGameExtension()
		{
			if(extContext == null) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);
			}
		} 
		
		/**
		 * 获取实例
		 * @return EGameExtension 单例
		 */
		public static function getInstance():EGameExtension
		{
			if(_instance == null) 
				_instance = new EGameExtension();
			return _instance;
		}
		
		/**
		 * 转抛事件
		 * @param event 事件
		 */
		private function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
		/**
		 * 支付
		 * @param payAlias 计费点道具别名
		 * 
		 */		
		public function pay(payAlias:String):void{
			if(extContext ){
				extContext.call(EGAME_PAY, payAlias);
			}
		}
	} 
}