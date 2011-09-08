package worlds 
{
	import flash.display.BitmapData;
	import flash.sampler.NewObjectSample;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.objs.Starfield;
	
	import objects.Actor;
	import objects.enemies.Alien;
	import objects.enemies.Small;
	import objects.player.Player;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.bullets.BulletPlayer;
	import worlds.objs.WeaponsFree_Obj;
	import worlds.objs.Menu_Obj;
	import worlds.objs.Lost_Obj;
	import worlds.objs.Pause_Obj;
	import worlds.objs.Stats_Obj;
	import worlds.objs.Win_Obj;
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
		
		// create the starfield
		private var field:Starfield = new Starfield();
		
		// GAME
		private var pause:Boolean;
		private var wasPaused:Boolean;
		private var obj:Menu_Obj;
		[Embed(source = '../../assets/levels/level01.oel', mimeType = 'application/octet-stream')]private const MAP:Class;
		
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
		
		private var smalls_e:Array;
		private var entitiesToRemove:Array;
		
		// TEMPORARY VARS
		private var i:Number;
		private var small_e:Small;
		private var smallShooting:uint;
		
		public function Level() 
		{
			timeElapsed = 0;
			changeLine = false;
			
			smalls_e = new Array();
			entitiesToRemove = new Array();
			
			GlobalVariables.gameState = GlobalVariables.PREPARING;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// RESET EVERYTHING
			pause = false;
			wasPaused = false;
			
			resetAllLists();
			
			//addGraphic(background1, 1);
			//addGraphic(background2, 0);
			addGraphic(field);
			add(new Stats_Obj);
			obj = new WeaponsFree_Obj;
			add(obj);
			
			loadLevel(MAP);
			enemiesMoveTime = 1;
			Small.listUpdateS = true;
			Small.calculateMaxShots();
			small_e = null;
			smallShooting = 0;
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PREPARING)
			{
				preparing();
			}
			
			if (GlobalVariables.gameState == GlobalVariables.LOST)
			{
				if (Input.pressed("enter"))
				{
					returnToMainMenu(); // Break
				}
			}
			
			if (Input.pressed("pause"))
			{
				if (GlobalVariables.gameState == GlobalVariables.PAUSE)
				{
					GlobalVariables.gameState = GlobalVariables.PLAYING;
					getClass(Pause_Obj, entitiesToRemove);
					if (entitiesToRemove)
					{
						remove(entitiesToRemove.pop());
					}
					getClass(Pause_Obj, entitiesToRemove);
				}
				else
				{
					GlobalVariables.gameState = GlobalVariables.PAUSE;
					add(new Pause_Obj);
				}
			}
			
			if (GlobalVariables.gameState == GlobalVariables.WIN && Input.pressed("enter"))
			{
				returnToMainMenu();
			}
			
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				updateGameplay();
			}
			
			super.update();
		}
		
		public function getEnemies():void 
		{
			smalls_e = new Array();
			getType("Small", smalls_e);
		}
		
		private function updateGameplay():void 
		{
			timeElapsed += FP.elapsed;
			
			if (player.hpG <= 0)
			{
				GlobalVariables.gameState = GlobalVariables.LOST;
				add(new Lost_Obj);
			}
			
			if(Alien.list == 0 && GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				GlobalVariables.gameState = GlobalVariables.WIN; // WIN!!!
				add(new Win_Obj);
			}
			
			updateEnemies();
		}
		
		private function updateEnemies():void 
		{
			Small.timeElapsed += FP.elapsed;
			
			if (Small.listUpdateG)
			{
				getEnemies();
				Small.listUpdateS = false;
			}
			
			if (Small.timeElapsed > Small.shootInterval && BulletEnemy.list < Small.maxShotsG)
			{
				smallShooting = Small.calculateWhichShoot();
				small_e = smalls_e[smallShooting];
				small_e.Shoot();
				Small.timeElapsed = 0;
			}
			
			if (timeElapsed > enemiesMoveTime)
			{
				for (i = 0, small_e = smalls_e[i] as Small; i < smalls_e.length; i++, small_e = smalls_e[i] as Small)
				{
					small_e.walkOn();
					
					if ((small_e.x + small_e.width * 2 > FP.width || small_e.x < small_e.width ) && (!changeLine))
					{
						changeLine = true;
					}
					
					if (small_e.bottom > player.y)
					{
						GlobalVariables.gameState = GlobalVariables.LOST;
						returnToMainMenu();
					}
				}
				
				if (changeLine)
				{
					Small.reverseDirection();
					for (i = 0, small_e = smalls_e[i] as Small; i < smalls_e.length; i++, small_e = smalls_e[i] as Small)
					{
						small_e.ComeCloser();
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
			Small.resetList();
		}
		
		public function preparing():void 
		{
			timeElapsed += FP.elapsed;
			if (timeElapsed > 1)
			{
				GlobalVariables.gameState = GlobalVariables.PLAYING;
			}
		}
		
		public function loadLevel(map:Class):void 
		{
			var xml:XML = FP.getXML(map);
			var dataList:XMLList;
			dataList = xml.startPlace.player;
			for each(var p:XML in dataList)
			{
				player = new Player(p.@x, p.@y);
				add(player);
			}
			
			dataList = xml.enemies.tile;
			for each(var l:XML in dataList)
			{
				add(new Small(l.@x, l.@y));
			}
		}
	}

}