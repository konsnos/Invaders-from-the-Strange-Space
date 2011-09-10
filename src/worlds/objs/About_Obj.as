package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author konsnos
	 */
	public class About_Obj extends Menu_Obj 
	{
		
		public function About_Obj() 
		{
			title = new Text(String("About"));
			title.size = 30;
			title.y = 10;
			title.x = FP.halfWidth - title.width/2;
			title.color = 0xc1cdc1; // Yellow
			
			layer = 2;
			
			graphic = new Graphiclist(title);
		}
		
	}

}