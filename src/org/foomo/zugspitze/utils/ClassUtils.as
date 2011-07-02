/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	[ExcludeClass]
	
	/**
	 * @link www.foomo.org
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class ClassUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value		The object for which a fully qualified class name is desired. Any ActionScript value may be passed to this method including all available ActionScript types, object instances, primitive types such as uint, and class objects
		 * @return 			A string containing the fully qualified class name
		 */
		public static function getQualifiedName(value:*):String
		{
			return getQualifiedClassName(value).replace('::', '.');
		}

		/**
		 *
		 */
		public static function getPackageName(value:*):String
		{
			var data:Array = getQualifiedClassName(value).split('::');
			return data[0];
		}

		/**
		 *
		 */
		public static function getClass(value:*):Class
		{
			return getDefinitionByName(ClassUtils.getQualifiedName(value)) as Class;
		}

		/**
		 *
		 */
		public static function getClassName(value:*):String
		{
			var data:Array = getQualifiedClassName(value).split('::');
			return data[1];
		}

		/**
		 *
		 */
		public static function callMethod(instance:Object, method:String, args:Array=null):*
		{
			if (!instance.hasOwnProperty(method) || !(instance[method] is Function)) throw new Error('No method ' + method + 'on  instance');
			var func:Function = (instance[method] as Function);
			return func.apply(instance, args);
		}

		/**
		 *
		 */
		public static function callMethodIfType(instance:Object, type:Class, method:String, args:Array=null):*
		{
			if (!(instance is type)) return null;
			return ClassUtils.callMethod(instance, method, args);
		}
	}
}