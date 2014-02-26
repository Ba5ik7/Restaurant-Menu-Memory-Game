package com.wes.objects.Hippo {
	import flash.display.Sprite;

	/**
	 * @author Wesley Dodo Pants
	 */
	public class Hippo extends Sprite {
		
		[Embed(source="hippo.swf")]
			private var HippoMC:Class;
		
		public function Hippo() {
			var hippo:Sprite = new HippoMC();
			addChild(hippo);
		}
		
	}
}
