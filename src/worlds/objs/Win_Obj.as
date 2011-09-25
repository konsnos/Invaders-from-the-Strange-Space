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
		private var level_score:PlayerScore;
		private var overall_score:PlayerScore;
		
		public function Win_Obj(tempStage:uint ) 
		{
			layer = -1;
			
			stage = tempStage++;
			selection = new Array();
			title = new Text(String("You Won!!!"));
			title.font = 'FONT_TITLE';
			title.size = 50;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			
			if (Stats_Obj.scoreG > uint(GlobalVariables.SCORE[stage]))
			{
				selection.push(new Text(String("You've surpassed the previous score by " + (Stats_Obj.scoreG - uint(GlobalVariables.SCORE[stage])) + " points. Well done!")));
				GlobalVariables.SCORE[stage] = Stats_Obj.scoreG;
			}else
			{
				selection.push(new Text(String("You needed " + (uint(GlobalVariables.SCORE[stage]) - Stats_Obj.scoreG) + " points to tie the high score")));
			}
			Text(selection[0]).font = 'FONT_CHOICE';
			Text(selection[0]).size = 14;
			Text(selection[0]).x = FP.halfWidth - Text(selection[0]).width / 2 + 10;
			Text(selection[0]).y = FP.height / 5 * 2;
			Text(selection[0]).color = 0x00bfff; // white-blue
			
			GlobalVariables.CALCULATESCORE();
			
			selection.push(new Text(String("Your total score is " + GlobalVariables.GAMESCORE + ".")));
			
			selection.push(new Text(String("Press Enter to advance to the next level")));
			Text(selection[1]).font = 'FONT_CHOICE';
			Text(selection[1]).size = 14;
			Text(selection[1]).x = FP.halfWidth - Text(selection[0]).width / 2 + 10;
			Text(selection[1]).y = FP.height / 4 * 2;
			Text(selection[1]).color = 0x00bfff; // white-blue
			
			selection.push(new Text(String("Press enter to procceed to the next level")));
			Text(selection[2]).font = 'FONT_CHOICE';
			Text(selection[2]).size = 14;
			Text(selection[2]).x = FP.halfWidth - Text(selection[0]).width / 2 + 10;
			Text(selection[2]).y = FP.height / 5 * 3;
			Text(selection[2]).color = 0x00bfff; // white-blue
			
			menu = new Graphiclist(title, selection[0], selection[1], selection[2]);
			graphic = menu;
			
			// Store in playtomic
			level_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.SCORE[stage]);
			Leaderboards.Save(level_score, String(stage + 1));
			overall_score = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.GAMESCORE);
			Leaderboards.Save(overall_score, "highscores");
		}
		
	}

}