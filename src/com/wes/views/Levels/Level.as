package com.wes.views.Levels {
	import away3d.cameras.TargetCamera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import flash.events.Event;
	import com.wes.events.ModelEvent;
	import com.wes.model.Model;
	import flash.display.Sprite;

	/**
	 * @author root
	 */
	public class Level extends Sprite {
		
		public var _model : Model;
		
		public var difficutly : String;
		
		protected var scene:Scene3D;  
		protected var camera:TargetCamera3D;  
		protected var view:View3D;
		
		
		public function Level() {
			super();
			scene = new Scene3D();  
			
			camera = new TargetCamera3D({x:0, y:700, z:500});
			
			
			view = new View3D({scene:scene, camera:camera});  
			view.x = RootStage.stage.stageWidth/2;
			view.y = RootStage.stage.stageHeight/2;
			addChild(view);
		}
		
		
		public function set model(m : Model) : void {
			_model = m;
			_model.addEventListener(ModelEvent.MODEL_COMPLETE, modelComplete);
		}
		
		// When you add data from the model
		protected function modelComplete(event : ModelEvent) : void {
		}
		
		
		// // ////////////////////////////////////////////////////////////
		public function tick(event : Event = null) : void {
			view.render();
			childSpecificUpdating();
			
		}

		// Ticker for each view
		protected function childSpecificUpdating() : void {
		}
		// // ////////////////////////////////////////////////////////////
		
	}
}
