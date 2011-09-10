package worlds 
{
	import flash.display.BitmapData;
	import flash.display.ShaderParameter;
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
	import objects.enemies.Big;
	import objects.enemies.Medium;
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
		// create the starfield
		private var field:Starfield = new Starfield();
		
		// GAME
		private var pause:Boolean;
		private var wasPaused:Boolean;
		private var obj:Menu_Obj;
		private var stage:uint;
		private var maps:Array;
		/****************** LEVELS ******************/
		[Embed(source='../../assets/levels/level01.oel', mimeType='application/octet-stream')]public static const MAP:Class;
		
		// PLAYER
		private var player:Player;
		
		// ENEMIES
		private var timeElapsed:Number;
		private var enemiesMoveTime:Number;
		private var changeLine:Boolean;
		
		private var aliens_e:Array;
		private var smalls_e:Array;
		private var mediums_e:Array;
		private var bigs_e:Array;
		private var entitiesToRemove:Array;
		
		private var bullets_s:Array;
		private var bullets_m:Array;
		private var bullets_b:Array;
		
		// TEMPORARY VARS
		private var i:Number;
		private var alien_e:Alien;
		private var enemyShooting:uint;
		
		public function Level(selectedlevel:uint) 
		{
			timeElapsed = 0;
			changeLine = false;
			
			getEnemies();
			entitiesToRemove = new Array();
			
			stage = selectedlevel; // Να χρησιμοποιηθεί για την επιλογή levels
			
			GlobalVariables.gameState = GlobalVariables.PREPARING;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// RESET EVERYTHING
			pause = false;
			wasPaused = false;
			
			resetAllLists();
			resetAllBullets();
			
			addGraphic(field);
			add(new Stats_Obj);
			obj = new WeaponsFree_Obj;
			add(obj);
			
			loadLevel(MAP);
			enemiesMoveTime = 1;
			Alien.listUpdateS = true;
			Small.calculateMaxShots();
			Medium.calculateMaxShots();
			Big.calculateMaxShots();
			alien_e = null;
			enemyShooting = 0;
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
			mediums_e = new Array();
			bigs_e = new Array();
			getType("Small", smalls_e);
			getType("Medium", mediums_e);
			getType("Big", bigs_e);
			
			aliens_e = new Array();
			aliens_e = smalls_e.concat(mediums_e, bigs_e);
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
			Medium.timeElapsed += FP.elapsed;
			Big.timeElapsed += FP.elapsed;
			
			if (Alien.listUpdateG)
			{
				getEnemies();
				Alien.listUpdateS = false;
			}
			
			resetAllBullets();
			calculateEnemiesShots();
			
			// Movement
			if (timeElapsed > enemiesMoveTime)
			{
				for (i = 0, alien_e = aliens_e[i] as Alien; i < aliens_e.length; i++, alien_e = aliens_e[i] as Alien)
				{
					alien_e.walkOn();
					
					if ((alien_e.x + alien_e.width * 2 > FP.width || alien_e.x < alien_e.width ) && (!changeLine))
					{
						changeLine = true;
					}
					
					if (alien_e.bottom > player.y)
					{
						GlobalVariables.gameState = GlobalVariables.LOST;
						add(new Lost_Obj);
					}
				}
				
				if (changeLine)
				{
					for (i = 0, alien_e = aliens_e[i] as Alien; i < aliens_e.length; i++, alien_e = aliens_e[i] as Alien)
					{
						alien_e.reverseDirection();
						alien_e.ComeCloser();
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
			Medium.resetList();
			Big.resetList();
		}
		
		public function resetAllBullets():void
		{
			bullets_s = new Array();
			bullets_m = new Array();
			bullets_b = new Array();
		}
		
		public function calculateEnemiesShots():void 
		{
			getType("Bullet_Enem_Small", bullets_s);
			if (Small.timeElapsed > Small.shootInterval && bullets_s.length < Small.maxShotsG)
			{
				enemyShooting = Small.calculateWhichShoot();
				alien_e = smalls_e[enemyShooting];
				alien_e.Shoot();
				Small.timeElapsed = 0;
			}
			
			getType("Bullet_Enem_Medium", bullets_m);
 			if (Medium.timeElapsed > Medium.shootInterval && bullets_m.length < Medium.maxShotsG)
			{
				enemyShooting = Medium.calculateWhichShoot();
				alien_e = mediums_e[enemyShooting];
				alien_e.Shoot();
				Medium.timeElapsed = 0;
			}
			
			getType("Bullet_Enem_Big", bullets_b);
			if (Big.timeElapsed > Big.shootInterval && bullets_b.length < Big.maxShotsG)
			{
				enemyShooting = Big.calculateWhichShoot();
				alien_e = bigs_e[enemyShooting];
				alien_e.Shoot();
				Big.timeElapsed = 0;
			}
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
			
			dataList = xml.smalls.tile;
			for each(var s:XML in dataList)
			{
				add(new Small(s.@x, s.@y));
			}
			
			dataList = xml.mediums.tile;
			for each(var m:XML in dataList)
			{
				add(new Medium(m.@x, m.@y));
			}
			
			dataList = xml.bigs.tile;
			for each(var b:XML in dataList)
			{
				add(new Big(b.@x, b.@y));
			}
		}
	}

}