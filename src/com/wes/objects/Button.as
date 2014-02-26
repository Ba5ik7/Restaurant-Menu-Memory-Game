package com.wes.objects {
	import flash.events.MouseEvent;
	import com.wes.events.MenuBtnEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Wesley
	 */
	public class Button extends Sprite {
		private var _text : String;
		private var _textSize : Number;
		private var _textColor : uint;
		private var _width : Number;
		private var _height : Number;
		private var _bgColor : uint;
		private var _lineThinkness : Number;
		private var _lineColor : uint;
		private var _tf : TextFormat;
		private var _txt : TextField;
		private var _evt : MenuBtnEvent;

		public function Button(text : String, textSize : Number, textColor : uint, width : Number, height : Number, bgColor : uint, lineThinkness : Number, lineColor : uint) {
			super();

			_text = text;
			_textSize = textSize;
			_textColor = textColor;
			_width = width;
			_height = height;
			_bgColor = bgColor;
			_lineThinkness = lineThinkness;
			_lineColor = lineColor;

			buildTextField();
			buildBackground();

			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, click);
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
			_txt.mouseEnabled = false;
			
			
		}

		private function buildTextField() : void {
			_tf = new TextFormat();
			_tf.color = _textColor;
			_tf.size = _textSize;
			_tf.kerning = true;
			_tf.bold = true;
			_tf.font ="verdana";

			_txt = new TextField();
			_txt.defaultTextFormat = _tf;
			_txt.text = _text;
			_txt.width = _width;
			_txt.selectable = false;
			_txt.autoSize = TextFieldAutoSize.CENTER;
			//Center Ver
			_txt.y = (_height*.5) - (_txt.height*.5);
			
			this.addChild(_txt);
		}

		private function buildBackground() : void {
			this.graphics.lineStyle(_lineThinkness, _lineColor);
			this.graphics.beginFill(_bgColor);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
		
		
		private function click( event : MouseEvent ) : void {
			_evt = new MenuBtnEvent("btnClick");
			_evt.name = _text;
			dispatchEvent(_evt);
			
		}
		
		
		private function out( event : MouseEvent ) : void {
			
		}

		private function over( event : MouseEvent ) : void {
			
		}
		
		
	}
}
