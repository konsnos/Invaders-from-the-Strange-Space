package worlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	import enemies.Little;
	import player.Player;
	import objects.bullets.Bullet;
	import objects.GlobalVariables;
	
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
		private var score:Number;
		private var gameState:Number;
		private var pause:Boolean;
		private var wasPaused:Boolean;
		
		// PLAYER
		private var playerY:Number;
		
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
		
		public function Level() 
		{
			layer1Y = 1.2;
			layer2Y = 2.5;
			GlobalVariables.RESETBACKDROPS();
			background1 = GlobalVariables.backdrop1;
			background2 = GlobalVariables.backdrop2;
			
			timeElapsed = 0;
			changeLine = false;
			
			gameState = GlobalVariables.PLAYING;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			score = 0;
			pause = false;
			wasPaused = false;
			
			addGraphic(background1);
			addGraphic(background2);
			
			background1.y = 245;
			background1.x = 345;
			background2.y = 376;
			background2.x = 123;
			
			playerY = FP.height / 10 * 8;
			add(new Player(FP.width / 2, playerY));
			
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
			
			littles_e = new Array();
			entitiesToRemove = new Array();
			little_e = null;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed("pause"))
			{
				if (pause)
				{
					pause = false;
					getClass(Pause_Obj, entitiesToRemove);
					if (entitiesToRemove)
					{
						remove(entitiesToRemove.pop())
					}
					getClass(Pause_Obj, entitiesToRemove);
				}
				else
				{
					pause = true;
					add(new Pause_Obj);
				}
			}
			if (!pause)
			{
				updateGameplay();
			}
		}
		
		public function getEnemies():void 
		{
			littles_e = new Array();
			getType("little", littles_e);
		}
		
		private function updateGameplay():void 
		{
			timeElapsed += FP.elapsed;
			
			if (littles_e.length == 0)
			{
				getEnemies();
				if (littles_e.length == 0)
				{
					gameState = GlobalVariables.WIN; // WIN!!!
					trace("Won");
					returnToMainMenu();
				}
			}
			
			background1.y += layer1Y;
			background2.y += layer2Y;
			
			updateEnemies();
		}
		
		private function updateEnemies():void 
		{
			if (timeElapsed > enemiesMoveTime)
			{
				for (i = 0, little_e = littles_e[i] as Little; i < littles_e.length; i++, little_e = littles_e[i] as Little)
				{
					if (i == 0)
					{
						if (little_e.listUpdateP)
						{
							getEnemies();
							little_e.listUpdateP = false;
						}
					}
					
					little_e.walkOn();
					
					if ((little_e.x + little_e.width * 2 > FP.width || little_e.x < little_e.width ) && (!changeLine))
					{
						changeLine = true;
					}
					
					if (little_e.bottom > playerY)
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
						little_e.comeCloser();
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
	}

}