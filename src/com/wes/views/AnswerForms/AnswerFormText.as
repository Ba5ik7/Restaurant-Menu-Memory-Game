package com.wes.views.AnswerForms {
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import com.wes.objects.Button;

	
	/**
	 * @author root
	 */
	 
	public class AnswerFormText extends AnswerForm {
		// TODO Add a form to create an grid of Checkboxs
		/*
		 * Check the length of the answers 
		 * then ramdomly select wines or ingrentants  
		 */
		
		
		private var padding : Number = 25;

		
		
		public function AnswerFormText () {
			
			
			super();
			
			buildQustionField();
			buildAnswerTextField();

			createBtn();
			wrongHide();
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

		private function buildAnswerTextField() : void {
			answerText = new TextField();
			answerText.type = TextFieldType.INPUT;
			answerText.defaultTextFormat = _tf;
			answerText.text = "";
			answerText.y = questionText.height + padding;
			answerText.width = 500;
			answerText.multiline = false;
			answerText.wordWrap = true;
			answerText.border = true;
			answerText.borderColor = 0xFF0000;
			answerText.autoSize = TextFieldAutoSize.LEFT;

			answerText.alpha = 0;
			this.addChild(answerText);
		}

		private function createBtn() : void {
			btn = new Button("Submit", 16, 0xFFFFFF, 75, 25, 0x000000, 1, 0xFF0000);
			btn.x = questionText.width - btn.width;
			btn.y = questionText.height + answerText.height + 35;

			btn.alpha = 0;
			addChild(btn);
		}

		override public function rightHide() : void {
			answerText.text = "";
			questionText.text = "Good Job :)";
			answerText.mouseEnabled = false;
			btn.mouseEnabled = false;
			TweenMax.to(btn, 1, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(answerText, 1, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(questionText, 1, {delay:3, alpha:0, ease:Expo.easeOut});
		}

		override public function wrongHide() : void {
			answerText.text = "";
			questionText.text = "Sorry try again :(";
			answerText.mouseEnabled = false;
			btn.mouseEnabled = false;
			TweenMax.to(btn, 1, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(answerText, 1, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(questionText, 1, {delay:3, alpha:0, ease:Expo.easeOut});
		}

		override public function show() : void {
			answerText.mouseEnabled = true;
			RootStage.stage.focus = answerText;
			btn.mouseEnabled = true;
			TweenMax.to(btn, 1, {alpha:1, ease:Expo.easeOut});
			TweenMax.to(answerText, 1, {alpha:1, ease:Expo.easeOut});
			TweenMax.to(questionText, 1, {alpha:1, ease:Expo.easeOut});
		}
		
	}
}
