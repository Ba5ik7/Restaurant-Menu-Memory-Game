package com.wes.views {
	import com.greensock.easing.Expo;
	import com.greensock.TweenMax;
	import com.wes.events.MenuBtnEvent;
	import flash.display.Sprite;
	import com.wes.objects.Button;

	/**
	 * @author root
	 */
	public class HomePageMenu extends Sprite {
		
		private var _dataArr : Array = new Array();
		private var levelBtns : Array = new Array();
		private var difficultyBtns : Array = new Array();
		
		private var _evt : MenuBtnEvent;
		
		private var numOfButtonsDone : Number = 0;
		
		public var level : String;
		public var difficulty : String;
		
		public function HomePageMenu( dataArr : Array ) {
			_dataArr = dataArr;
			this.builtMenu();
			super();
		}
		
		
		
		private function builtMenu () : void {
			var i : String;
			var k : int;
			var delay : Number = 0;
			k = 0;
			for each (i in _dataArr){
				var btn : Button = new Button(i, 24, 0xFFFFFF, 350, 50, 0x000000, 1, 0xFF0000);
				btn.y = -150;
				btn.x = (RootStage.stage.stageWidth*.5)-(btn.width*.5);
				btn.addEventListener(MenuBtnEvent.BTNCLICK, levelSelected);
				levelBtns.push(btn);
				this.addChild(btn);
				TweenMax.to(btn, .5, {delay:delay, y:((RootStage.stage.stageHeight*.5)-(btn.height*(_dataArr.length-1)))+(btn.height + 25)*k, ease:Expo.easeOut});
				
				delay += .3;
				++k;
			}
		}

		private function levelSelected(event:MenuBtnEvent) : void {
			level = event.name;
			var i : Button;
			var delay : Number = 0;
			for each (i in levelBtns){
				TweenMax.to(i, .5, {delay:delay, y:(RootStage.stage.stageHeight + 150), onComplete:countLevelBtns, ease:Expo.easeOut});
				delay += .3;
			}
			builtDifficultyBtns();
			
		}


		//This is hard coded only 3 levels call (eg. Easy, Medium, Hard)
		//TODO Make this better fool
		private var difficultyArray :Array = new Array("Easy", "Medium", "Hard");
		private function builtDifficultyBtns() : void {
			var i:int = 0;
			var delay : Number = 0;
			for (i; i < difficultyArray.length; ++i) {
				var btn : Button = new Button(difficultyArray[i], 24, 0xFFFFFF, 350, 50, 0x000000, 1, 0xFF0000);
				btn.y = -150;
				btn.x = (RootStage.stage.stageWidth*.5)-(btn.width*.5);
				btn.addEventListener(MenuBtnEvent.BTNCLICK, difficultySelected);
				difficultyBtns.push(btn);
				this.addChild(btn);
				TweenMax.to(btn, .5, {delay:delay, y:((RootStage.stage.stageHeight*.5)-(btn.height*(_dataArr.length-1)))+(btn.height + 25)*i, ease:Expo.easeOut});
				
				
				delay += .3;
			}
		
		}

		private function difficultySelected(event : MenuBtnEvent) : void {
			difficulty = event.name;
			var i : Button;
			var delay : Number = 0;
			for each (i in difficultyBtns){
				TweenMax.to(i, .5, {delay:delay, y:(RootStage.stage.stageHeight + 150), onComplete:countDifficultyBtns, ease:Expo.easeOut});
				delay += .3;
			}
			
			
			
		}
		
		

		private function countLevelBtns () : void {
			numOfButtonsDone++;
			if (numOfButtonsDone == levelBtns.length) {
				var i : Button;
				for each (i in levelBtns){
					i.removeEventListener(MenuBtnEvent.BTNCLICK, levelSelected);
					removeChild(i);
				}
				levelBtns = [];
				numOfButtonsDone = 0;
			}
		}
		
		
		private function countDifficultyBtns () : void {
			numOfButtonsDone++;
			if (numOfButtonsDone == difficultyBtns.length) {
				var i : Button;
				for each (i in difficultyBtns){
					i.removeEventListener(MenuBtnEvent.BTNCLICK, difficultySelected);
					removeChild(i);
				}
				difficultyBtns = [];
				numOfButtonsDone = 0;
				_evt = new MenuBtnEvent("done");
				_evt.levelName = level;
				_evt.difficultyName = difficulty;
				dispatchEvent(_evt);
			}
		}
		
		
	}
}
