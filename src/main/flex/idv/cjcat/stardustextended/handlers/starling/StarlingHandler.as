package idv.cjcat.stardustextended.handlers.starling
{

import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.handlers.ISpriteSheetHandler;
import idv.cjcat.stardustextended.handlers.ParticleHandler;
import idv.cjcat.stardustextended.particles.Particle;

import starling.display.BlendMode;
import starling.display.DisplayObjectContainer;
import starling.textures.SubTexture;
import starling.textures.TextureSmoothing;

public class StarlingHandler extends ParticleHandler implements ISpriteSheetHandler
{

    private var _blendMode : String = BlendMode.NORMAL;
    private var _spriteSheetAnimationSpeed : uint = 1;
    private var _smoothing : String = TextureSmoothing.NONE;
    private var _isSpriteSheet : Boolean;
    private var _premultiplyAlpha : Boolean = true;
    private var _spriteSheetStartAtRandomFrame : Boolean;
    private var _totalFrames : uint;
    private var _textures : Vector.<SubTexture>;
    private var _renderer : StardustStarlingRenderer;
    private var timeSinceLastStep : Number;

    public function StarlingHandler() : void
    {
        timeSinceLastStep = 0;
    }

    override public function reset() : void
    {
        timeSinceLastStep = 0;
        _renderer.advanceTime(new Vector.<Particle>);
    }

    public function set container(container : DisplayObjectContainer) : void
    {
        createRendererIfNeeded();
        container.addChild(_renderer);
    }

    private function createRendererIfNeeded() : void
    {
        if (_renderer == null) {
            _renderer = new StardustStarlingRenderer();
            _renderer.blendMode = _blendMode;
            _renderer.texSmoothing = _smoothing;
            _renderer.premultiplyAlpha = _premultiplyAlpha;
        }
    }

    override public function stepEnd(emitter : Emitter, particles : Vector.<Particle>, time : Number) : void
    {
        if (_isSpriteSheet && _spriteSheetAnimationSpeed > 0) {
            timeSinceLastStep = timeSinceLastStep + time;
            if (timeSinceLastStep > 1/_spriteSheetAnimationSpeed)
            {
                var stepSize : uint = Math.floor(timeSinceLastStep * _spriteSheetAnimationSpeed);
                var mNumParticles : uint = particles.length;
                for (var i : int = 0; i < mNumParticles; ++i) {
                    var particle : Particle = particles[i];
                    var currFrame : int = particle.currentAnimationFrame;
                    currFrame = currFrame + stepSize;
                    if (currFrame >= _totalFrames) {
                        currFrame = 0;
                    }
                    particle.currentAnimationFrame = currFrame;
                }
                timeSinceLastStep = 0;
            }
        }
        _renderer.advanceTime(particles);
    }

    override public function particleAdded(particle : Particle) : void
    {
        if (_isSpriteSheet) {
            var currFrame : uint = 0;
            if (_spriteSheetStartAtRandomFrame) {
                currFrame = Math.random() * _totalFrames;
            }
            particle.currentAnimationFrame = currFrame;
        }
        else {
            particle.currentAnimationFrame = 0;
        }
    }

    [Transient]
    public function get renderer() : StardustStarlingRenderer
    {
        return _renderer;
    }

    public function set spriteSheetAnimationSpeed(spriteSheetAnimationSpeed : uint) : void
    {
        _spriteSheetAnimationSpeed = spriteSheetAnimationSpeed;
        if (_textures) {
            setTextures(_textures);
        }
    }

    public function get spriteSheetAnimationSpeed() : uint
    {
        return _spriteSheetAnimationSpeed;
    }

    public function set spriteSheetStartAtRandomFrame(spriteSheetStartAtRandomFrame : Boolean) : void
    {
        _spriteSheetStartAtRandomFrame = spriteSheetStartAtRandomFrame;
    }

    public function get spriteSheetStartAtRandomFrame() : Boolean
    {
        return _spriteSheetStartAtRandomFrame;
    }

    [Transient]
    public function get isSpriteSheet() : Boolean
    {
        return _isSpriteSheet;
    }

    public function get smoothing() : Boolean
    {
        return _smoothing != TextureSmoothing.NONE;
    }

    public function set smoothing(value : Boolean) : void
    {
        if (value == true) {
            _smoothing = TextureSmoothing.BILINEAR;
        }
        else {
            _smoothing = TextureSmoothing.NONE;
        }
        createRendererIfNeeded();
        _renderer.texSmoothing = _smoothing;
    }

    public function get premultiplyAlpha() : Boolean
    {
        return _premultiplyAlpha;
    }

    public function set premultiplyAlpha(value : Boolean) : void
    {
        _premultiplyAlpha = value;
        createRendererIfNeeded();
        _renderer.premultiplyAlpha = value;
    }

    public function set blendMode(blendMode : String) : void
    {
        _blendMode = blendMode;
        createRendererIfNeeded();
        _renderer.blendMode = blendMode;
    }

    public function get blendMode() : String
    {
        return _blendMode;
    }

    /** Sets the textures directly. Stardust can batch the simulations resulting multiple simulations using
     *  just one draw call. To have this working the following must be met:
     *  - The textures must come from the same sprite sheet. (= they must have the same base texture)
     *  - The simulations must have the same render target, smoothing, blendMode, same filter
     *    and the same premultiplyAlpha values.
     **/
    public function setTextures(textures : Vector.<SubTexture>) : void
    {
        if (textures == null || textures.length == 0) {
            throw new ArgumentError("the textures parameter cannot be null and needs to hold at least 1 element");
        }
        createRendererIfNeeded();
        _isSpriteSheet = textures.length > 1;
        _textures = textures;
        var frames : Vector.<Frame> = new <Frame>[];
        for each (var texture : SubTexture in textures) {
            if (texture.root != textures[0].root) {
                throw new Error("The texture " + texture + " does not share the same base root with others");
            }
            // TODO use the transformationMatrix
            var frame : Frame = new Frame(
                    texture.region.x / texture.root.width,
                    texture.region.y / texture.root.height,
                    (texture.region.x + texture.region.width) / texture.root.width,
                    (texture.region.y + texture.region.height) / texture.root.height,
                    texture.width * 0.5,
                    texture.height * 0.5);
            frames.push(frame);
        }
        _totalFrames = frames.length;
        _renderer.setTextures(textures[0].root, frames);
    }

    [Transient]
    public function get textures() : Vector.<SubTexture>
    {
        return _textures;
    }

}
}
