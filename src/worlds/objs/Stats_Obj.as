package worlds.objs 
{
	import adobe.utils.ProductManager;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Stats_Obj extends Entity 
	{
		private static var title:Text;
		private static var score:uint;
		private static var level:uint;
		private static var updated:Boolean;
		
		// Gets-Sets
		public static function set scoreS(setValue:uint):void 
		{
			score += setValue;
			updated = true;
			title.text = new String("Level 1 Score: " + score + " Rank: Rookie");
		}
		public static function get scoreG():uint
		{
			return score;
		}
		public static function set levelS(setValue:uint):void 
		{
			level = setValue;
			updated = true;
		}
		
		public function Stats_Obj()
		{
			score = 0;
			
			title = new Text(String("Level " + level + " Score: " + score + " Rank: Rookie"));
			title.size = 16;
			title.y = 1;
			title.x = 10;
			title.color = 0xffff00; // Yellow
			title.font = 'FONT_STATS';
			
			updated = false;
			layer = 2;
			
			graphic = new Graphiclist(title);
		}
		
		override public function update():void 
		{
			if (updated)
			{
				title.text = new String("Level 1 Score: " + score + " Rank: Rookie");
			}
		}
		
		public static function resetScore():void 
		{
			score = 0;
		}
		
	}

}