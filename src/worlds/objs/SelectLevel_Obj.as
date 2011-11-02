package worlds.objs 
{
	import flash.sampler.NewObjectSample;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import Playtomic.Log;
	import worlds.Level;
	/**
	 * ...
	 * @author konsnos
	 */
	public class SelectLevel_Obj extends Menu_Obj 
	{
		private var prevTween:NumTween;
		private var updating:Boolean;
		protected var levelScores:Array;
		
		public function SelectLevel_Obj() 
		{
			selection = new Array();
			selected = null;
			title = new Text(String("Select Level"));
			title.font = 'FONT_TITLE';
			title.size = 20;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			updating = false;
			updates = true;
			
			for (var i:uint = 0; i < GlobalVariables.MAP.length; i++)
			{
				selection.push(new Array(new Text(String("Level " + (i + 1))), new Text(String(GlobalVariables.SCORE[i])), new Text(String(GlobalVariables.GLSCORE[i]))));
				// Level
				Text(selection[i][0]).font = 'FONT_CHOICE';
				Text(selection[i][0]).size = 16;
				Text(selection[i][0]).x = FP.halfWidth - Text(selection[i][0]).width / 2 - 30;
				Text(selection[i][0]).y = FP.halfHeight - Text(selection[i][0]).height / 2 + (FP.height / 5 * i);
				Text(selection[i][0]).color = 0xFFFFFF; // White
				Text(selection[i][0]).alpha = 0.5;
				
				// User score
				Text(selection[i][0]).font = 'FONT_CHOICE';
				Text(selection[i][1]).size = 10;
				Text(selection[i][1]).x = Text(selection[i][0]).x + 100;
				Text(selection[i][1]).y = Text(selection[i][0]).y;
				Text(selection[i][1]).color = 0x00bfff; // White
				Text(selection[i][1]).alpha = 0.5;
				
				// Global score
				Text(selection[i][2]).font = 'FONT_CHOICE';
				Text(selection[i][2]).size = 10;
				Text(selection[i][2]).x = Text(selection[i][0]).x + 100;
				Text(selection[i][2]).y = Text(selection[i][0]).y + 7;
				Text(selection[i][2]).color = 0xFF0000; // White
				Text(selection[i][2]).alpha = 0.5;
				
				menu.add(selection[i][0]);
				menu.add(selection[i][1]);
				menu.add(selection[i][2]);
			}
			
			back = new Text(String("back"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(back).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 0.5;
			menu.add(back);
			
			prevTween = new NumTween(updated);
			addTween(prevTween);
			Text(selection[0][0]).alpha = 1;
			Text(selection[0][1]).alpha = 1;
			Text(selection[0][2]).alpha = 1;
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			super.update()
			
			if (updating)
			{
				Text(selection[0][0]).y = prevTween.value;
				Text(selection[0][1]).y = Text(selection[0][0]).y;
				Text(selection[0][2]).y = Text(selection[0][0]).y + 7;
				
				for (var i:uint = 1; i < GlobalVariables.MAP.length; i++)
				{
					Text(selection[i][0]).y = prevTween.value + 95 * i;
					Text(selection[i][1]).y = Text(selection[i][0]).y;
					Text(selection[i][2]).y = Text(selection[i][0]).y + 7;
				}
			}
		}
		
		override public function checkInput():void 
		{
			if ((Input.mouseY > FP.height / 4 * 3) && !updating && choiceG != selection.length - 1)
			{
				prevTween.tween(Text(selection[0][0]).y, Text(selection[0][0]).y - FP.height / 5, 0.3, Ease.sineInOut);
				updating = true;
				Text(selection[choiceG][0]).alpha = 0.5;
				Text(selection[choiceG][1]).alpha = 0.5;
				Text(selection[choiceG][2]).alpha = 0.5;
				choiceS = 1;
				Text(selection[choiceG][0]).alpha = 1;
				Text(selection[choiceG][1]).alpha = 1;
				Text(selection[choiceG][2]).alpha = 1;
			}
			else if ((Input.mouseY < FP.height / 4) && !updating && choiceG != 0)
			{
				prevTween.tween(Text(selection[0][0]).y, Text(selection[0][0]).y + FP.height / 5, 0.3, Ease.sineInOut);
				updating = true;
				Text(selection[choiceG][0]).alpha = 0.5;
				Text(selection[choiceG][1]).alpha = 0.5;
				Text(selection[choiceG][2]).alpha = 0.5;
				choiceS = -1;
				Text(selection[choiceG][0]).alpha = 1;
				Text(selection[choiceG][1]).alpha = 1;
				Text(selection[choiceG][2]).alpha = 1;
			}
			
			if ((Input.pressed("enter") || Input.mousePressed) && !updating && !returnBackG)
			{
				fadeOut = true;
				updates = false;
				FP.alarm(1, startLevel);
			}
			
			if (back != null)
			{
				if (Input.mouseX >= Text(back).x && Input.mouseX <= Text(back).x + Text(back).width)
				{
					if (Input.mouseY >= Text(back).y && Input.mouseY <= Text(back).y + Text(back).height)
					{
						focus = true;
						if (Text(back).alpha != 1)
						{
							Text(back).alpha = 1;
							if (!returnBackG)
							{
								returnBack = true;
							}
						}
					}else
					{
						if (Text(back).alpha != 0.5)
						{
							Text(back).alpha = 0.5;
						}
						if (returnBackG)
						{
							returnBack = false;
						}
					}
				}
			}
		}
		
		public function updated():void 
		{
			updating = false;
		}
		
		public function startLevel():void 
		{
			Log.LevelCounterMetric("LevelSelected", int(choiceG + 1));
			FP.world = new Level(choiceG + 1);
		}
	}
}