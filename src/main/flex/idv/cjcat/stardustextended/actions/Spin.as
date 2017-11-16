﻿package idv.cjcat.stardustextended.actions
{

import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Causes a particle's rotation to change according to it's omega value (angular velocity).
 *
 * <p>
 * Default priority = -4;
 * </p>
 */
public class Spin extends Action
{

    /**
     * The multiplier of spinning, 1 by default.
     *
     * <p>
     * For instance, a multiplier value of 2 causes a particle to spin twice as fast as normal.
     * </p>
     */
    public var multiplier : Number;
    private var factor : Number;

    public function Spin(_multiplier : Number = 1)
    {
        priority = -4;
        multiplier = _multiplier;
    }

    override public function preUpdate(emitter : Emitter, time : Number) : void
    {
        factor = time * multiplier;
    }

    override public function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        particle.rotation += particle.omega * factor;
    }

}
}