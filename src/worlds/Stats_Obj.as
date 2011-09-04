package worlds 
{
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
		private static var score:Number;
		
		
		// Gets-Sets
		public static function set scoreS(setValue:Number):void 
		{
			score += setValue;
			title.text = new String("Score: " + score + " Rank: Rookie");
		}
		
		public function Stats_Obj() 
		{
			score = 0;
			
			title = new Text(String("Score: " + score + " Rank: Rookie"));
			title.size = 16;
			title.y = 1;
			trace(title.height);
			title.x = 10;
			title.color = 0xffff00; // Yellow
			title.font = 'FONT_STATS';
			
			layer = 2;
			
			graphic = new Graphiclist(title);
		}
		
		public static function resetScore():void 
		{
			
		}
		
		override public function update():void 
		{ 
			
		}
		
	}

}