package com.wes.events {
	import flash.events.Event;

	/**
	 * @author root
	 */
	public class MenuBtnEvent extends Event {
		public static var BTNCLICK : String = "btnClick";
		public static var DONE : String = "done";
		
		public var name : String = "SOME BUTTON";
		public var levelName : String = "SOME LEVEL";
		public var difficultyName:String = "SOME DIFFICULTY";
		
		public function MenuBtnEvent(type : String, bubbles : Boolean = true, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}
