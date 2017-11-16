﻿package idv.cjcat.stardustextended.actions
{
import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.fields.Field;
import idv.cjcat.stardustextended.fields.UniformField;
import idv.cjcat.stardustextended.geom.MotionData2D;
import idv.cjcat.stardustextended.geom.MotionData2DPool;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Applies an instant acceleration to particles based on the <code>field</code> property.
 *
 * @see idv.cjcat.stardustextended.fields.Field
 */
public class Impulse extends Action
{

    private var _field : Field;

    public function Impulse(field : Field = null)
    {
        this.field = field;
        _discharged = true;
    }

    public function get field() : Field
    {
        return _field;
    }

    public function set field(value : Field) : void
    {
        if (!value) value = new UniformField(0, 0);
        _field = value;
    }

    private var _discharged : Boolean;

    /**
     * Applies an instant acceleration to particles based on the <code>field</code> property.
     */
    public function impulse() : void
    {
        _discharged = false;
    }

    override public function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        if (_discharged) return;
        var md2D : MotionData2D = field.getMotionData2D(particle);
        particle.vx += md2D.x * timeDelta;
        particle.vy += md2D.y * timeDelta;
        MotionData2DPool.recycle(md2D);
    }

    override public function postUpdate(emitter : Emitter, time : Number) : void
    {
        _discharged = true;
    }

}
}