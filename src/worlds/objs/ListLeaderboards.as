package worlds.objs 
{
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	/**
	 * ...
	 * @author konsnos
	 */
	public class ListLeaderboards 
	{
		private var level:uint;
		
		public function ListLeaderboards(levelTemp:uint) 
		{
			level = levelTemp;
			getScore(true);
			getScore(false);
		}
		
		public function getScore(name:Boolean):void 
		{
			if (name)
			{
				Leaderboards.List(String(level), levelListComplete, { customfilters: { "Name": GlobalVariables.USERNAME }} );
			}else
			{
				Leaderboards.List(String(level), levelGLListComplete );
			}
		}
		
		private function levelListComplete(scores:Array, numscores:int, response:Object):void 
		{
			if (response.Success)
			{
				var score:PlayerScore = scores[0];
				if (score != null)
				{
					GlobalVariables.SCORE[level -1] = score.Points;
				}
			}else 
			{
				
			}
		}
		
		private function levelGLListComplete(scores:Array, numscores:int, response:Object):void 
		{
			if (response.Success)
			{
				var score:PlayerScore = scores[0];
				if (score != null)
				{
					GlobalVariables.GLSCORE[level -1] = score.Points;
				}
			}else 
			{
				
			}
		}
		
	}

}