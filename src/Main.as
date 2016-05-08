package
{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import flash.events.MouseEvent;
	
	import patterns.proxy.IUnit;
	import patterns.proxy.UnitCreate;
	import patterns.proxy.Unit;
	
	[SWF(width="900",height="480",backgroundColor="#111111",frameRate="31")]
	public class Main extends Sprite
	{
		private var 	unit			:IUnit;
		private var 	selectedUnit	:IUnit;
		private var 	unitCount		:uint = 1;
		private var 	selectedArray	:Array = [];
		
		public function Main()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener(MouseEvent.CLICK, handler_MouseClick);
		}
		
		/**
		* Обработчик щелчка мыши на всей "сцене"
		*/
		//==================================================================================================	
		private function handler_MouseClick(e:MouseEvent):void	{
		//==================================================================================================
			/**
			 * Проверяем что нужно делать при клике:
				 * создавать нового юнита 
				 * выделить юнита
				 * управлять уже созданным
			 */
			// СОЗДАНИЕ НОВОГО ЮНИТА ПРИ КЛИКЕ С ЗАЖАТЫМ CTRL
			if (!(e.target is Unit) && e.ctrlKey)
			{
				if (selectedUnit != null && selectedUnit.select)
					selectedUnit.select = false;
				
				unit = new UnitCreate(mouseX, mouseY, "unit_" + unitCount);
				//unit = new UnitCreate();
				unit.name = "unitProxy_" + (unitCount++);
				unit.select = true;
				
				selectedUnit = unit as IUnit;
				stage.addChild(DisplayObject(selectedUnit));
			}
			// ВЫБИРАЕМ ЮНИТА НА КОТОРЫЙ ШЕЛКНУЛИ (если он уже не выбран)
			else if ((e.target is IUnit) && e.target != selectedUnit)
			{
				if (selectedUnit != null) // Если у нас есть выбранный юнит, то мы снимаем с него выделение
					selectedUnit.select = false;
					
				selectedUnit = e.target as IUnit; 	// Запоминаем юнита на который кликнули
				selectedUnit.select = true; 		// Делаем выбранного юнита выделенным
			}
			// ПЕРЕМЕЩАЕМ ЮНИТА В УКАЗАННУЮ ТОЧКУ
			else {
				if (selectedUnit != null)
					selectedUnit.move(mouseX, mouseY);
			}
		}
	}
}
