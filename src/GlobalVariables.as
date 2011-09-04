package 
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GlobalVariables 
	{
		[Embed(source='../assets/space01.png')] private static const IMG_BACKGROUND:Class;
		
		[Embed(source = '../assets/player.png')] public static const IMG_PLAYER:Class;
		
		[Embed(source = '../assets/small_enemy.png')] public static const IMG_ENEMY_S:Class;
		[Embed(source = '../assets/medium_enemy.png')] public static const IMG_ENEMY_M:Class;
		[Embed(source = '../assets/large_enemy.png')] public static const IMG_ENEMY_L:Class;
		[Embed(source = '../assets/bonus_enemy.png')] public static const IMG_ENEMY_B:Class;
		
		[Embed(source = '../assets/bullet.png')] public static const IMG_BULLET_PLAYER:Class;
		
		[Embed(source = '../assets/LiberationSans-Regular.ttf', embedAsCFF = "false", fontName = "FONT_STATS")] public static const FONT_STATS:Class;
		
		private static var score:Number; // Να βάλω get/set
		
		public static var backdrop1:Backdrop;
		public static var backdrop2:Backdrop;
		
		public static const PLAYING:Number = 1;
		public static const PAUSE:Number = 2;
		public static const WIN:Number = 3;
		public static const LOST:Number = 4;
		
		public function GlobalVariables()
		{
			
		}
		
		public static function RESETBACKDROPS():void
		{
			backdrop1 = new Backdrop(IMG_BACKGROUND);
			FP.randomizeSeed();
			backdrop1.scrollX =  FP.random * 0.4;
			backdrop1.scrollY = FP.random * 0.4;
			
			backdrop2 = new Backdrop(IMG_BACKGROUND);
			backdrop2.scrollX = backdrop1.scrollX + (FP.random * 0.23);
			backdrop2.scrollY = backdrop2.scrollY + (FP.random * 0.23);
		}
		
		public static function RESETSCORE():void 
		{
			score = 0;
		}
		
		public static function ADDSCORE(toadd:Number):void 
		{
			score += toadd;
		}
		
		public static function GETSCORE():Number 
		{
			return score;
		}
		
	}

}