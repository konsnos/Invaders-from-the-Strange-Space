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
			
			Leaderboards.List("highscores", this.ListComplete);
			
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
		
		private function ListComplete(scores:Array, numscores:int, response:Object):void
		{
			if(response.Success)
			{
				trace(scores.length + " scores returned out of " + numscores);
						
				for(var i:uint=0; i<10; i++)
				{
					var score:PlayerScore = scores[i];
					if (score == null)
					{
						selection.push(new Text(String((i + 1) + ". ")));
					}else
					{
						selection.push(new Text(String((i + 1) + ". " + score.Name + " - " + score.Points)));
					}
					Text(selection[i]).font = 'FONT_CHOICE';
					Text(selection[i]).size = 16;
					Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
					Text(selection[i]).y = FP.height / 15 * i + 100;
					Text(selection[i]).color = 0xffffff;
					Text(selection[i]).alpha = 1;
					menu.add(selection[i]);
					
					// including custom data?  score.CustomData.property
				}
				graphic = menu;
			}
			else
			{
				selection.push(new Text(String("Problem listing scores")))
				selection.push(new Text(String("Error code : " + response.ErrorCode)));
				for(var i:uint=0; i<selection.length -1; i++)
				{
					Text(selection[i]).font = 'FONT_CHOICE';
					Text(selection[i]).size = 16;
					Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
					Text(selection[i]).y = FP.height / 15 * i + 100;
					Text(selection[i]).color = 0xffffff;
					Text(selection[i]).alpha = 1;
					menu.add(selection[i]);
				}
				graphic = menu;
				// score listing failed because of response.ErrorCode
			}
		}
		
	}

}