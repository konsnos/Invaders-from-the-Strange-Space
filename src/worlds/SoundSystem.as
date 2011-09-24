package worlds 
{
	import flash.events.KeyboardEvent;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author konsnos
	 */
	public class SoundSystem
	{
		private static var mute:Boolean;
		private static var volume:Number; // From 0 to 1.
		private static var snd:Sfx;
		
		// Gets-Sets
		public static function get muteG():Boolean
		{
			return mute;
		}
		
		public function SoundSystem() 
		{
			
		}
		
		/**
		 * Sets mute to false, and volume to max volume.
		 */
		public static function reset():void 
		{
			mute = false;
			volume = 1;
			setVolume();
		}
		
		public static function setVolume():void 
		{
			if (mute)
			{
				FP.volume = 0;
			}else
			{
				FP.volume = volume;
			}
		}
		
		/**
		 * Returns the pan value according to the entity x position in the stage.
		 * @param	xPos The x position where the sound is comming.
		 * @return The pan value.
		 */
		public static function panSound(xPos:Number):Number 
		{
			if (xPos > FP.halfWidth)
			{
				xPos -= FP.halfWidth;
				return xPos / FP.halfWidth;
			}else if(xPos < FP.halfWidth)
			{
				return (FP.halfWidth-xPos)*(-1);
			}else
			{
				return 0;
			} 
		}
		
		/**
		 * Plays sounds.
		 * @param	snd The sound you want to hear.
		 * @param	xPos The source of the sound in the x axis for panning.
		 */
		public static function play(snd:Sfx, xPos:Number = 400):void 
		{
			if (!mute)
			{
				snd.play(volume, panSound(xPos));
			}
		}
		
		/**
		 * Loops sounds.
		 * @param	snd The sound you want to hear.
		 * @param	xPos The source of the sound in the x axis for panning.
		 */
		public static function loop(snd:Sfx, xPos:Number = 400):void 
		{
			if (!mute)
			{
				snd.loop(volume, xPos);
			}
		}
		
		/**
		 * Pauses the sound from playing.
		 * @param	snd The sound you want to pause.
		 */
		public static function pause(snd:Sfx):void
		{
			snd.stop();
		}
		
		/**
		 * Mutes or unmutes the sounds.
		 */
		public static function reverseMute():void 
		{
			if (mute)
			{
				mute = false;
			}else
			{
				mute = true;
			}
			setVolume();
		}
		
	}

}