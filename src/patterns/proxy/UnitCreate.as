/**
 * Класс "обертка" для создания (строительства) юнита
 * @author Vladimir Minkin
 */
	
package patterns.proxy
{
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import flash.geom.Point;
	import flash.utils.Timer;

	public class UnitCreate extends Sprite implements IUnit
	{
		static private const CREATION_TIME:Number = 3;
		
		public var		unitObject			:Unit;		// Сам создаваемый юнит
		private var 	_selected			:Boolean,	// Тригер выбора
						_navigationPoint	:Point,		// Точка перемещения юнита
						_name				:String;	// Имя
				
		/**
		 * ТОТ самый прокси объект который является "контейнером" для будующего юнита
		 * @param	xPos - координата Х шелчка мыши
		 * @param	yPos - координата Y шелчка мыши
		 * @param	name - имя объекта
		 */
		public function UnitCreate(xPos:Number, yPos:Number, name:String = "name")
		{
			this._name 			= name;
			this.x 				= xPos;
			this.y 				= yPos;
			
			init_MakeBaseForm();
			init_StartCreation(CREATION_TIME);
		}
		
		/**
		 * NO OVERLOADING CONSTRUCTOR (like in C#)
		 * */
		//public function UnitCreate(xPos:Number, yPos:Number)
		//{
			//this.x 				= xPos;
			//this.y 				= yPos;
			//this._name  		= "Overloading";
			//
			//init_MakeBaseForm();
			//init_StartCreation(CREATION_TIME);
		//}
		//
		//public function UnitCreate()
		//{
			//this.x 				= 0;
			//this.y 				= 0;
			//this._name  		= "Overloading";
			//
			//init_MakeBaseForm();
			//init_StartCreation(CREATION_TIME);
		//}
		
		/**
		 * Создаем базовый вид "контейнера" на время пока "строится" юнит
		 */
		//==================================================================================================
		private function init_MakeBaseForm():void {
		//==================================================================================================	
			graphics.beginFill(Unit.UNIT_COLOR_PRODUCTION);
			graphics.drawRect(-10, -10, 20, 20);
			graphics.endFill();
		}
		
		/**
		 * Запускает таймер на создание юнита
		 * @param	time - время до создания юнита, в секундах 
		 */
		//==================================================================================================
		private function init_StartCreation(time:uint):void {
		//==================================================================================================	
			var timer:Timer = new Timer(time * 1000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler_CreationComplete, false, 0, true);
				timer.start();
		}
		
		//==================================================================================================
		private function handler_CreationComplete(e:TimerEvent):void {
		//==================================================================================================	
			var temp:Timer = e.currentTarget as Timer;
				temp.removeEventListener(TimerEvent.TIMER_COMPLETE, handler_CreationComplete);
				temp = null;
			
			this.graphics.clear();
			
			/**
			 * Создание "вещественного" юнита
			 */
			unitObject 			= new Unit();
			unitObject.name 	= _name;
			unitObject.select 	= _selected; // Если прокси-юнит был выбран, то и созданный реальный юнит будет выбран также
			
			addChild(unitObject);
			
			if (_navigationPoint) // Если во время "приготовления юниты" ему были переданы координаты для перемещения, то мы перемещаем юнита в указанную точку
				unitObject.move(_navigationPoint.x, _navigationPoint.y);
		}
		
		/**
		 * Перемещаем юнита если он создани, а если нет, то сохраняем координаты точки в которую его нужно переместить
		 * @param	xPos - х координата
		 * @param	yPos - у координата
		 */
		//==================================================================================================	
		public function move(xPos:Number, yPos:Number):void {
		//==================================================================================================		
			if (unitObject) unitObject.move(xPos, yPos);
			else  _navigationPoint = new Point(xPos, yPos);
		}
		
		public function set select(value:Boolean):void {
			!unitObject ? this._selected = value : unitObject.select = value
		}
		
		public function get select():Boolean {
			return !unitObject ? this._selected : unitObject.select;;
		}
	}
}
