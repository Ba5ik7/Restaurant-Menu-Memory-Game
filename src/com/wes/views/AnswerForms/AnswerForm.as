package com.wes.views.AnswerForms {
	import com.wes.objects.CheckBox;
	import flash.text.TextFormat;
	import com.wes.objects.Button;
	import flash.text.TextField;
	import flash.display.Sprite;
	/**
	 * @author root
	 */
	public class AnswerForm extends Sprite {
		
		public var questionText : TextField;
		public var answerText : TextField;
		public var checkBox : CheckBox;
		public var btn: Button;
		public var answer : String = new String();
		public var answerArray : Array = new Array();
		public var ingredientArray : Array = new Array();
		public var currentIngredientArray : Array = new Array();
		
		
		protected var _tf : TextFormat;
		
		public function AnswerForm() {
			_tf = new TextFormat();
			_tf.color = 0xFFFFFF;
			_tf.font = "verdana";
			_tf.size = 16;
			_tf.kerning = true;
			_tf.bold = true;
		
		}
		
		public function rightHide() : void {
		}
		
		public function wrongHide() : void {
		}
		
		public function show() : void {
		}
		
		public function buildCheckBoxs () : void {
			
		}
		
		
		
	}
}
