package 
{
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import Playtomic.Log;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GlobalVariables 
	{
		/****************** IMAGES ******************/
		//[Embed(source = '../assets/images/player.png')] public static const IMG_PLAYER:Class;
		[Embed(source = "../assets/images/playerShip_64x64.gif")] public static const IMG_PLAYER:Class;
		[Embed(source = "../assets/images/enemySmall_32x32.png")] public static const IMG_ENEMY_S:Class;
		[Embed(source="../assets/images/enemyMedium_32x32.png")] public static const IMG_ENEMY_M:Class;
		[Embed(source = "../assets/images/enemyBig_32x32.gif")] public static const IMG_ENEMY_L:Class;
		[Embed(source="../assets/images/enemyBonus_32x32.png")] public static const IMG_ENEMY_B:Class;
		[Embed(source="../assets/images/bullets.png")] public static const IMG_BULLET:Class;
		//[Embed(source = '../assets/images/bullet.png')] public static const IMG_BULLET:Class;
		//[Embed(source="../assets/images/bullet_P.png")] public static const IMG_BULLET_PLAYER:Class;
		public static const IMG_PARTICLE:BitmapData = new BitmapData(2, 2, false);
		public static const IMG_HEALTHRECT:BitmapData = new BitmapData(5, 12, false, 0xb22222); // Dark red
		public static const IMG_HEALTHFILL:BitmapData = new BitmapData(3, 10, false, 0xadff2f); // Green
		
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
		[Embed(source="../assets/fonts/Coalition_v2.ttf", embedAsCFF = "false", fontName = "FONT_TITLE")] public static const FONT_TITLE:Class;
		[Embed(source="../assets/fonts/ethnocentric rg.ttf", embedAsCFF = "false", fontName = "FONT_CHOICE")] public static const FONT_CHOICE:Class;
		
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
		
		/****************** GAME VARS ******************/
		public static var USERNAME:String;
		public static var gameState:Number;
		public static const PLAYING:uint = 1;
		public static const PAUSE:uint = 2;
		public static const WIN:uint = 3;
		public static const LOST:uint = 4;
		public static const PREPARING:uint = 5;
		public static const WONGAME:uint = 6;
		public static const CHANGING:uint = 7; // Just to change the state and not repeat the previous.
		public static var MAP:Array;
		public static var EXPLOSION:Array;
		public static var SCORE:Array;
		public static var GLSCORE:Array;
		public static var GAMESCORE:uint;
		public static var BRUTALSCORE:uint;
		public static var BRUTALHIGHSCORE:uint;
		public static var MOUSE:Boolean;
		
		public function GlobalVariables()
		{
			
		}
		
		public static function RESETSCORE():void 
		{
			GAMESCORE = 0;
		}
		
		public static function CALCULATESCORE():void 
		{
			RESETSCORE();
			for (var i:uint = 0; i < SCORE.length; i++)
			{
				GAMESCORE += SCORE[i];
			}
		}
		
		public static function GETSCORE(stage:uint ):Number 
		{
			return MAP[stage];
		}
		
		/**
		 * Enables/disables the mouse cursor.
		 */
		public static function REVERSEMOUSE():void 
		{
			if (MOUSE)
			{
				MOUSE = false;
			}else 
			{
				MOUSE = true;
			}
		}
		
		public static function FILLMAPARRAY():void 
		{
			MAP = new Array(MAP01, MAP02, MAP03, MAP04, MAP05, MAP06, MAP07, MAP08, MAP09, MAP10);
			SCORE = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			GLSCORE = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		}
		
		public static function FILLEXPLOSIONARRAY():void
		{
			EXPLOSION = new Array(EXPLOSION01, EXPLOSION02);
		}
		
	}

}