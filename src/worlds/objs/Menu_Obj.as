package worlds.objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;
	/**
	 * ...
	 * @author ...
	 */
	public class Menu_Obj extends Entity 
	{
		protected var title:Text;
		protected var selection:Array;
		protected var selected:Menu_Obj;
		protected var menu:Graphiclist;
		private var choice:Number = 1;
		
		// Gets-Sets
		protected function get choiceG():Number
		{
			return choice;
		}
		protected function set choiceS(setValue:Number):void 
		{
			if (setValue == 0)
			{
				choice = 0;
			}else
			{
				choice += setValue;
				if (choice < 0)
				{
					choice = 2;
				}else if (choice > 2)
				{
					choice = 0;
				}
			}
		}
		public function get selectedG():Menu_Obj 
		{
			return selected;
		}
		public function set selectedS(setValue:Menu_Obj):void 
		{
			selected = setValue;
		}
		
		public function Menu_Obj() 
		{
			selected = null;
		}
		
	}

}