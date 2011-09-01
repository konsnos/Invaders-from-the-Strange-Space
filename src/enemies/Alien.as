package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Alien extends Entity 
	{
		/*
		 * Pragma: sto main class, ftiakse mia function
		 * Pragma: pou tha rixnei randomly mia fora kai tha epilegei tyxaia th thesh ths apo shmeio pou einai zwntanos enas exthros
		 */
		
		protected var hp:Number;
		protected static var fireChance:Number; // Shows the possibility of firing. 0 < value < 1. 1 means fire in every frame.
		
		// Gets-Sets
		public function get hpG():Number
		{
			return hp;
		}
		public function set hpS(setValue:Number):void 
		{
			hp += setValue;
			if (hp <= 0)
			{
				destroy();
			}
		}
		
		public function Alien(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			
		}
		
		public function takeDamage(damageTaken:Number):void 
		{
			hpS = -damageTaken;
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
		}
		
	}

}