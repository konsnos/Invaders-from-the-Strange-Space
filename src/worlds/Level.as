package worlds 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.World;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import objects.Actor;
	import objects.enemies.Alien;
	import objects.enemies.Little;
	import objects.player.Player;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.bullets.BulletPlayer;
	import worlds.objs.WeaponsFree_Obj;
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Level extends World 
	{
		// BACKGROUND
		private var background1:Graphic;
		private var background2:Graphic;
		
		// BACKGROUND MOVEMENT
		private var layer1Y:Number;
		private var layer1X:Number;
		private var layer2Y:Number;
		private var layer2X:Number;
		
		// GAME
		private static var gameState:Number;
		private var pause:Boolean;
		private var wasPaused:Boolean;
		private var obj:Menu_Obj;
		
		// PLAYER
		private var player:Player;
		
		// ENEMIES
		private var rows:Number;
		private var rowsSpace:Number;
		private var columns:Number;
		private var columnsSpace:Number;
		private var timeElapsed:Number;
		private var enemiesMoveTime:Number;
		private var changeLine:Boolean;
		
		private var littles_e:Array;
		private var entitiesToRemove:Array;
		
		// TEMPORARY VARS
		private var i:Number;
		private var little_e:Little;
		private var littleShooting:uint;
		
		// Gets-Sets
		public static function set gameStateS(setValue:Number):void
		{
			gameState = setValue;
		}
		public static function get gameStateG():Number 
		{
			return gameState;
		}
		
		public function Level() 
		{
			layer1Y = 1.2;
			layer2Y = 2.5;
			GlobalVariables.RESETBACKDROPS();
			background1 = GlobalVariables.backdrop1;
			background2 = GlobalVariables.backdrop2;
			
			timeElapsed = 0;
			changeLine = false;
			
			littles_e = new Array();
			entitiesToRemove = new Array();
			
			gameState = GlobalVariables.PREPARING;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// RESET EVERYTHING
			pause = false;
			wasPaused = false;
			
			resetAllLists();
			
			addGraphic(background1, 1);
			addGraphic(background2, 0);
			add(new Stats_Obj);
			obj = new WeaponsFree_Obj;
			add(obj);
			
			background1.y = 245;
			background1.x = 345;
			background2.y = 376;
			background2.x = 123;
			
			player = new Player(FP.halfWidth, FP.height / 10 * 8);
			add(player);
			
			columns = 8;
			rows = 5;
			
			columnsSpace = (FP.width / columns) - 20;
			rowsSpace = FP.height / (rows + 6);
			
			for (var r:int = 1; r <= rows; r++)
			{
				for (var c:int = 1; c <= columns; c++)
				{
					add(new Little(c * columnsSpace, r * rowsSpace));
				}
			}
			
			enemiesMoveTime = 1;
			Little.listUpdateS = true;
			Little.calculateMaxShots();
			little_e = null;
			littleShooting = 0;
		}
		
		override public function update():void 
		{
			if (gameState == GlobalVariables.PREPARING)
			{
				preparing();
			}
			
			if (gameState == GlobalVariables.LOST)
			{
				if (Input.pressed("shoot"))
				{
					returnToMainMenu(); // Break
				}
			}
			
			if (Input.pressed("pause"))
			{
				if (gameState == GlobalVariables.PAUSE)
				{
					gameState = GlobalVariables.PLAYING;
					getClass(Pause_Obj, entitiesToRemove);
					if (entitiesToRemove)
					{
						remove(entitiesToRemove.pop());
					}
					getClass(Pause_Obj, entitiesToRemove);
				}
				else
				{
					gameState = GlobalVariables.PAUSE;
					add(new Pause_Obj);
				}
			}
			
			if (gameState == GlobalVariables.WIN && Input.pressed("shoot"))
			{
				returnToMainMenu();
			}
			
			if (gameState == GlobalVariables.PLAYING)
			{
				updateGameplay();
			}
			
			background1.y += layer1Y;
			background2.y += layer2Y;
			super.update();
		}
		
		public function getEnemies():void 
		{
			littles_e = new Array();
			getType("little", littles_e);
		}
		
		private function updateGameplay():void 
		{
			timeElapsed += FP.elapsed;
			
			if (player.hpG <= 0)
			{
				gameStateS = GlobalVariables.LOST;
				add(new Lost_Obj);
			}
			
			if(Alien.list == 0 && gameState == GlobalVariables.PLAYING)
			{
				gameState = GlobalVariables.WIN; // WIN!!!
				add(new Win_Obj);
			}
			
			updateEnemies();
		}
		
		private function updateEnemies():void 
		{
			Little.timeElapsed += FP.elapsed;
			
			if (Little.listUpdateG)
			{
				getEnemies();
				Little.listUpdateS = false;
			}
			
			if (Little.timeElapsed > Little.shootInterval && BulletEnemy.list < Little.maxShotsG)
			{
				littleShooting = Little.calculateWhichShoot();
				little_e = littles_e[littleShooting];
				little_e.Shoot();
				Little.timeElapsed = 0;
			}
			
			if (timeElapsed > enemiesMoveTime)
			{
				for (i = 0, little_e = littles_e[i] as Little; i < littles_e.length; i++, little_e = littles_e[i] as Little)
				{
					little_e.walkOn();
					
					if ((little_e.x + little_e.width * 2 > FP.width || little_e.x < little_e.width ) && (!changeLine))
					{
						changeLine = true;
					}
					
					if (little_e.bottom > player.y)
					{
						gameState = GlobalVariables.LOST;
						returnToMainMenu();
					}
				}
				
				if (changeLine)
				{
					Little.reverseDirection();
					
					for (i = 0, little_e = littles_e[i] as Little; i < littles_e.length; i++, little_e = littles_e[i] as Little)
					{
						little_e.ComeCloser();
					}
					changeLine = false;
				}
				
				timeElapsed -= enemiesMoveTime;
			}
		}
		
		public function returnToMainMenu():void 
		{
			FP.world.removeAll();
			FP.world = new MainMenu;
		}
		
		public function resetAllLists():void 
		{
			Actor.resetList();
			Bullet.resetList();
			BulletEnemy.resetList();
			BulletPlayer.resetList();
			Alien.resetList();
			Little.resetList();
		}
		
		public function preparing():void 
		{
			timeElapsed += FP.elapsed;
			if (timeElapsed > 1)
			{
				gameState = GlobalVariables.PLAYING;
			}
		}
	}

}