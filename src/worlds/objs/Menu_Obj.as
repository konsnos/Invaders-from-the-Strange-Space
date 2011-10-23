package worlds.objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Konstantinos Egarhos
	 */
	public class Menu_Obj extends Entity 
	{
		protected var title:Text;
		protected var selection:Array;
		protected var back:Text;
		protected var selected:Menu_Obj;
		public var updates:Boolean; // When false the player can't press enter to choose the same option.
		protected var menu:Graphiclist;
		private var choice:Number = 1;
		public var fadeIn:Boolean;
		public var fadeOut:Boolean;
		
		// Gets-Sets
		protected function get choiceG():Number
		{
			return choice;
		}
		protected function set choiceS(setValue:int):void 
		{
			if (setValue == 0)
			{
				choice = 0;
			}else
			{
				choice += setValue;
				if (choice < 0)
				{
					choice = 0;
				}else if (choice > selection.length -1)
				{
					choice = selection.length -1;
				}
			}
		}
		protected function set choiceSM(setValue:int):void 
		{
			choice = setValue;
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
			updates = true;
		}
		
		override public function update():void 
		{
			if (selected == null && updates)
			{
				checkInput();
			}
		}
		
		/**
		 * Checks the input.
		 */
		public function checkInput():void 
		{
			if (Input.pressed("down"))
			{
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = 1;
				Text(selection[choiceG]).alpha = 1;
			}
			else if (Input.pressed("up"))
			{
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = -1;
				Text(selection[choiceG]).alpha = 1;
			}
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				if (Input.mouseX >= Text(selection[i]).x && Input.mouseX <=  Text(selection[i]).width + Text(selection[i]).x)
				{
					if (Input.mouseY >= Text(selection[i]).y && Input.mouseY <=  Text(selection[i]).height + Text(selection[i]).y)
					{
						if (choiceG != i)
						{
							for (var j:uint = 0; j < selection.length; j++)
							{
								if (j != i)
								{
									Text(selection[j]).alpha = 0.5;
								}else
								{
									Text(selection[j]).alpha = 1;
									choiceSM = j;
								}
							}
						}
					}
				}
			}
		}
		
	}

}