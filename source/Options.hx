package;

import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;

class OptionCatagory
{
	private var _options:Array<Option> = new Array<Option>();
	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	
	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Catagory";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}
	private var display:String;
	private var acceptValues:Bool = false;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}
	
	// Returns whether the label is to be updated.
	public function press(changeData:Bool):Bool { return throw "stub!"; }
	private function updateDisplay():String { return throw "stub!"; }
	public function left():Bool { return throw "stub!"; }
	public function right():Bool { return throw "stub!"; }
}



class DownscrollOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		acceptValues = FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Downscroll "/* + (!FlxG.save.data.downscroll ? "off" : "on")*/;
	}
}



class MiddlescrollOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.middlescroll = !FlxG.save.data.middlescroll;
		acceptValues = FlxG.save.data.middlescroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Middlescroll "/* + (!FlxG.save.data.middlescroll ? "off" : "on")*/;
	}
}


class PauseCountdownOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.pauseCountdown = !FlxG.save.data.pauseCountdown;
		acceptValues = FlxG.save.data.pauseCountdown;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Pause Countdown "/* + (!FlxG.save.data.pauseCountdown ? "off" : "on")*/;
	}
}

class InstantRespawnOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.instRespawn = !FlxG.save.data.instRespawn;
		acceptValues = FlxG.save.data.instRespawn;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Instant Respawn "/* + (!FlxG.save.data.instRespawn ? "off" : "on")*/;
	}
}

class PreloadImagesOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.preloadCharacters = !FlxG.save.data.preloadCharacters;
		FlxGraphic.defaultPersist = FlxG.save.data.preloadCharacters;
		acceptValues = FlxG.save.data.preloadCharacters;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Preload Images"/* + (!FlxG.save.data.instRespawn ? "off" : "on")*/;
	}
}

class BotOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.botAutoPlay = !FlxG.save.data.botAutoPlay;
		acceptValues = FlxG.save.data.botAutoPlay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Bot Auto Play "/* + (!FlxG.save.data.botAutoPlay ? "off" : "on")*/;
	}
}

class FPSOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
		{
			FlxG.save.data.fps = !FlxG.save.data.fps;
			(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		}
			
		acceptValues = FlxG.save.data.fps;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Counter "/* + (!FlxG.save.data.fps ? "off" : "on")*/;
	}
}

class ShadersOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.shadersOn = !FlxG.save.data.shadersOn;
		acceptValues = FlxG.save.data.shadersOn;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Shaders "/* + (!FlxG.save.data.shadersOn ? "off" : "on")*/;
	}
}

class MemoryCounterOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
		{
			FlxG.save.data.mem = !FlxG.save.data.mem;
			(cast (Lib.current.getChildAt(0), Main)).toggleMem(FlxG.save.data.mem);
		}
		
		acceptValues = FlxG.save.data.mem;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Memory Counter "/* + (!FlxG.save.data.fps ? "off" : "on")*/;
	}
}

class FullscreenOption extends Option
{
	public function new()
	{
		super();
	}

	public override function press(changeData:Bool):Bool
	{
		if(changeData)
			FlxG.save.data.fullscreen = !FlxG.save.data.fullscreen;
		acceptValues = FlxG.save.data.fullscreen;
		FlxG.fullscreen = FlxG.save.data.fullscreen;
		
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Fullscreen "/* + (!FlxG.save.data.fullscreen ? "off" : "on")*/;
	}
}





