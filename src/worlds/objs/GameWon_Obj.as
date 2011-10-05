package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GameWon_Obj extends Menu_Obj 
	{
		
		public function GameWon_Obj(brutal:Boolean = false) 
		{
			selection = new Array();
			title = new Text(String("Congratulations!!!"));
			title.font = 'FONT_TITLE';
			title.size = 40;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			menu = new Graphiclist(title);
			
			if (!brutal)
			{
				GlobalVariables.CALCULATESCORE();
				
				selection.push(new Text(String("You finished the game with " + GlobalVariables.GAMESCORE + " points!")));
			}else
			{
				selection.push(new Text(String("You finished game in Brutal with " + GlobalVariables.BRUTALSCORE + " points! WOW!!!")));
				var overallBrutalScore:PlayerScore = new PlayerScore(GlobalVariables.USERNAME, GlobalVariables.BRUTALSCORE);
				overallBrutalScore.CustomData["Name"] = GlobalVariables.USERNAME;
				Leaderboards.Save(overallBrutalScore, "brutalhighscores");
			}
			
			selection.push(new Text(String("To check your ranking with other players look at the highscores in the main menu.")));
			selection.push(new Text(String("To improve your score you can try improve your accuracy, and avoid enemies bullets.")));
			selection.push(new Text(String("We hope you had fun :) ~ The development team")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).wordWrap = true;
				Text(selection[i]).align = "center";
				Text(selection[i]).size = 12;
				Text(selection[i]).width = 600;
				Text(selection[i]).x = FP.halfWidth - (Text(selection[i]).width / 2);
				Text(selection[i]).y = ((FP.height - 200) / selection.length) * i + 100;
				Text(selection[i]).color = 0x00bfff; // white-blue
				menu.add(selection[i]);
			}
			
			graphic = menu;
		}
		
	}

}