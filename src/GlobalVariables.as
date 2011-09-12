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
		[Embed(source = '../assets/images/player.png')] public static const IMG_PLAYER:Class;
		[Embed(source = '../assets/images/small_enemy.png')] public static const IMG_ENEMY_S:Class;
		[Embed(source = '../assets/images/medium_enemy.png')] public static const IMG_ENEMY_M:Class;
		[Embed(source = '../assets/images/big_enemy.png')] public static const IMG_ENEMY_L:Class;
		[Embed(source = '../assets/images/bonus_enemy.png')] public static const IMG_ENEMY_B:Class;
		[Embed(source = '../assets/images/bullet.png')] public static const IMG_BULLET_PLAYER:Class;
		public static const IMG_BULLET_REDRECT:Image = new Image(new BitmapData(2, 10, false, 0xee0000));
		
		/****************** SOUNDS ******************/
		// MUSIC
		[Embed(source = '../assets/sounds/music/36223__genghis-attenborough__lone-sleeper.mp3')] public static const MSC01:Class;
		// EFFECTS
		[Embed(source = '../assets/sounds/effects/explosion01.mp3')] public static const EXPLOSION01:Class;
		[Embed(source='../assets/sounds/effects/explosion02.mp3')] public static const EXPLOSION02:Class;
		[Embed(source = '../assets/sounds/effects/explosionP.mp3')] public static const EXPLOSIONP:Class;
		[Embed(source = '../assets/sounds/effects/explosionPm.mp3')] public static const EXPLOSIONPM:Class;
		[Embed(source='../assets/sounds/effects/shoot.mp3')] public static const SHOOT:Class;
		
		/****************** FONTS ******************/
		[Embed(source = '../assets/fonts/LiberationSans-Regular.ttf', embedAsCFF = "false", fontName = "FONT_STATS")] public static const FONT_STATS:Class;
		
		/****************** LEVELS ******************/
		[Embed(source = '../assets/levels/level01.oel', mimeType = 'application/octet-stream')]private static const MAP01:Class;
		[Embed(source = '../assets/levels/level02.oel', mimeType = 'application/octet-stream')]private static const MAP02:Class;
		[Embed(source = '../assets/levels/level03.oel', mimeType = 'application/octet-stream')]private static const MAP03:Class;
		[Embed(source = '../assets/levels/level04.oel', mimeType = 'application/octet-stream')]private static const MAP04:Class;
		[Embed(source = '../assets/levels/level05.oel', mimeType = 'application/octet-stream')]private static const MAP05:Class;
		[Embed(source = '../assets/levels/level06.oel', mimeType = 'application/octet-stream')]private static const MAP06:Class;
		[Embed(source = '../assets/levels/level07.oel', mimeType = 'application/octet-stream')]private static const MAP07:Class;
		[Embed(source = '../assets/levels/level08.oel', mimeType = 'application/octet-stream')]private static const MAP08:Class;
		[Embed(source = '../assets/levels/level09.oel', mimeType = 'application/octet-stream')]private static const MAP09:Class;
		[Embed(source = '../assets/levels/level10.oel', mimeType = 'application/octet-stream')]private static const MAP10:Class;
		
		private static var score:Number; // Να βάλω get/set
		
		public static var gameState:Number;
		public static const PLAYING:uint = 1;
		public static const PAUSE:uint = 2;
		public static const WIN:uint = 3;
		public static const LOST:uint = 4;
		public static const PREPARING:uint = 5;
		public static var MAP:Array;
		public static var EXPLOSION:Array;
		
		public function GlobalVariables()
		{
			
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
		
		public static function FILLMAPARRAY():void 
		{
			MAP = new Array(MAP01, MAP02, MAP03, MAP04, MAP05, MAP06, MAP07, MAP08, MAP09, MAP10);
		}
		
		public static function FILLEXPLOSIONARRAY():void
		{
			EXPLOSION = new Array(EXPLOSION01, EXPLOSION02);
		}
		
	}

}