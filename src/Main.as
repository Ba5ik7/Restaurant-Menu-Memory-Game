package {

	import flash.display.StageQuality;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import com.wes.events.MenuBtnEvent;
	import com.wes.model.GameStageModel;
	import com.wes.model.Model;
	import com.wes.views.HomePageMenu;
	import com.wes.views.Levels.Level;
	import com.wes.views.Levels.LevelLunch;

	[SWF( backgroundColor="#190f36", widthPercent="100", heightPercent="100", frameRate="70", quality="HIGH")]	
	public class Main extends RootStage{
				
		private var _menu : HomePageMenu;
		
		private var _model : Model;
		
		private var _level : Level;

		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			this.addEventListener(Event.ADDED_TO_STAGE, initz);
		}
		
		private function initz(event : Event) : void {
			this.removeEventListener(Event.ADDED_TO_STAGE, initz);
			this.buildHomePageMenu();
		}
			
		private function buildHomePageMenu () : void {
			var arr : Array = new Array("Lunch", "Dinner", "Wine", "Beer");
			_menu = new HomePageMenu(arr);
			this.addEventListener(MenuBtnEvent.DONE, loadLevel);
			this.addChild(_menu);
		}
		
		private function loadLevel ( event : MenuBtnEvent ) : void {
			this.removeEventListener(MenuBtnEvent.DONE, loadLevel);
			this.removeChild(_menu);

			_model = new GameStageModel();
			_model.difficutly = event.difficultyName;
			_model.loadXML(new URLRequest("xml/" + event.levelName + ".xml"));
			
			_level = new LevelLunch();
			_level.model = _model;
			_level.difficutly = event.difficultyName;
			this.addChild(_level);
			
			this.addEventListener(Event.ENTER_FRAME, render); 
			
			//TODO Add preloader here and listen for the view to complete or something like that
		}
		
		
		private function render( e:Event ):void{  
		   _level.tick();
		}

		
	}
}
