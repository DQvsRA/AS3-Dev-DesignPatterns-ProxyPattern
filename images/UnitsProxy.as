package patterns.proxy
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class UnitsProxy extends Proxy
	{
		private var _count:uint = 0;
		
		public function UnitsProxy():void
		{

		}
		
		/**
		 * Overrides the behavior of an object property that can be called as a function. When a method of 
		 * the object is invoked, this method is called. While some objects can be called as functions,
		 * some object properties can also be called as functions.
		 */
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			
		}
		
		/**
		 * Overrides a call to change a property's value. If the property can't be found, this method
		 * creates a property with the specified name and value.
		*/
		override flash_proxy function setProperty(name:*, value:*):void
		{
			try
			{
				switch (name) 
				{
					case "numbersOf":
						_count++;
					break;
					default:
				}
			}
			catch (e:Error)
			{
				// respond to error here
			}
		}
		
		/**
		 * Overrides any request for a property's value.  If the property can't be found, the method 
		 * returns undefined. For more information on this behavior, see 
		 * the ECMA-262 Language Specification, 3rd Edition, section 8.6.2.1.
		 */
		override flash_proxy function getProperty(obj:*):*
		{
			try
			{
				switch (obj.toString()) 
				{
					case "numbersOf":
						return _count;
					break;
					default:
				}
			}
			catch (e:Error)
			{
				// respond to error here
			}
		}
				
		/**
		 * Overrides a request to check whether an object has a particular property by name.
		 * @param	name	The name of the property to check for.
		 * @return	If the property exists, true; otherwise false.
		 */
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return true;
		}
		
		/**
		 * Overrides the request to delete a property. When a property is deleted
		 * with the delete operator, this
		 * method is called to perform the deletion.
		*/
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			return false;
		}
		
		/**
		 * Allows enumeration of the proxied object's properties by index number. However, you cannot
		 * enumerate the properties of the Proxy class themselves. 
		 * This function supports implementing for...in and 
		 * for each..in loops on the object to retrieve property index values.
		 */
		override flash_proxy function nextNameIndex (index:int) : int
		{
			return 1;
		}
		/**
		 * Allows enumeration of the proxied object's properties by index number to 
		 * retrieve property names. However, you cannot
		 * enumerate the properties of the Proxy class themselves. 
		 * This function supports implementing for...in and 
		 * for each..in loops on the object to retrieve the desired names.
		 * For example (with code from Proxy.nextNameIndex()):
		 */
		override flash_proxy function nextName (index:int) : String
		{
			return "Hello";
		}
		
		/**
		 * Allows enumeration of the proxied object's properties by index number to 
		 * retrieve property values. However, you cannot
		 * enumerate the properties of the Proxy class themselves. 
		 * This function supports implementing for...in and 
		 * for each..in loops on the object to retrieve the desired values.
		 * 
		 *   For example (with code from Proxy.nextNameIndex()):
		 */
		override flash_proxy function nextValue(name:int):*
		{
			
		}
		
		/**
		* Checks whether a supplied QName is also marked as an attribute.
		 * @param	name	The name of the property to check.
		 * @return	Returns true if the argument for name is a QName that is also
		 *   marked as an attribute.
		 */
		override flash_proxy function isAttribute (name:*) : Boolean
		{
			return true;
		}
	
	}

}

