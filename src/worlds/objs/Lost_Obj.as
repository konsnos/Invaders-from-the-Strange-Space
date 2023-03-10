package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Lost_Obj extends Menu_Obj 
	{
		private var brutal:Boolean;
		private var overallBrutalScore:PlayerScore;
		
		public function Lost_Obj(difficulty:Boolean ) 
		{
			layer = -1;
			brutal = difficulty;
			
			selection = new Array();
			title = new Text(String("Mission Failed"));
			title.font = 'FONT_TITLE';
			title.size = 30;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0xb22222; // dark red
			menu = new Graphiclist(title);
			
			selection.push(new Text(String("Press Enter to restart")));
			
			selection.push(new Text(String("Press Backspace to return to the main menu")));
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).align = "center";
				Text(selection[i]).size = 16;
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height /5 * (i+2);
				Text(selection[i]).color = 0xcd5c5c; // White
				menu.add(selection[i]);
			}
			
			graphic = menu;
		}
		
		override public function update():void 
		{
			
		}
		
	}
	
}