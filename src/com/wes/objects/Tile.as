package com.wes.objects {
	import away3d.materials.BitmapMaterial;
	import flash.display.BitmapData;
	import away3d.primitives.Plane;
	import away3d.containers.ObjectContainer3D;
	import flash.geom.Point;

	/**
	 * @author Wesley DuSell
	 */
	public class Tile extends ObjectContainer3D {

		public var openPosition:Point;
		public var closedPosition:Point;
		public var color:uint;				
		public var thumbnailHolder:Plane;
		public var tileBack : Plane;
		
		public var which : Number;
		public var done : Boolean = false;
		
		public var width : Number;
		public var height : Number;
		
		
		
		private var backtexture:BitmapData = new TextureBack();
		private var fronttexture:BitmapData;
		
		public function Tile( texture:BitmapData, id : Number ) {
			fronttexture = texture;
			width = texture.width;
			height = texture.height;
			
			openPosition = new Point();
			closedPosition = new Point();
			thumbnailHolder = new Plane({width:texture.width, height:texture.height, material: new BitmapMaterial(texture,{smooth:true})});
			thumbnailHolder.mouseEnabled = false;
			tileBack = new Plane({width:texture.width, height:texture.height, material: new BitmapMaterial(backtexture,{smooth:true})});
			
			thumbnailHolder.bothsides = true;
			thumbnailHolder.rotationZ=180;
			thumbnailHolder.rotationY=180;
			
    		tileBack.rotationZ=180;  
    		tileBack.rotationY=180;
    		tileBack.mouseEnabled = true;
			
			this.which = id;
			this.addChild(thumbnailHolder);
			this.addChild(tileBack);
			this.ownCanvas = true;
			this.mouseEnabled = true;
			this.rotationZ=180;
		}
		
		
		public function resetMaterial () : void {
			thumbnailHolder.material = new BitmapMaterial(fronttexture);
			
		}
	}
}
