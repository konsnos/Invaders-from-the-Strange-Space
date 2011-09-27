package worlds 
{
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import objects.enemies.Big;
	import objects.enemies.Bonus;
	import objects.enemies.Medium;
	import Playtomic.Log;
	import worlds.objs.BlackScreen;
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
		private var newObj:Menu_Obj;
		private var fade:BlackScreen;
		private var timeFromStart:Timer;
		
		// PLAYER
		private var player:Player;
		
		// ENEMIES
		private var timeElapsed:Number;
		private var enemiesMoveTime:Number;
		private var changeLine:Boolean;
		private var bonusMaxFrequency:uint;
		private var timeBonusWillAppear:Number;
		
		private var aliens_e:Array;
		private var smalls_e:Array;
		private var mediums_e:Array;
		private var bigs_e:Array;
		private var entitiesToRemove:Array;
		
		private var bullets_s:Array;
		private var bullets_m:Array;
		private var bullets_b:Array;
		
		// TEMPORARY VARS
		private var i:Number, j:Number;
		private var alien_e:Alien;
		private var enemyShooting:uint;
		
		// Gets-Sets
		public function get stageG():uint 
		{
			return stage;
		}
		
		public function Level(selectedlevel:uint) 
		{
			timeElapsed = 0;
			changeLine = false;
			
			getEnemies();
			entitiesToRemove = new Array();
			
			Stats_Obj.levelS = selectedlevel;
			stage = selectedlevel - 1;
			
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
			
			loadLevel(GlobalVariables.MAP[stage]);
			enemiesMoveTime = 1;
			Alien.listUpdateS = true;
			Small.calculateMaxShots();
			Medium.calculateMaxShots();
			Big.calculateMaxShots();
			alien_e = null;
			enemyShooting = 0;
			
			FP.randomizeSeed();
			
			fade = new BlackScreen();
			add(fade);
			fade.fadeIn(0.5);
			SoundSystem.resetVolume();
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PREPARING)
			{
				preparing();
			}
			
			if (GlobalVariables.gameState == GlobalVariables.LOST) // Player has lost
			{
				if (Input.pressed("enter"))
				{
					fade.fadeOut();
					FP.alarm(1, returnToMainMenu);
					GlobalVariables.gameState = GlobalVariables.CHANGING;
				}
			}
			
			if (GlobalVariables.gameState == GlobalVariables.PAUSE)
			{
				if (Input.pressed("pause"))
				{
					GlobalVariables.gameState = GlobalVariables.PLAYING;
					timeFromStart.start();
					getClass(Pause_Obj, entitiesToRemove);
					if (entitiesToRemove)
					{
						remove(entitiesToRemove.pop());
					}
					getClass(Pause_Obj, entitiesToRemove);
					Input.clear();
				}
				if (Input.pressed("back"))
				{
					fade.fadeOut();
					FP.alarm(1, returnToMainMenu);
				}
			}
			
			if (GlobalVariables.gameState == GlobalVariables.WIN && Input.pressed("enter")) // Player has won
			{
				fade.fadeOut();
				if (stageG +1 != 10)
				{
					FP.alarm(1, advanceToNextLevel);
				}else
				{
					FP.alarm(1, returnToMainMenu);
				}
				GlobalVariables.gameState = GlobalVariables.CHANGING;
			}
			
			if (GlobalVariables.gameState == GlobalVariables.PLAYING) // Player is playing
			{
				if (Input.pressed("pause"))
				{
					GlobalVariables.gameState = GlobalVariables.PAUSE;
					timeFromStart.stop();
					add(new Pause_Obj);
				}else
				{
					updateGameplay();
				}
			}
			
			super.update();
		}
		
		/*
		 * Fills the smalls_e, mediums_e, bigs_e and aliens_e arrays.
		 */
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
				timeFromStart.stop();
 				Log.LevelAverageMetric("Lost", stage + 1, timeFromStart.currentCount);
				newObj = new Lost_Obj;
				add(newObj);
			}
			
			if(Alien.list == 0 && GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				GlobalVariables.gameState = GlobalVariables.WIN; // WIN!!!
				timeFromStart.stop();
				Log.LevelAverageMetric("Won", stage + 1, timeFromStart.currentCount);
				newObj = new Win_Obj(stage)
				add(newObj);
			}
			
			updateEnemies();
		}
		
		/**
		 * Updates enemy logic.
		 */
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
			
			movement();
		}
		
		/**
		 * Moves the aliens vertical and horizontal.
		 */
		public function movement():void 
		{
			if (timeElapsed > enemiesMoveTime) // Movement
			{
				for (i = 0, alien_e = aliens_e[i] as Alien; i < aliens_e.length; i++, alien_e = aliens_e[i] as Alien)
				{
					alien_e.walkOn();
					
					if ((alien_e.right + alien_e.width > FP.width || alien_e.x < alien_e.width ) && (!changeLine))
					{
						changeLine = true;
					}
					
					if (alien_e.bottom > player.y) // Player has lost.
					{
						GlobalVariables.gameState = GlobalVariables.LOST;
						newObj = new Lost_Obj;
						add(newObj);
					}
				}
				
				timeElapsed -= enemiesMoveTime;
			}
			
			if (changeLine && timeElapsed > (enemiesMoveTime / 2))
			{
				for (j = 0, alien_e = aliens_e[j] as Alien; j < aliens_e.length; j++, alien_e = aliens_e[j] as Alien)
				{
					alien_e.reverseDirection();
					alien_e.ComeCloser();
				}
				changeLine = false
			}
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
			getType("Bullet_Enem_Small", bullets_s);
			getType("Bullet_Enem_Medium", bullets_m);
			getType("Bullet_Enem_Big", bullets_b);
		}
		
		/*
		 * Checks to see which enemy shoots
		 */
		public function calculateEnemiesShots():void
		{
			if (Small.timeElapsed > Small.shootInterval && bullets_s.length < Small.maxShotsG)
			{
				enemyShooting = Small.calculateWhichShoot();
				alien_e = smalls_e[enemyShooting];
				if (alien_e != null)
				{
					alien_e.Shoot();
				}
				Small.timeElapsed = 0;
			}
			
 			if (Medium.timeElapsed > Medium.shootInterval && bullets_m.length < Medium.maxShotsG)
			{
				enemyShooting = Medium.calculateWhichShoot();
				alien_e = mediums_e[enemyShooting];
				if (alien_e != null)
				{
					alien_e.Shoot();
				}
				Medium.timeElapsed = 0;
			}
			
			if (Big.timeElapsed > Big.shootInterval && bullets_b.length < Big.maxShotsG)
			{
				enemyShooting = Big.calculateWhichShoot();
				alien_e = bigs_e[enemyShooting];
				if (alien_e != null)
				{
					alien_e.Shoot();
				}
				Big.timeElapsed = 0;
			}
		}
		
		/*
		 * Sets the time of the bonus alien appearance
		 */
		public function estimateBonusAppearance():void
		{
			timeBonusWillAppear = FP.rand(bonusMaxFrequency);
			FP.alarm(timeBonusWillAppear, addBonusAlien);
		}
		
		/*
		 * Adds the Bonus Alien in the game.
		 */
		public function addBonusAlien():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				Bonus(FP.world.create(Bonus)).reset(0,0);
				estimateBonusAppearance();
			}
		}
		
		public function returnToMainMenu():void 
		{
			FP.world = new MainMenu;
		}
		
		public function advanceToNextLevel():void 
		{
			FP.world = new Level(stage + 2);
		}
		
		public function preparing():void 
		{
			timeElapsed += FP.elapsed;
			if (timeElapsed > 1)
			{
				GlobalVariables.gameState = GlobalVariables.PLAYING;
				timeFromStart = new Timer(1000, 0);
				timeFromStart.reset();
				timeFromStart.start();
				estimateBonusAppearance();
			}
		}
		
		public function loadLevel(map:Class):void 
		{
			var xml:XML = FP.getXML(map);
			var dataList:XMLList;
			
			bonusMaxFrequency = xml.@bonusfrequency;
			
			dataList = xml.startPlace.player;
			for each(var p:XML in dataList)
			{
				player = new Player(p.@x, p.@y);
				add(player);
			}
			
			dataList = xml.smalls.tile;
			for each(var s:XML in dataList)
			{
				Small(create(Small)).reset(s.@x, s.@y);
			}
			
			dataList = xml.mediums.tile;
			for each(var m:XML in dataList)
			{
				Medium(create(Medium)).reset(m.@x - 2, m.@y);
			}
			
			dataList = xml.bigs.tile;
			for each(var b:XML in dataList)
			{
				Big(create(Big)).reset(b.@x, b.@y);
			}
		}
		
		override public function end():void 
		{
			removeAll();
			super.end();
		}
	}

}