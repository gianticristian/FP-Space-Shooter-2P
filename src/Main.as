package
{
	import net.flashpunk.Engine; 
	import net.flashpunk.FP; 
	
	[SWF(width = "1000", height = "800")]
	
	public class Main extends Engine  
	{

		public function Main() 
		{
			super(1000, 800, 50, false);
			FP.screen.color = 0xFFFF0000;
			//FP.screen.scale = 1;
			
			//FP.console.enable(); FP.console.toggleKey = 188; // Con esto habilito la consola. Se activa con la tecla ',' (coma).
		}
		
		override public function init():void 
		{	
  			FP.world  =  new  GameWorld(); 
		}
	}
}