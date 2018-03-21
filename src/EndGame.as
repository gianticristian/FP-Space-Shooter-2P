package 
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;

	public class EndGame extends World 
	{
		/* -------------- Text -------------- */
		private var pointsText:Text;
		/* -------------- Variables -------------- */
		private var points:int = 0;
		
		public function EndGame(_points:int) 
		{
			pointsText = new Text("");
			points = _points;
			super();
		}
		
		override public function begin():void 
		{
			SetTextUI();
		}
		
		private function SetTextUI():void 
		{
			pointsText.text = "Puntaje Total: " + points;
			// Result
			pointsText.align = "center";
			pointsText.color = 0x000000;
			pointsText.size = 24;
			pointsText.x = FP.screen.width / 2 - pointsText.width / 2;
			pointsText.y = FP.screen.height / 2 - pointsText.height / 2; 
			addGraphic(pointsText);			
		}
	
	}

}