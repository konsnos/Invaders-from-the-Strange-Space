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
	public class ShowHighscores_Obj extends Menu_Obj 
	{
		private var i:uint;
		public function ShowHighscores_Obj() 
		{
			selection = new Array();
			selected = null;
			
			title = new Text(String("Highscores"));
			title.font = 'FONT_TITLE';
			title.size = 20;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			
			Leaderboards.List("highscores", this.globalListComplete);
			
			selection.push(new Text(String("Normal")));
			Text(selection[selection.length -1]).font = 'FONT_CHOICE';
			Text(selection[selection.length -1]).size = 18;
			Text(selection[selection.length -1]).align = "center";
			Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) - 150;
			Text(selection[selection.length -1]).y = 70;
			Text(selection[selection.length -1]).color = 0xcd5c5c; // white blue
			Text(selection[selection.length -1]).alpha = 1;
			menu.add(selection[selection.length -1]);
			selection.push(new Text(String("Brutal")));
			Text(selection[selection.length -1]).font = 'FONT_CHOICE';
			Text(selection[selection.length -1]).size = 18;
			Text(selection[selection.length -1]).align = "center";
			Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) + 150;
			Text(selection[selection.length -1]).y = 70;
			Text(selection[selection.length -1]).color = 0xb22222; // white blue
			Text(selection[selection.length -1]).alpha = 1;
			menu.add(selection[selection.length -1]);
			
			back = new Text(String("Press Backspace to return"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(back).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
			graphic = menu;
		}
		
		private function userListComplete(scores:Array, numscores:int, response:Object):void
		{
			if (response.Success)
			{
				var score:PlayerScore = scores[0];
				if (score == null)
				{
					selection.push(new Text(String("You don't have a score yet.")));
				}else
				{
					selection.push(new Text(String(score.Name + " - " + score.Points)));
				}
			}else
			{
				
			}
			
			Text(selection[selection.length -1]).font = 'FONT_CHOICE';
			Text(selection[selection.length -1]).size = 14;
			Text(selection[selection.length -1]).align = "center";
			Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) - 150;
			Text(selection[selection.length -1]).y = FP.height / 15 * 10 + 100;
			Text(selection[selection.length -1]).color = 0x00bfff; // white blue
			Text(selection[selection.length -1]).alpha = 1;
			
			menu.add(selection[selection.length -1]);
			graphic = menu;
			
			Leaderboards.List("brutalhighscores", this.globalBrutalListComplete);
		}
		
		private function globalListComplete(scores:Array, numscores:int, response:Object):void
		{
			if(response.Success)
			{
				for ( i = 0; i < 10; i++)
				{
					var score:PlayerScore = scores[i];
					if (score == null)
					{
						selection.push(new Text(String((i + 1) + ". ")));
					}else
					{
						selection.push(new Text(String((i + 1) + ". " + score.Name + " - " + score.Points)));
					}
					Text(selection[selection.length -1]).font = 'FONT_CHOICE';
					Text(selection[selection.length -1]).size = 16;
					Text(selection[selection.length -1]).align = "center";
					Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) - 150;
					Text(selection[selection.length -1]).y = FP.height / 15 * i + 100;
					Text(selection[selection.length -1]).color = 0xffffff; // white blue
					Text(selection[selection.length -1]).alpha = 1;
					menu.add(selection[selection.length -1]);
				}
				graphic = menu;
			}
			else
			{
				selection.push(new Text(String("Problem listing scores")))
				selection.push(new Text(String("Error code : " + response.ErrorCode)));
				for (i = 0; i < selection.length -1; i++)
				{
					Text(selection[selection.length -1]).font = 'FONT_CHOICE';
					Text(selection[selection.length -1]).size = 16;
					Text(selection[selection.length -1]).x = FP.halfWidth - Text(selection[selection.length -1]).width / 2;
					Text(selection[selection.length -1]).y = FP.height / 15 * i + 100;
					Text(selection[selection.length -1]).color = 0xffffff;
					Text(selection[selection.length -1]).alpha = 1;
					menu.add(selection[selection.length -1]);
				}
				graphic = menu;
				
			}
			Leaderboards.List("highscores", this.userListComplete, { customfilters: { "Name": GlobalVariables.USERNAME }} );
		}
		
		private function globalBrutalListComplete(scores:Array, numscores:int, response:Object):void
		{
			if(response.Success)
			{
				for ( i = 0; i < 10; i++)
				{
					var score:PlayerScore = scores[i];
					if (score == null)
					{
						selection.push(new Text(String((i + 1) + ". ")));
					}else
					{
						selection.push(new Text(String((i + 1) + ". " + score.Name + " - " + score.Points)));
					}
					Text(selection[selection.length -1]).font = 'FONT_CHOICE';
					Text(selection[selection.length -1]).size = 16;
					Text(selection[selection.length -1]).align = "center";
					Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) + 150;
					Text(selection[selection.length -1]).y = FP.height / 15 * i + 100;
					Text(selection[selection.length -1]).color = 0xffffff; // white blue
					Text(selection[selection.length -1]).alpha = 1;
					menu.add(selection[selection.length -1]);
				}
				graphic = menu;
			}
			else
			{
				selection.push(new Text(String("Problem listing scores")))
				selection.push(new Text(String("Error code : " + response.ErrorCode)));
				for (i = 0; i < selection.length -1; i++)
				{
					Text(selection[selection.length -1]).font = 'FONT_CHOICE';
					Text(selection[selection.length -1]).size = 16;
					Text(selection[selection.length -1]).x = FP.halfWidth - Text(selection[selection.length -1]).width / 2;
					Text(selection[selection.length -1]).y = FP.height / 15 * i + 200;
					Text(selection[selection.length -1]).color = 0xffffff;
					Text(selection[selection.length -1]).alpha = 1;
					menu.add(selection[selection.length -1]);
				}
				graphic = menu;
				
			}
			Leaderboards.List("brutalhighscores", this.userBrutalListComplete, { customfilters: { "Name": GlobalVariables.USERNAME }} );
		}
		
		private function userBrutalListComplete(scores:Array, numscores:int, response:Object):void
		{
			if (response.Success)
			{
				var score:PlayerScore = scores[0];
				if (score == null)
				{
					selection.push(new Text(String("You don't have a score yet.")));
				}else
				{
					selection.push(new Text(String(score.Name + " - " + score.Points)));
				}
			}else
			{
				
			}
			
			Text(selection[selection.length -1]).font = 'FONT_CHOICE';
			Text(selection[selection.length -1]).size = 14;
			Text(selection[selection.length -1]).align = "center";
			Text(selection[selection.length -1]).x = (FP.halfWidth - Text(selection[selection.length -1]).width / 2) + 150;
			Text(selection[selection.length -1]).y = FP.height / 15 * 10 + 100;
			Text(selection[selection.length -1]).color = 0x00bfff; // white blue
			Text(selection[selection.length -1]).alpha = 1;
			
			menu.add(selection[selection.length -1]);
			graphic = menu;
		}
		
	}

}