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
	
	import objects.enemies.Little;
	import objects.player.Player;
	import objects.bullets.Bullet;
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
		private var score:Number;
		private var gameState:Number;
		private var pause:Boolean;
		private var wasPaused:Boolean;
		
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
		
		// Gets-Sets
		public function set gameStateS(setValue:Number):void
		{
			gameState = setValue;
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
			
			gameState = GlobalVariables.PLAYING;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			score = 0;
			pause = false;
			wasPaused = false;
			
			addGraphic(background1, 1);
			addGraphic(background2, 0);
			
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
			
			littles_e = new Array();
			entitiesToRemove = new Array();
			little_e = null;
		}
		
		override public function update():void 
		{
			super.update();
			
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
			}else if (Input.pressed("shoot") && gameState == GlobalVariables.WIN)
			{
				returnToMainMenu();
			}
			if (gameState == GlobalVariables.PLAYING)
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
			
			if (player.hpG <= 0)
			{
				gameStateS = GlobalVariables.LOST;
				add(new Lost_Obj);
			}
			
			if (littles_e.length == 0 && gameState == GlobalVariables.PLAYING)
			{
				getEnemies();
				if (littles_e.length == 0)
				{
					gameState = GlobalVariables.WIN; // WIN!!!
					add(new Win_Obj);
				}
			}
			
			background1.y += layer1Y;
			background2.y += layer2Y;
			
			updateEnemies();
		}
		
		private function updateEnemies():void 
		{
			if (Little.listUpdateG)
			{
				getEnemies();
				Little.listUpdateS = false;
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
	}

}