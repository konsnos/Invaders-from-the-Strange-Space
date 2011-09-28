package worlds.objs 
{
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
		
		public function Win_Obj(tempStage:uint, tempAcc:Number, tempLife:uint ) 
		{
			layer = -1;
			
			stage = tempStage++;
			selection = new Array();
			title = new Text(String("You Won!!!"));
			title.font = 'FONT_TITLE';
			title.size = 40;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			menu = new Graphiclist(title);
			
			score = Stats_Obj.scoreG;
			acc = uint(score * tempAcc);
			life = uint(tempLife * 40);
			
			selection.push(new Text(String("Your score: " + score)));
			selection.push(new Text(String("Points for your accuracy: " + acc)));
			selection.push(new Text(String("Points for your remaining life: " + life)));
			
			score += acc + life;
			
			showScore();
		}
		
		private function showScore():void 
		{
			if (score > uint(GlobalVariables.SCORE[stage]))
			{
				selection.push(new Text(String("You've surpassed the previous score by " + (score - uint(GlobalVariables.SCORE[stage])) + " points. Well done!")));
				GlobalVariables.SCORE[stage] = score;
				level_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.SCORE[stage]);
				level_score.CustomData["Name"] = GlobalVariables.USERNAME;
				Leaderboards.Save(level_score, String(stage+1));
			}else
			{
				selection.push(new Text(String("You needed " + (uint(GlobalVariables.SCORE[stage]) - score) + " points to tie your high score")));
			}
			
			GlobalVariables.CALCULATESCORE();
			
			selection.push(new Text(String("Your total score is " + GlobalVariables.GAMESCORE + ".")));
			selection.push(new Text(String("Press Enter to advance to the next level")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 11;
				Text(selection[i]).x = FP.halfWidth - (Text(selection[i]).width / 2 *0.7);
				Text(selection[i]).y = ((FP.height - 200) / selection.length) * i + 100;
				Text(selection[i]).color = 0x00bfff; // white-blue
				menu.add(selection[i]);
			}
			
			graphic = menu;
			
			// Store in playtomic
			overall_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.GAMESCORE);
			overall_score.CustomData["Name"] = GlobalVariables.USERNAME;
			Leaderboards.Save(overall_score, "highscores");
		}
		
	}

}