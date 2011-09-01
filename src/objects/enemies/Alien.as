package objects.enemies 
{
	import net.flashpunk.FP;
	import objects.Actor;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Alien extends Actor 
	{
		/*
		 * Pragma: sto main class, ftiakse mia function
		 * Pragma: pou tha rixnei randomly mia fora kai tha epilegei tyxaia th thesh ths apo shmeio pou einai zwntanos enas exthros
		 */
		
		protected static var fireChance:Number; // Shows the possibility of firing. 0 < value < 1. 1 means fire in every frame.
		
		public function Alien(x:Number, y:Number) 
		{
			super();
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			
		}
		
	}

}