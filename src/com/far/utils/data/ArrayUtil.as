package com.far.utils.data
{

	/**
	 * ... 数组工具类 ...
	 *
	 */
	public final class ArrayUtil
	{
		/**
		 * 生成指定长度的随机数数组
		 * @param	startNum:int (default = 1) —— 开始数字
		 * @param	endNum:int (default = 10) —— 结束数字
		 * @return
		 */
		public static function generateRandomNumbersList(startNum:int=1, endNum:int=10):Array
		{
			var source:Array=[];
			var list:Array=[];

			for (var i:int=startNum, l:int=endNum + 1; i < l; i++)
			{
				source.push(i);
			}

			while (source.length > 0)
			{
				var index:int=Math.floor(Math.random() * source.length);
				list.push(source[index]);
				source.splice(index, 1);
			}

			return list;
		}

		/**移除值*/
		public static function removeValueFromArray(arr:Array, value:Object):void
		{
			var len:uint=arr.length;

			for (var i:Number=len; i > -1; i--)
			{
				if (arr[i] === value)
				{
					arr.splice(i, 1);
				}
			}
		}



		/**
		 *以数组方式删除元素
		 * @param arr
		 * @param values
		 */
		public static function removeValuesFromArray(arr:Array, values:Array):Array
		{
			var i:int, j:int;
			for (i=0; i < values.length; i++)
			{
				for (j=0; j < arr.length; j++)
				{
					if (arr[j] == values[i])
					{
						arr.splice(j, 1);
						break;
					}
				}
			}
			return arr;
		}

		/**
		 *  数值是否相同
		 * */
		public static function arraysAreEqual(arr1:Array, arr2:Array):Boolean
		{
			if (arr1 == arr2)
			{
				return true;
			}
			if (arr1.length != arr2.length)
			{
				return false;
			}

			var len:Number=arr1.length;

			for (var i:Number=0; i < len; i++)
			{
				if (arr1[i] !== arr2[i])
				{
					return false;
				}
			}

			return true;
		}

		/**
		 * 去重
		 */
		public static function createUniqueCopy(a:Array):Array
		{
			var newArray:Array=new Array();

			var len:Number=a.length;
			var item:Object;

			for (var i:uint=0; i < len; ++i)
			{
				item=a[i];

				if (arrayContainsValue(newArray, item))
				{
					continue;
				}

				newArray.push(item);
			}

			return newArray;
		}

		/**
		 *	是否包含值
		 */
		public static function arrayContainsValue(arr:Array, value:Object):Boolean
		{
			return (arr.indexOf(value) != -1);
		}


		/**求数字数组的最大值*/
		public static function max(aArray:Array):Number
		{
			var aCopy:Array=aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMaximum:Number=Number(aCopy.pop());
			return nMaximum;
		}

		/**求数字数组的最小值*/
		public static function min(aArray:Array):Number
		{
			var aCopy:Array=aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMinimum:Number=Number(aCopy.shift());
			return nMinimum;
		}

		/**重置数组*/
		public static function reset(arr:Array):void
		{
			arr.length=0;
		}

		/**浅克隆数组
		 * List of 500000 elements.
			for() unoptimized: 118ms
			for() key-key optimized: 30ms
			while() key-key optimized: 30ms
			Bytearray copy: 176ms
			Array slice(): 19ms
			Array concat(): 8ms
	    * */
		public static function clone(arr:Array):Array
		{
			return arr.concat();
		}
		
		/**交换两个值
		 * 效率高于临时变量300%
		 * */
		public static function swapValue(a:*,b:*):void{
			a = a^b;
			b = a^b;
			a = a^b;
		}
		
		/**使数组乱序*/
		public static function randomArray(arr:Array):void{
			arr.sort(function(){return Math.random()>0.5?1:-1});
		}
	}
}
