package worlds.objs
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * implements a simple starfield
	 * @author Richard Marks
	 */
	public class Starfield extends Graphic
	{
		// stars is [star1, star2, star3, etc]
		// star# is [graphic, x, y, color, speed]
		private var stars:Array;
		
		// number of stars
		private var fieldDensity:int;
		private var fieldColors:Array;
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING ||
			GlobalVariables.gameState == GlobalVariables.PREPARING)
			{
				// move stars from the top of the screen to the bottom
				for each(var star:Array in stars)
				{
					// add speed to the star
					star[2] += star[4];
					
					if (star[2] > FP.height)
					{
						// new random x position and warp back to top
						star[1] = Math.random() * FP.width;
						star[2] = 0;
					}
				}
			}
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void 
		{
			for each(var star:Array in stars)
			{
				(star[0] as Image).render(target, new Point(star[1], star[2]), camera);
			}
		}
		
		/**
		 * creates a new starfield
		 * @param	density - number of stars
		 * @param	colors - an array of unsigned integers for each star color depth
		 */
		public function Starfield(density:int = 400, colors:Array = null) 
		{
			if (colors == null)
			{
				colors = [0x444444, 0x999999, 0xBBBBBB, 0xFFFFFF];
			}
			
			if (density > 1000)
			{
				density = 1000;
			}
			
			fieldDensity = density;
			fieldColors = colors;
			active = true;
			visible = true;
			
			CreateField();
		}
		
		// creates the starfield
		private function CreateField():void
		{
			// new array of stars
			stars = new Array;
			
			for (var i:int = 0; i < fieldDensity; i++)
			{
				// star is [graphic, x, y, color, speed]
				var star:Array = [null, null, null, null, null];
				
				// random position
				star[1] = Math.random() * FP.width;
				star[2] = Math.random() * FP.height;
				
				// random speed based on number of available colors
				star[4] = Math.floor(Math.random() * fieldColors.length);
				
				// color based on speed
				star[3] = fieldColors[star[4]];
				
				// star graphic itself
				star[0] = Image.createRect(1, 1, star[3]);
				
				// add star to the stars array
				stars.push(star);
			}
		}	
	}
}