package 
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GlobalVariables 
	{
		/****************** IMAGES ******************/
		[Embed(source='../assets/images/space01.png')] private static const IMG_BACKGROUND:Class;
		
		[Embed(source = '../assets/images/player.png')] public static const IMG_PLAYER:Class;
		[Embed(source = '../assets/images/small_enemy.png')] public static const IMG_ENEMY_S:Class;
		[Embed(source = '../assets/images/medium_enemy.png')] public static const IMG_ENEMY_M:Class;
		[Embed(source = '../assets/images/big_enemy.png')] public static const IMG_ENEMY_L:Class;
		[Embed(source = '../assets/images/bonus_enemy.png')] public static const IMG_ENEMY_B:Class;
		[Embed(source = '../assets/images/bullet.png')] public static const IMG_BULLET_PLAYER:Class;
		public static const IMG_BULLET_REDRECT:Image = new Image(new BitmapData(2, 10, false, 0xee0000));
		
		/****************** SOUNDS ******************/
		[Embed(source = '../assets/sounds/effects/explosion01.mp3')] public static const EXPLOSION:Class;
		[Embed(source = '../assets/sounds/effects/explosionP.mp3')] public static const EXPLOSIONP:Class;
		[Embed(source = '../assets/sounds/effects/explosionPm.mp3')] public static const EXPLOSIONPM:Class;
		[Embed(source='../assets/sounds/effects/shoot.mp3')] public static const SHOOT:Class;
		
		/****************** FONTS ******************/
		[Embed(source = '../assets/fonts/LiberationSans-Regular.ttf', embedAsCFF = "false", fontName = "FONT_STATS")] public static const FONT_STATS:Class;
		
		private static var score:Number; // Να βάλω get/set
		
		public static var backdrop1:Backdrop;
		public static var backdrop2:Backdrop;
		
		public static const PLAYING:uint = 1;
		public static const PAUSE:uint = 2;
		public static const WIN:uint = 3;
		public static const LOST:uint = 4;
		public static const PREPARING:uint = 5;
		
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