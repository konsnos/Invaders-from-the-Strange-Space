package worlds.objs 
{
	import adobe.utils.ProductManager;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import objects.player.Player;
	
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Stats_Obj extends Entity 
	{
		private static var stats:Text;
		private static var playerlife:Text;
		private static var score:uint;
		private static var level:uint;
		
		// Gets-Sets
		public static function set scoreS(setValue:uint):void 
		{
			score += setValue;
			stats.text = new String("Level " + level + " - Score: " + score + " - Previous score: " + GlobalVariables.SCORE[level - 1]);
		}
		public static function get scoreG():uint
		{
			return score;
		}
		public static function set levelS(setValue:uint):void 
		{
			level = setValue;
		}
		
		public function Stats_Obj()
		{
			score = 0;
			
			stats = new Text(String("Level " + level + " - Score: " + score + " - Previous score: " + GlobalVariables.SCORE[level - 1]));
			stats.size = 16;
			stats.y = 1;
			stats.x = 10;
			stats.color = 0xffdead; // blue
			stats.font = 'FONT_STATS';
			
			playerlife = new Text(String("Life: " + Player.getlife() + "/3" + "- Rank: Rookie"));
			playerlife.size = 16;
			playerlife.y = FP.height - 20;
			playerlife.x = 5;
			playerlife.color = 0x3cb371; // green
			playerlife.font = 'FONT_STATS';
			
			layer = 2;
			
			graphic = new Graphiclist(stats, playerlife);
		}
		
		public static function resetScore():void 
		{
			score = 0;
		}
		
		/**
		 * Updates the score and player life texts.
		 */
		public static function updateStats():void 
		{
			stats.text = new String("Level " + level + "- Score: " + score + " - Previous score: " + GlobalVariables.SCORE[level - 1]);
			playerlife.text = new String("Life: " + Player.getlife() + "/3" + " - Rank: Rookie")
		}
		
	}

}