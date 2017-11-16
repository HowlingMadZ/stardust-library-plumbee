﻿package idv.cjcat.stardustextended.actions
{

import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.fields.Field;
import idv.cjcat.stardustextended.fields.UniformField;
import idv.cjcat.stardustextended.geom.MotionData2D;
import idv.cjcat.stardustextended.geom.MotionData2DPool;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Alters a particle's velocity based on a vector field.
 *
 * <p>
 * The returned value of a field is a <code>MotionData2D</code> object, which is a 2D value class.
 * The particle's velocity X and Y components are set to the <code>MotionData2D</code> object's <code>x</code> and <code>y</code> properties, respectively.
 * </p>
 *
 * <p>
 * Default priority = -2;
 * </p>
 */
public class VelocityField extends Action implements IFieldContainer
{

    protected var field : Field;

    public function VelocityField(_field : Field = null)
    {
        priority = -2;
        if (field) {
            field = _field;
        }
        else {
            field = new UniformField(100, 100);
        }
    }

    public function get fields() : Vector.<Field>
    {
        if (field) {
            return new <Field>[field];
        }
        return new Vector.<Field>();
    }

    public function set fields(value : Vector.<Field>) : void
    {
        if (value && value.length > 0) {
            field = value[0];
        }
        else {
            field = null;
        }
    }

    override public function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        if (!field) return;
        var md2D : MotionData2D = field.getMotionData2D(particle);
        particle.vx = md2D.x;
        particle.vy = md2D.y;
        MotionData2DPool.recycle(md2D);
    }

}
}