package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;

	public class Background extends Entity 
	{
		[Embed(source = "../assets/Backgrounds/blue.png")]
		private const BACKGROUND_IMG:Class;
		private var backgroundImage:Image; 
		
		public function Background() 
		{
			graphic = new Backdrop(BACKGROUND_IMG);
		}
		
	}

}