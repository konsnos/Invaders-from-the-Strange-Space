package worlds.objs
{
	import flash.events.TextEvent;
	import mochi.as3.MochiScores;
	import mochi.as3.MochiSocial;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.GeoIP;
	import Playtomic.Log;
	import worlds.Level;
	
	import GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class MainMenu_Obj extends Menu_Obj
	{
		private var welcome:Text;
		
		public function MainMenu_Obj()
		{
			selection = new Array();
			
			welcome = new Text(String("Welcome " + GlobalVariables.USERNAME + " to"));
			welcome.font = 'FONT_TITLE';
			welcome.size = 16;
			welcome.align = "center";
			welcome.x = FP.halfWidth - welcome.width / 2;
			welcome.y = 3;
			welcome.color = 0x32cd32; // Green
			menu = new Graphiclist(welcome);
			
			title = new Text(String("Invaders from the Strange Space"));
			title.font = 'FONT_TITLE';
			title.size = 20;
			title.align = "center";
			title.x = FP.halfWidth - title.width / 2;
			title.y = 25;
			title.color = 0xadff2f; // Green
			menu.add(title);
			
			selection.push(new Text(String("New Game")));
			selection.push(new Text(String("Select Level")));
			selection.push(new Text(String("Highscores")));
			//selection.push(new Text(String("Settings")));
			selection.push(new Text(String("How to play")));
			selection.push(new Text(String("About")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 16;
				Text(selection[i]).align = "center";
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / (selection.length + 1) * (i + 1);
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 0.5;
				menu.add(selection[i]);
			}
			
			Text(selection[0]).alpha = 1;
			
			fadeIn = fadeOut = false;
			
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			super.update()
		}
		
		/**
		 * Checks the input.
		 */
		override public function checkInput():void 
		{
			super.checkInput();
			
			
			
			if (Input.pressed("enter") || Input.mousePressed)
			{
				switch (choiceG)
				{
					case 0:
						fadeOut = true;
						FP.alarm(1, normalGame);
						Log.CustomMetric("NewGame");
						updates = false;
						break;
					case 1:
						selected = new SelectLevel_Obj;
						Log.CustomMetric("LevelSelection", "screens");
						break;
					case 2:
						MochiScores.showLeaderboard( { boardID: "1ef2b7d769343baf" } );
						Log.CustomMetric("Highscores", "screens");
						break;
					case 3:
						selected = new HowToPlay_obj;
						Log.CustomMetric("HowToPlay", "screens");
						break;
					case 4:
						selected = new About_Obj;
						Log.CustomMetric("ViewedCredits","screens");
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * Starts level 1 from normal difficulty.
		 */
		public function normalGame():void 
		{
			FP.world = new Level(1,false);
		}
		
		/**
		 * Starts a level.
		 */
		public function newGame():void 
		{
			GlobalVariables.RESETSCORE();
			FP.world = new Level(1);
		}
		
		override public function removed():void 
		{
			updates = true;
			super.removed();
		}
		
	}

}