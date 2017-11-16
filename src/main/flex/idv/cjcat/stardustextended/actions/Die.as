﻿package idv.cjcat.stardustextended.actions
{
import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Instantly marks a particle as dead.
 *
 * <p>
 * This action should be used with action triggers.
 * If this action is directly added to an emitter, all particles will be marked dead upon birth.
 * </p>
 */
public class Die extends Action
{

    override public final function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        particle.isDead = true;
    }
}
}