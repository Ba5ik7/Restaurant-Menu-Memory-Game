package com.wes.views.Levels {
	import com.wes.views.AnswerForms.AnswerFromCheckBox;
	import com.wes.views.AnswerForms.AnswerForm;
	import away3d.containers.ObjectContainer3D;
	import away3d.events.MouseEvent3D;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Cube;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import com.wes.events.ModelEvent;
	import com.wes.objects.Hippo.Hippo;
	import com.wes.objects.Tile;
	import com.wes.views.AnswerForms.AnswerFormText;
	
	
	
	import away3d.primitives.Trident;
	import com.wes.objects.Button;



	/**
	 * @author root
	 */
	public class LevelLunch extends Level {
		private var woodtexture : BitmapData = new TextureWood();
		private var cardsholder : ObjectContainer3D = new ObjectContainer3D();
		private var cube : Cube;
		private var row : int = 6;
		private var col : int = 4;
		private var	xgap : int = 10;
		private var	ygap : int = 10;
		private var picWidth : Number;
		private var	picHeight : Number;
		private var thumbWidth : Number;
		private var	thumbHeight : Number;
		private var closePosRect : Rectangle;
		private var openPosRect : Rectangle;
		private var currentPicIndex : int;
		private var tilesToLoad : Array;
		private var numTiles : int;
		private var numPics : int;
		private var pageShift : int;
		private var numCorrect : int;
		private var numDoneTweening : int;
		private var tiles : Array;
		private var currentCards : Array;
		private var selectedCard1 : Tile = null;
		private var selectedCard2 : Tile = null;
		private var disableMouseEvents : Boolean = false;
		private var camMoving : Boolean = false;
		private var questionFrom : AnswerForm;
		private var gridAmount : int = 2;
		private var gridNumber : int = 0;
		private var hippo : Hippo;
		private var timer : Timer;

		public function LevelLunch() {
			tiles = [];
			currentCards = [];
		}

		override protected function modelComplete(event : ModelEvent) : void {
			trace("Starting Now");
			
			numPics = _model.tileObject.length;
			numTiles = row * col;
			pageShift = numTiles;

			thumbWidth = _model.tileObject[1]._thumbImage.width;
			thumbHeight = _model.tileObject[1]._thumbImage.height;
			picWidth = thumbWidth * row;
			picHeight = thumbHeight * col;
			
			
			
			var closePosRectX : Number = (RootStage.stage.stageWidth * .5) - (picWidth * .5);
			var closePosRectY : Number = (RootStage.stage.stageHeight * .5) - (picHeight * .5);
			closePosRect = new Rectangle(closePosRectX - 300, closePosRectY - 250, picWidth / 2, picHeight / 2);

			// there is really only 3 gaps in 4 thumbs
			var openRectWidth : Number = ((row - 1) * xgap) + picWidth;
			var openRectHeight : Number = ((col - 1) * ygap) + picHeight;
			var openPosRectX : Number = (RootStage.stage.stageWidth * .5) - (openRectWidth * .5) ;
			var openPosRectY : Number = (RootStage.stage.stageHeight * .5) - (openRectHeight * .5);
			openPosRect = new Rectangle(openPosRectX - 300, openPosRectY - 250, openRectWidth, openRectHeight);

			tilesToLoad = _model.tileObject.slice(0, 12);

			createGround(openRectWidth, openRectHeight);
			createCards();
			createQuestionForm();
			//done();
			sepBtn();
		}

		private function createQuestionForm() : void {
			trace(difficutly);
			if (difficutly == "Easy") {
				questionFrom = new AnswerFormText();
				//Hard coded
				questionFrom.x = 262;
				addChild(questionFrom);
			} else if (difficutly == "Medium") {
				questionFrom = new AnswerFromCheckBox();
				//Hard coded
				questionFrom.x = 450;
				addChild(questionFrom);
			} else if (difficutly == "Hard") {
				
			}
		}

		private function createGround(openRectWidth : Number, openRectHeight : Number) : void {
			cube = new Cube({width:openRectWidth + 100, depth:openRectHeight + 50, height:50, pushback:true, ownCanvas:true, material:new BitmapMaterial(woodtexture)});
			cube.mouseEnabled = false;
			scene.addChild(cube);
		}

		private function createCards() : void {
			currentCards = null;
			currentCards = [];

			var i : int = new int(0);
			for (i; i < tilesToLoad.length; ++i) {
				var img : BitmapData = new BitmapData(tilesToLoad[i]._thumbImage.width, tilesToLoad[i]._thumbImage.height);
				img.draw(tilesToLoad[i]._thumbImage, null, null, null, null, true);

				var card1 : Tile = new Tile(img, i);
				card1.mouseEnabled = true;

				var card2 : Tile = new Tile(img, i);
				card2.mouseEnabled = true;

				currentCards.push(card1);
				currentCards.push(card2);
				
			}

			currentCards = randomizeCards(currentCards);
			setUpTiles();
		}

		private function randomizeCards(arr : Array) : Array {
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

		private function setUpTiles() : void {
			var index : Number ;
			for (var i : int = 0; i <= col - 1; ++i) {
				for (var j : int = 0; j <= row - 1; ++j) {
					index = (i * row + j);
					var cardwidth : Number = currentCards[index].width;
					var cardheight : Number = currentCards[index].height;

					currentCards[index].openPosition.x = openPosRect.x + (j * (cardwidth + xgap) + cardwidth);
					currentCards[index].openPosition.y = openPosRect.y + (i * (cardheight + ygap) + cardheight);
					currentCards[index].closedPosition.x = closePosRect.x + (j * (cardwidth - .5) + cardwidth);
					currentCards[index].closedPosition.y = closePosRect.y + (i * (cardheight - .5) + cardheight);
					currentCards[index].x = 700;
					currentCards[index].z = -150;
					currentCards[index].y = 50;
					currentCards[index].rotationZ = 540;
					cardsholder.addChild(currentCards[index]);

					var d : Number = new Number(index/4);
					TweenMax.to(currentCards[index], .8, {delay:d, x:currentCards[index].openPosition.x, z:currentCards[index].openPosition.y, y:0, rotationZ:180, ease:Expo.easeOut});
					currentCards[index].addEventListener(MouseEvent3D.MOUSE_DOWN, onTileClick);
				}
			}

			var cardswidth : Number = (5 * cardwidth) + (4 * xgap);
			var cardsheight : Number = (2 * cardheight) + (1 * ygap);
			cardsholder.x = (-cardswidth) / 2;
			cardsholder.z = (-cardsheight) / 2;
			scene.addChild(cardsholder);
		}

		private function resetTiles(event : TimerEvent) : void {
			timer.removeEventListener(TimerEvent.TIMER, resetTiles);
			var index : int ;
			for (var i : int = 0; i <= col - 1; ++i) {
				for (var j : int = 0; j <= row - 1; ++j) {
					index = (i * row + j);
					var d : Number = Math.random() * 1;
					TweenMax.to(currentCards[index], 1, {delay:d, x:700, z:-150, y:50, rotationZ:180, onComplete:countTiles, ease:Expo.easeOut});
					currentCards[index].removeEventListener(MouseEvent3D.MOUSE_DOWN, onTileClick);
				}
			}
		}

		private function countTiles() : void {
			numDoneTweening++;
			if (numDoneTweening == numTiles) {
				var index : int ;
				for (var i : int = 0; i <= col - 1; ++i) {
					for (var j : int = 0; j <= row - 1; ++j) {
						index = (i * row + j);
						cardsholder.removeChild(currentCards[index]);
					}
				}
				
				
				if (gridNumber == gridAmount) {
					done();
				} else {
					createCards();
				}
				numDoneTweening = 0;
			}
		}

		private function onTileClick(event : MouseEvent3D) : void {
			if (disableMouseEvents == false ) {
				if (selectedCard1 == null) {
					selectedCard1 = event.currentTarget as Tile;
					selectedCard1.mouseEnabled = false;
				} else {
					if (selectedCard2 == null) {
						disableMouseEvents = true;
						selectedCard2 = event.target as Tile;
						selectedCard2.mouseEnabled = false;
						waitForDecision();
					}
				}
				TweenMax.to(event.currentTarget, 1, {y:50, rotationZ:0, ease:Expo.easeOut});
			}
		}

		private function waitForDecision() : void {
			timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, makeDecision);
			timer.start();
		}

		private function makeDecision(event : TimerEvent) : void {
			timer.removeEventListener(TimerEvent.TIMER, makeDecision);
			if (selectedCard1.which == selectedCard2.which) {
				TweenMax.to(selectedCard1, 1, {y:0, ease:Expo.easeOut});
				TweenMax.to(selectedCard2, 1, {y:0, ease:Expo.easeOut, onComplete:correctTiles});
			} else {
				TweenMax.to(selectedCard1, 1, {y:0, rotationZ:180, ease:Expo.easeOut});
				TweenMax.to(selectedCard2, 1, {y:0, rotationZ:180, ease:Expo.easeOut});
				selectedCard1.mouseEnabled = true;
				selectedCard2.mouseEnabled = true;
				disableMouseEvents = false;
				selectedCard1 = null;
				selectedCard2 = null;
			}
		}

		private function correctTiles() : void {
			currentPicIndex = selectedCard2.which;
			
			if (difficutly == "Easy") {
				questionFrom.answer = tilesToLoad[currentPicIndex]._answer;
				questionFrom.btn.addEventListener(MouseEvent.CLICK, questionSubmited);
				questionFrom.questionText.text = tilesToLoad[currentPicIndex]._question;
				questionFrom.answerText.addEventListener(KeyboardEvent.KEY_DOWN, enterBtnPressed);
				questionFrom.show();
				
				TweenMax.to(view.camera, 1, {x:0, y:1000, z:500, fov:30, ease:Expo.easeOut});
			} else if (difficutly == "Medium") {
				questionFrom.answerArray = tilesToLoad[currentPicIndex]._answerArray;
				questionFrom.questionText.text = tilesToLoad[currentPicIndex]._question;
				questionFrom.ingredientArray = _model.ingredientsArray;
				questionFrom.buildCheckBoxs();
				questionFrom.show();
				
				TweenMax.to(view.camera, 1, {x:0, y:1000, z:500, fov:30, ease:Expo.easeOut});
			} else if (difficutly == "Hard") {
				
			}
			




			var index : int;
			var matrix : Matrix = new Matrix(1, 0, 0, 1);
			var bd : BitmapData = Bitmap(tilesToLoad[currentPicIndex]._fullImage).bitmapData;

			for (var i : int = 0; i <= col - 1; ++i) {
				for (var j : int = 0; j <= row - 1; ++j) {
					index = (i * row + j);

					var delay : Number = Math.random() * .05;
					TweenMax.to(currentCards[index], 1, {delay:delay, x:currentCards[index].closedPosition.x, z:currentCards[index].closedPosition.y, rotationZ:0, ease:Expo.easeOut});

					matrix.tx = (-j ) * picWidth / row;
					matrix.ty = (-i ) * picHeight / col;

					var s : Sprite = new Sprite();
					s.graphics.clear();
					s.graphics.beginBitmapFill(bd, matrix, false, false);
					s.graphics.drawRect(0, 0, currentCards[index].width, currentCards[index].height);
					s.graphics.endFill();

					var bmd : BitmapData = new BitmapData(currentCards[index].width, currentCards[index].height, false, 0x0000FF);
					bmd.draw(s);

					currentCards[index].thumbnailHolder.material = new BitmapMaterial(bmd);
				}
			}

			
		}
		
		private function enterBtnPressed(event:KeyboardEvent) : void {
		   	if(event.charCode == 13){
		   		questionFrom.answerText.removeEventListener(KeyboardEvent.KEY_DOWN, enterBtnPressed);
		       	questionSubmited();
		   	}
		}
		//TODO Add if else Easy Medium Hard 
		/**
		 * Easy the same
		 * Medium and Hard check a array to see if the list of anwsers match the selected Checkboxs  
		 **/
		private function questionSubmited(event : MouseEvent = null) : void {
			if (questionFrom.answer == questionFrom.answerText.text) {
				selectedCard1.done = true;
				selectedCard2.done = true;
				separate();
				questionFrom.rightHide();
				numCorrect += 2;
				checkCorrectAmount();
			} else {
				separate();
				selectedCard1.mouseEnabled = true;
				selectedCard2.mouseEnabled = true;
				questionFrom.wrongHide();
			}
			selectedCard1 = null;
			selectedCard2 = null;
		}

		private function separate(event : MouseEvent = null) : void {
			for each (var thumb:Tile in currentCards) {
				var d : Number = Math.random() * .05;
				if (thumb.done != true) {
					TweenMax.to(thumb, 1, {delay:d, x:thumb.openPosition.x, z:thumb.openPosition.y, rotationZ:180, ease:Expo.easeOut});
				} else {
					TweenMax.to(thumb, 1, {delay:d, x:thumb.openPosition.x, z:thumb.openPosition.y, rotationZ:0, ease:Expo.easeOut});
				}
				thumb.resetMaterial();
			}

			camMoving = true;

			TweenMax.to(view.camera, 1, {x:0, y:700, z:500, fov:30, ease:Expo.easeOut});
			disableMouseEvents = false;
		}

		private function checkCorrectAmount() : void {
			if (numCorrect == numTiles) {
				gridNumber++;
				numCorrect = 0;
				tilesToLoad = _model.tileObject.slice(12, 24);
				timer = new Timer(1500, 1);
				timer.addEventListener(TimerEvent.TIMER, resetTiles);
				timer.start();
			}
		}
		
		
		private function done () :void {
			hippo = new Hippo();
			hippo.scaleX = hippo.scaleY = 2;
			this.addChild(hippo);
			timer = new Timer(5000, 1);
			timer.addEventListener(TimerEvent.TIMER, removeHip);
			timer.start();
		}
		
		private function removeHip (event : TimerEvent) : void {
			this.removeChild(hippo);
		}

		// Debug*********************************************************
		private function sepBtn() : void {

			/*var btn : Button = new Button("next grid**", 16, 0xFFFFFF, 200, 25, 0x000000, 1, 0xFF0000);
			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK, nextGrid);*/
			
			var btna : Button = new Button("collapse Debug**", 16, 0xFFFFFF, 200, 25, 0x000000, 1, 0xFF0000);
			btna.y = 10;
			addChild(btna);
			btna.addEventListener(MouseEvent.CLICK, collapse);
				
			var btnb : Button = new Button("separate Debug**", 16, 0xFFFFFF, 200, 25, 0x000000, 1, 0xFF0000);
			btnb.y = btna.height +10;
			addChild(btnb);
			btnb.addEventListener(MouseEvent.CLICK, separate);
				
			var axis:Trident = new Trident(180);
			scene.addChild(axis);
		}

			
		/*private function nextGrid (event:MouseEvent) : void {
			gridNumber++;
			tilesToLoad = _model.tileObject.slice(12, 24);
			timer = new Timer(1500, 1);
			timer.addEventListener(TimerEvent.TIMER, resetTiles);
			timer.start();
		}*/
		
		private function collapse (event : MouseEvent ) : void {
			selectedCard2 = currentCards[3];
			correctTiles();
		}
		// Debug*********************************************************/
		
		
		
		override protected function childSpecificUpdating() : void {
		}
	}
}
