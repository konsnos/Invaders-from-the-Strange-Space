package worlds.objs 
{
	import mochi.as3.MochiScores;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	import worlds.Level;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Win_Obj extends Menu_Obj 
	{
		private var stage:uint;
		private var score:uint;
		private var acc:uint;
		private var life:uint;
		private var level_score:PlayerScore;
		private var overall_score:PlayerScore;
		private var brutal:Boolean;
		
		/**
		 * Creates a Win screen.
		 * @param	tempStage The level the player has won.
		 * @param	tempAcc The accuracy of the player from 0 to 1.
		 * @param	tempLife The remaining life of the player.
		 * @param	difficultyTemp The difficulty of the level.
		 */
		public function Win_Obj(tempStage:uint, tempAcc:Number, tempLife:uint, difficulty:Boolean = false ) 
		{
			layer = -1;
			brutal = difficulty;
			
			stage = tempStage++;
			selection = new Array();
			title = new Text(String("Mission Accomplished"));
			title.font = 'FONT_TITLE';
			title.size = 30;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			menu = new Graphiclist(title);
			
			Stats_Obj.calculateBonusScores();
			
			selection.push(new Text(String("Your score: " + Stats_Obj.scoreG)));
			selection.push(new Text(String(int(tempAcc*100) + "% accuracy: +" + Stats_Obj.accG)));
			selection.push(new Text(String("Remaining life: +" + Stats_Obj.lifeG)));
			
			showScore();
		}
		
		/**
		 * Shows the score.
		 */
		private function showScore():void 
		{
			if (Stats_Obj.finalScoreG > uint(GlobalVariables.SCORE[stage]))
			{
				selection.push(new Text(String("You've surpassed your previous score by " + (Stats_Obj.finalScoreG - uint(GlobalVariables.SCORE[stage])) + " points!")));
				GlobalVariables.SCORE[stage] = Stats_Obj.finalScoreG;
				
				level_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.SCORE[stage]);
				level_score.CustomData["Name"] = GlobalVariables.USERNAME;
				Leaderboards.Save(level_score, String(stage + 1));
				
				GlobalVariables.CALCULATESCORE();
				// Store in playtomic
				overall_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.GAMESCORE);
				overall_score.CustomData["Name"] = GlobalVariables.USERNAME;
				Leaderboards.Save(overall_score, "highscores");
			}else
			{
				GlobalVariables.CALCULATESCORE();
				selection.push(new Text(String("You needed " + (uint(GlobalVariables.SCORE[stage]) - Stats_Obj.finalScoreG) + " points to tie your high score.")));
			}
			
			selection.push(new Text(String("Your total score is " + GlobalVariables.GAMESCORE + ".")));
			
			// MOCHI
			MochiScores.setBoardID("1ef2b7d769343baf");
			MochiScores.submit(GlobalVariables.GAMESCORE, GlobalVariables.USERNAME);
			//Kongregate.submit("normalHighScores", GlobalVariables.GAMESCORE);
			
			selection.push(new Text(String("Press Enter to advance to the next level")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).align = "center";
				Text(selection[i]).size = 12;
				Text(selection[i]).x = FP.halfWidth - (Text(selection[i]).width / 2);
				Text(selection[i]).y = ((FP.height - 200) / selection.length) * i + 100;
				Text(selection[i]).color = 0x00bfff; // white-blue
				menu.add(selection[i]);
			}
			
			graphic = menu;
		}
		
		override public function update():void 
		{
			
		}
		
	}

}