package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class Test extends Sprite
	{
		
		public function Test() 
		{
				this.addEventListener(Event.ADDED_TO_STAGE, init);
				this.stage.addEventListener(Event.RESIZE, resize)
			
		}
		
		private function resize(e:Event):void 
		{
			trace(stage.stageWidth)
			trace(stage.stageHeight)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			var dobj:Sprite = new Sprite();
				dobj.graphics.beginFill(0xffcc00, 1);
				dobj.graphics.drawCircle(0, 0, 30);
				dobj.graphics.endFill();
				
				this.addChild(dobj)
				
				dobj.x = this.stage.stageWidth / 2;
				dobj.y = this.stage.stageHeight/ 2;
			
		}
		
	}

}
