package patterns.proxy
{
	import flash.display.Sprite;
	import flash.events.Event;

	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	TweenPlugin.activate([TintPlugin]);
	
	/**
	 * Класс юнит
	 * @author Vladimir Minkin
	 */
	public class Unit extends Sprite implements IUnit
	{
		static public const 	UNIT_COLOR_PRODUCTION	:uint = 0x00FFFF;
		static public const 	UNIT_COLOR_CREATION		:uint = 0x66ff00;
		static public const 	UNIT_COLOR_SELECTED		:uint = 0x66ff00;
		static public const 	UNIT_COLOR_DESELECTED	:uint = 0xcccccc;
		
		private var 		_selected		:Boolean 	= false;
		private var 		scaleSelected	:uint		= 2;
		private var 		velocity		:uint;
		
		public function Unit()
		{
			init();
			addEventListener(Event.ADDED_TO_STAGE, handler_AddedToStage)
		}
		
		
		
		//==================================================================================================
		private function handler_AddedToStage(e:Event):void {
		//==================================================================================================	
			removeEventListener(Event.ADDED_TO_STAGE, handler_AddedToStage);
			velocity = this.stage.width;
		}
		
		//==================================================================================================
		private function init():void {
		//==================================================================================================	
			graphics.beginFill(UNIT_COLOR_DESELECTED);
			graphics.drawRect(-10, -10, 20, 20);
			graphics.endFill();
		}
		
		//==================================================================================================
		public function move(xPos:Number, yPos:Number):void {
		//==================================================================================================	
			var ptime:Number = utils_CalculatePathTime(xPos, yPos);
			TweenLite.to(this.parent, ptime, 
						{
							x:xPos,
							y:yPos,
							onComplete:function():void {
								TweenLite.killTweensOf(this.parent, false);
							}
						});
		}
		
		public function get select():Boolean 			{ return _selected; }
		public function set select(value:Boolean):void 	{ 
			_selected = value ? [ true, unit_SelectSkin() ][0] : [ false, unit_DeselectSkin() ][0]; 
		}
		
		/**
		 * Делаем объект выделенным, если в клипе были бы кадры то можно перейти на соответствующий кадр
		 */
		//==================================================================================================
		private function unit_SelectSkin():void {
		//==================================================================================================
			TweenLite.to(this, 2,
						{
							scaleX:scaleSelected,
							scaleY:scaleSelected,
							tint:UNIT_COLOR_SELECTED,
							ease:Elastic.easeOut,
							onComplete:function():void {
								TweenLite.killTweensOf(this, false);
							}
						});
		}
		
		/**
		 * Снимает выделение с объекта
		 */
		//==================================================================================================
		private function unit_DeselectSkin():void {
		//==================================================================================================	
			TweenLite.to(this, 2,
						{
							scaleX:1,
							scaleY:1,
							tint:UNIT_COLOR_DESELECTED,
							ease:Elastic.easeOut,
							onComplete:function():void {
								TweenLite.killTweensOf(this, false);
							}
						});
		}
		
		/**
		* Высчитывает время которое объект будет проходить на постоянной скорости
		*
		* Параметры: 
		*	конечные координаты
		* Возвращает:
		* 	время в секундах
		*/
		//==================================================================================================	
		private function utils_CalculatePathTime(xPos:Number, yPos:Number):Number {
		//==================================================================================================	
			return Math.round((Math.sqrt(Math.pow(this.parent.x - xPos, 2) + Math.pow(this.parent.y - yPos, 2)) / velocity) * 100) * 0.010;
		}
	}
}
