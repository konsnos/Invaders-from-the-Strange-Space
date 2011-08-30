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
		 * Pragma: gia th kinhsh twn invaders, valtous olous se position relative se ena shmeio anaforas
		 * Pragma: kai kouna mono to shmeio anaforas
		 * 
		 * Pragma: sto main class, ftiakse mia function
		 * Pragma: pou tha rixnei randomly mia fora kai tha epilegei tyxaia th thesh ths apo shmeio pou einai zwntanos enas exthros
		 */
		
		protected var hp:Number;
		public function get hpG():Number 
		{
			return hp;
		}
		
		public function Alien(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
		}
		
	}

}