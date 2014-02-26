package com.wes.views.AnswerForms {
	import com.wes.objects.Button;
	import com.wes.objects.CheckBox;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	/**
	 * @author root
	 */
	public class AnswerFromCheckBox extends AnswerForm {
		
		
		
		public function AnswerFromCheckBox() {
			super();
			
			buildQustionField();
			createBtn();
			
		}
		
		private function buildQustionField() : void {
			questionText = new TextField();
			questionText.defaultTextFormat = _tf;
			questionText.selectable = false;
			questionText.text = "";
			questionText.width = 500;
			questionText.multiline = true;
			questionText.wordWrap = true;
			questionText.autoSize = TextFieldAutoSize.LEFT;

			questionText.alpha = 0;
			this.addChild(questionText);
		}
		
		override public function buildCheckBoxs () : void {
			buildAnswerArray();
			
			var index : Number ;
			var i:int;
			for(i = 0; i < 5; ++i) {
				var k : int;
				for(k = 0; k < 4; ++k) {
					
					if (currentIngredientArray.name == null){
						index = (i * 4 + k);
						var checkBox : CheckBox = new CheckBox(currentIngredientArray[index].name, currentIngredientArray[index].value);
						checkBox.x = (k * 150);
						checkBox.y = (i * 50);
						
						this.addChild(checkBox);	
					}
					
				}
			}
			
			
			
		}

		private function buildAnswerArray() : void {
			var howManyToGet : Number = new Number(20 - answerArray.length);
			var i : int;
			for (i = 0; i < howManyToGet; ++i){
				currentIngredientArray.push(ingredientArray[i]);
			}
			
			var k : int;
			for (k = 0; k < answerArray.length; ++k) {
				currentIngredientArray.push(answerArray[k]);
			}
		}
		
		
		private function createBtn() : void {
			btn = new Button("Submit", 16, 0xFFFFFF, 75, 25, 0x000000, 1, 0xFF0000);
			btn.x = questionText.width - btn.width;
			btn.y = questionText.height + answerText.height + 35;

			btn.alpha = 0;
			addChild(btn);
		}
		
	}
}
