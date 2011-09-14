package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import worlds.Level;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Win_Obj extends Menu_Obj 
	{
		private var stage:uint;
		
		public function Win_Obj(tempStage:uint ) 
		{
			layer = -1;
			
			stage = tempStage++;
			selection = new Array();
			title = new Text(String("You Won!!!"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			
			if (Stats_Obj.scoreG > uint(GlobalVariables.SCORE[stage]))
			{
				selection.push(new Text(String("You've surpassed you've previous score by " + (Stats_Obj.scoreG - uint(GlobalVariables.SCORE[stage])) + " points. Well done")));
				GlobalVariables.SCORE[stage] = Stats_Obj.scoreG;
			}else
			{
				selection.push(new Text(String("You needed " + (uint(GlobalVariables.SCORE[stage]) - Stats_Obj.scoreG) + " points to tie the high score")));
			}
			Text(selection[0]).size = 20;
			Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 4 * 2;
			Text(selection[0]).color = 0x00bfff; // white-blue
			
			selection.push(new Text(String("Press Enter to advance to the next level")));
			Text(selection[1]).size = 20;
			Text(selection[1]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[1]).y = FP.height / 3 * 2;
			Text(selection[1]).color = 0x00bfff; // white-blue
			
			menu = new Graphiclist(title, selection[0], selection[1]);
			graphic = menu;
		}
		
	}

}