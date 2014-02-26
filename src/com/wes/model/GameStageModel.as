package com.wes.model {
	import com.wes.objects.Ingredient;
	import com.wes.events.ModelEvent;
	import flash.events.IEventDispatcher;

	/**
	 * @author Wesley DuSell
	 */
	public class GameStageModel extends Model {

		private var numLoaded : int = 0;
		public var numPics : int;

		public function GameStageModel(target : IEventDispatcher = null) {
			super(target);
		}

		override protected function xmlReady() : void {
			numPics = data.tile.length();
		 	var j:int;
		 	var k:int;
		 	var tileObj : TileObjectModel;
		 	var tempArray : Array = new Array();
		 	var xmlList:XMLList = new XMLList();
		 	
		 	if (difficutly == "Easy") {
			 	for (j = 0; j < numPics; ++j) {
			 		tileObj = new TileObjectModel(data.tile[j].dishName.toString(), 
			 															data.tile[j].pic.toString(), 
			 															data.tile[j].easy.question.toString(), 
			 															data.tile[j].easy.answer.toString());
			 		tileObj.addEventListener(ModelEvent.IMAGE_READY, checkNumOfThumbs);	 		
			 	}
		 	} else if (difficutly == "Medium") {
		 		for (j = 0; j < numPics; ++j) {
		 			tempArray = [];
		 			xmlList = data.tile[j].medium.answer;
		 			for (k = 0; k < xmlList.length(); ++k){
		 				var ingredient : Ingredient = new Ingredient(xmlList[k], xmlList[k]);
		 				tempArray.push(ingredient);
		 			}
		 			
			 		tileObj = new TileObjectModel(data.tile[j].dishName.toString(), 
			 															data.tile[j].pic.toString(), 
			 															data.tile[j].medium.question.toString(),
			 															null, 
			 															tempArray);
			 		tileObj.addEventListener(ModelEvent.IMAGE_READY, checkNumOfThumbs);
			 		var ingredientModel : IngredientsModel = new IngredientsModel();
			 		ingredientsArray = ingredientModel.ingredientsArray;
			 		
			 	}
		 	} else if (difficutly == "Hard") {
		 		for (j = 0; j < numPics; ++j) {
		 			tempArray = [];
		 			xmlList = data.tile[j].hard.answer;
		 			for (k = 0; k < xmlList.length(); ++k){
		 				var ingredientHard : Ingredient = new Ingredient(xmlList[k], xmlList[k]);
		 				tempArray.push(ingredientHard);
		 			}
			 		tileObj = new TileObjectModel(data.tile[j].dishName.toString(), 
			 															data.tile[j].pic.toString(), 
			 															data.tile[j].hard.question.toString(), 
			 															null,
			 															tempArray);
			 		tileObj.addEventListener(ModelEvent.IMAGE_READY, checkNumOfThumbs);	 		
			 	}
		 	}
		 	
		}
		
		
		protected function checkNumOfThumbs ( event : ModelEvent ) : void {
			++numLoaded;
			tileObject.push(event.target);
			tileObject = randomizeArray(tileObject);
			if(numPics == numLoaded){
				dispatchEvent(new ModelEvent(ModelEvent.MODEL_COMPLETE));
			}
		}
		
		private function randomizeArray(arr : Array) : Array {
			var len : int = arr.length;
			var temp : *;
			var i : int = len;
			while (i--) {
				var rand : int = Math.floor(Math.random() * len);
				temp = arr[i];
				arr[i] = arr[rand];
				arr[rand] = temp;
			}
			return arr;
		}
		
		

		
	}
}