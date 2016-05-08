package  patterns.proxy
{
	/**
	 * Интерфейс определяющий структуру - юнит
	 * @author Vladimir Minkin
	 */
	public interface IUnit 
	{
		function set select(value:Boolean):void;
		function get select():Boolean;
		
		function set name(value:String):void;
		function get name():String;
		
		function move(xPos:Number, yPos:Number):void;
	}
}
