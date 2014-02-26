package com.wes.objects {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author root
	 */
	public class CheckBox extends Sprite {
		
		public var _text:String;
		public var _value:String;
		public var checked:Boolean = false;
		
		
		private var _tf : TextFormat;
		private var _txt : TextField;
		private var _textColor : uint = 0xFF0000;
		private var _textSize : Number = 14;
		private var _box : Sprite = new Sprite();
		private var _butlet : Sprite = new Sprite();
		
		
		public function CheckBox(text:String, value:String) {
			_text = text;
			_value = value;
			
			builtCheckBox();
			builtTextField();
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, clicked);
		}

		private function builtTextField() : void {
			_tf = new TextFormat();
			_tf.color = _textColor;
			_tf.size = _textSize;
			_tf.kerning = true;
			_tf.bold = true;
			_tf.font ="verdana";

			_txt = new TextField();
			_txt.defaultTextFormat = _tf;
			_txt.text = _text;
			_txt.selectable = false;
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.x = _box.width + 5;
			_txt.y = 0;
			
			this.addChild(_txt);
		}

		private function builtCheckBox() : void {
			
			_box.graphics.lineStyle(1, 0xFF0000);
			_box.graphics.beginFill(0x000000);
			_box.graphics.drawRect(0, 0, 20, 20);
			_box.graphics.endFill();
			this.addChild(_box);

			_butlet.graphics.beginFill(0xFF0000);
			_butlet.graphics.drawRect(4, 4, 12, 12);
			_butlet.graphics.endFill();
			_butlet.alpha = 0;
			this.addChild(_butlet);
		}
		
		
		private function clicked(event:MouseEvent) : void {
			if(checked){
				checked = false;
				_butlet.alpha = 0;
			} else {
				checked = true;
				_butlet.alpha = 1;
			}
		}
		
		
	}
}
