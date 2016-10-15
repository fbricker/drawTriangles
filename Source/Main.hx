package;


import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;


class Main extends Sprite {
	
	var triangles:openfl.Vector<Float>;
	var uvs:openfl.Vector<Float>;
	var ids:openfl.Vector<Int>;
	var bmp:BitmapData;
	var marker:Sprite;
	var waitFrames:Int=180;

	public function new () {
		
		super ();
		triangles = new openfl.Vector<Float>();
		ids = new openfl.Vector<Int>();

		ids.push(0); ids.push(1); ids.push(2);
		ids.push(3); ids.push(4); ids.push(5);

		triangles.push(1); triangles.push(1);
		triangles.push(1); triangles.push(100);
		triangles.push(100); triangles.push(50);

		triangles.push(1); triangles.push(100);
		triangles.push(100); triangles.push(50);
		triangles.push(100); triangles.push(100);

		bmp = new BitmapData(300,300,false,0xff0000);
		for(xx in 0...6) for(yy in 0...6){
			var color =  
				(Std.random(255)<<16) +
				(Std.random(255)<<8) +
				(Std.random(255)<<0);
			bmp.fillRect(new Rectangle(xx*50,yy*50,50,50),color);
		}
		
		var b = new openfl.display.Bitmap(bmp);
		marker = new Sprite();
		marker.graphics.beginFill(0xffffff);
		marker.graphics.drawRect(10,10,30,30);
		marker.graphics.endFill();
		marker.graphics.beginFill(0x000000);
		marker.graphics.drawRect(15,15,20,20);
		marker.graphics.endFill();
		b.x=200;
		this.addChild(b);
		this.addChild(marker);

		redraw();
		stage.addEventListener(openfl.events.KeyboardEvent.KEY_DOWN,onKeyDown);
		this.addEventListener(openfl.events.Event.ENTER_FRAME,loop);
	}

	public function onKeyDown(_){
		this.scaleX=this.scaleY=1;
		waitFrames = 180;
		redraw();
	}
	
	var scaleDiff:Float=0.03;
	public function loop(_){
		if(waitFrames>0){
			waitFrames--;
			return;
		}
		this.scaleX+=scaleDiff;
		this.scaleY+=scaleDiff;
		if(this.scaleX<0.3) scaleDiff = 0.03;
		if(this.scaleX>3) scaleDiff = -0.03;
	}

	public function redraw(){
		uvs = new openfl.Vector<Float>();
		var xSection = Std.random(6);
		var ySection = Std.random(6);
		trace(xSection);
		trace(ySection);
		for (i in 0...2) {
			uvs.push((50*xSection+10)/300); uvs.push((50*ySection+10)/300);
			uvs.push((50*xSection+40)/300);	uvs.push((50*ySection+10)/300);
			uvs.push((50*xSection+10)/300);	uvs.push((50*ySection+40)/300);
		}

		marker.x=50*xSection;
		marker.y=50*ySection;
		marker.x+=200;
		this.graphics.clear();
		this.graphics.beginBitmapFill(bmp);
		this.graphics.drawTriangles(triangles, null, uvs);
		this.graphics.endFill();
	}
	
}