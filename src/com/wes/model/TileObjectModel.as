package com.wes.model {
	import com.wes.events.ModelEvent;
	import flash.display.PixelSnapping;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.events.Event;
	import flash.display.Bitmap;
	/**
	 * @author root
	 */
	public class TileObjectModel extends GameStageModel {
		
		public var _title : String = new String();
		public var _fullImage : Bitmap;
		public var _thumbImage : Bitmap;
		public var _question : String = new String();
		public var _answer : String = new String();
		public var _answerArray : Array = new Array();
		
		private var bmdThumb : BitmapData;
		private var bmdFull : BitmapData;
		private var scaleX:Number = 0.25;
		private	var scaleY:Number = 0.25;
		private	var matrix:Matrix = new Matrix();
		private	var thumbWidth:Number = 100;
		private	var thumbHeight:Number = 112.5;
		
		public function TileObjectModel(title : String, imgUrl : String, question : String, answer : String = null, answerArray:Array = null) {
			_title = title;
			_question = question;
			if(answer != null)
				_answer = answer;
			if(answerArray != null)
				_answerArray = answerArray;
			
			
			super.loadImage(imgUrl);
		}
		
		override protected function imageLoaded (event : Event) :void {
			
			bmdFull = new BitmapData(event.target.content.width, event.target.content.height, false, 0x0000FF);
			bmdFull.draw(event.target.content, null, null, null, null, true);
			_fullImage = new Bitmap(bmdFull, PixelSnapping.NEVER, true);
			bmdFull = null;
			
			matrix.scale(scaleX, scaleY);
			bmdThumb = new BitmapData(event.target.content.width * scaleX, event.target.content.height * scaleY, false, 0x0000FF);
			bmdThumb.draw(event.target.content, matrix, null, null, null, true);
			_thumbImage = new Bitmap(bmdThumb, PixelSnapping.NEVER, true);
			_thumbImage.width = thumbWidth;
			_thumbImage.height = thumbHeight;
			bmdThumb = null;
			
			//Clean up
			super.imageLoaded(event);
			dispatchEvent(new ModelEvent(ModelEvent.IMAGE_READY ));
		}
		
	}
}