package worlds.objs
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import worlds.SoundSystem;
	
	/**
	 * ...
	 * @author Konstantinos Egarhos
	 */
	public class MuteBtn extends Entity 
	{
		private var sprite:Spritemap = new Spritemap(GlobalVariables.IMG_SOUND, 32, 32);
		
		public function MuteBtn() 
		{
			sprite.add("off", [1], 0, false);
			sprite.add("on", [0], 0, false);
			
			width = sprite.width;
			height = sprite.height;
			
			this.x = FP.width - this.width - 1;
			this.y = FP.height - this.height - 1;
			
			layer = -2;
			
			graphic = sprite;
		}
		
		override public function added():void 
		{
			if (SoundSystem.muteG)
			{
				sprite.play("off");
			}else
			{
				sprite.play("on");
			}
		}
		
		override public function update():void 
		{
			if (Input.mouseReleased && Input.mouseX > this.x && Input.mouseX < this.x + this.width && Input.mouseY > this.y && Input.mouseY < this.y + this.height)
			{
				if (sprite.currentAnim == "on")
				{
					SoundSystem.reverseMute();
					sprite.play("off");
				}else
				{
					SoundSystem.reverseMute();
					sprite.play("on");
				}
			}
		}
		
	}

}