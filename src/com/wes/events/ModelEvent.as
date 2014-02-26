package com.wes.events {
	import flash.events.Event;

	/**
	 * @author root
	 */
	public class ModelEvent extends Event {
		public static const XML_READY : String = "xmlReady";
		public static const IMAGE_READY : String = "imageReady";
		public static const MODEL_COMPLETE : String = "modelComplete";
		
		public function ModelEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
