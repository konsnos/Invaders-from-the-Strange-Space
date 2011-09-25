package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	import worlds.Level;
	import worlds.objs.Menu_Obj;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class WeaponsFree_Obj extends Menu_Obj 
	{
		public function WeaponsFree_Obj() 
		{
			title = new Text(String("Weapons Free"));
			title.font = 'FONT_CHOICE';
			title.size = 30;
			title.x = FP.halfWidth - title.width / 2;
			title.y = FP.height / 10 * 7;
			title.color = 0xbff0000; // dark red
			title.alpha = 1;
			
			layer = -1;
			
			graphic = menu = new Graphiclist(title);
		}
		
		public function setAlpha(alpha:Number):Number 
		{
			return title.alpha -= alpha;
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				title.alpha -= FP.elapsed;
				
				if (title.alpha < 0)
				{
					FP.world.remove(this);
				}
			}
		}
		
	}

}