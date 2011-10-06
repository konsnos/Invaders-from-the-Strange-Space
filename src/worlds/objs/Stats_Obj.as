package worlds.objs 
{
	import adobe.utils.ProductManager;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import objects.bullets.BulletPlayer;
	import objects.player.Player;
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	
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
		private static var acc:uint;
		private static var life:uint;
		private static var finalScore:uint;
		private static var level:uint;
		private static var brutal:Boolean;
		private static var hparray:Array;
		private static var graphiclist:Graphiclist;
		
		// Gets-Sets
		public static function set scoreS(setValue:uint):void 
		{
			score += setValue;
 			updateStatsText();
		}
		public static function get scoreG():uint
		{
			return score;
		}
		public static function get accG():uint 
		{
			return acc;
		}
		public static function get lifeG():uint 
		{
			return life;
		}
		public static function get finalScoreG():uint 
		{
			return finalScore;
		}
		public static function set levelS(setValue:uint):void 
		{
			level = setValue;
		}
		public static function set difS(setValue:Boolean):void 
		{
			brutal = setValue;
		}
		
		public function Stats_Obj()
		{
			score = 0;
			updateStatsText();
			showStats();
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
			updateStatsText();
			
			updatePlayerLife();
		}
		
		public static function updateStatsText():void 
		{
			if (stats != null)
			{
				calculateBonusScores();
				if (!brutal)
				{
					stats.text = new String("Level " + level + " - Score: " + finalScore + " - Previous score: " + GlobalVariables.SCORE[level - 1]);
				}else
				{
					stats.text = new String("Level " + level + " - Score: " + (GlobalVariables.BRUTALSCORE + finalScore) + " - High score: " + GlobalVariables.BRUTALHIGHSCORE);
				}
			}
		}
		
		public static function calculateBonusScores():void 
		{
			acc = uint(score * BulletPlayer.findAcc());
			life = uint(Player.getlife() * (level * 8));
			finalScore = score + acc + life;
		}
		
		private static function updatePlayerLife():void 
		{
			switch (Player.getlife()) 
			{
				case 2:
					Image(hparray[2][1]).visible = false;
					break;
				case 1:
					Image(hparray[2][1]).visible = false;
					Image(hparray[1][1]).visible = false;
					break;
				case 0:
					Image(hparray[2][1]).visible = false;
					Image(hparray[1][1]).visible = false;
					Image(hparray[0][1]).visible = false;
					break;
				default:
					break;
			}
		}
		
		public static function updateAcc():void 
		{
			playerlife.text = String("Life:       - Accuracy: " + uint(BulletPlayer.findAcc()*100) + "%");
		}
		
		private function showStats():void 
		{
			if (!brutal)
			{
				stats = new Text(String("Level " + level + " - Score: " + finalScore + " - Previous score: " + GlobalVariables.SCORE[level - 1]));
			}else
			{
				stats = new Text(String("Level " + level + " - Score: " + (GlobalVariables.BRUTALSCORE + finalScore) + " - High score: " + GlobalVariables.BRUTALHIGHSCORE));
			}
			stats.size = 16;
			stats.align = "right";
			stats.y = FP.height - 20;
			stats.x = FP.width - stats.textWidth;
			stats.width = stats.textWidth;
			stats.color = 0xffdead; // blue
			stats.font = 'FONT_STATS';
			
			graphiclist = new Graphiclist(stats);
			
			playerlife = new Text(String("Life:       - Accuracy: - %"));
			playerlife.size = 16;
			playerlife.y = FP.height - 20;
			playerlife.x = 2;
			playerlife.color = 0x3cb371; // green
			playerlife.font = 'FONT_STATS';
			graphiclist.add(playerlife);
			
			hparray = new Array([new Image(GlobalVariables.IMG_HEALTHRECT), new Image(GlobalVariables.IMG_HEALTHFILL)],
			[new Image(GlobalVariables.IMG_HEALTHRECT), new Image(GlobalVariables.IMG_HEALTHFILL)],
			[new Image(GlobalVariables.IMG_HEALTHRECT), new Image(GlobalVariables.IMG_HEALTHFILL)]);
			for (var i:uint = 0; i < 3; i++)
			{
				for (var j:uint = 0; j < 2; j++)
				{
					if (j % 2 == 1)
					{
						Image(hparray[i][j]).x = 41 + i * 8;
						Image(hparray[i][j]).y = FP.height - 14;
					}else
					{
						Image(hparray[i][j]).x = 40 + i * 8;
						Image(hparray[i][j]).y = FP.height - 15;
					}
					graphiclist.add(hparray[i][j]);
				}
			}
			layer = 2;
			
			graphic = graphiclist;
		}
		
	}

}