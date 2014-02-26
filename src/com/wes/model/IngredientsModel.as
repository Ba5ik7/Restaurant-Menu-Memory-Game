package com.wes.model {
	import flash.net.URLRequest;
	import com.wes.objects.Ingredient;
	import com.wes.model.Model;

	/**
	 * @author root
	 */
	public class IngredientsModel extends Model {

		private var path : URLRequest = new URLRequest("xml/ingredients.xml");
		
		public function IngredientsModel() {
			loadXML(path);
		}
		
		override protected function xmlReady () : void {
			var xmlList : XMLList = new XMLList(data.item);
			var i : int;
			for (i = 0; i < xmlList.length(); ++i) {
				var ingredient : Ingredient = new Ingredient(xmlList[i].@name, xmlList[i].@value);
				ingredientsArray.push(ingredient);
			}
		}
	}
}
