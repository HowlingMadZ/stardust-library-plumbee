﻿package idv.cjcat.stardustextended
{

import idv.cjcat.stardustextended.actions.AccelerationArea;
import idv.cjcat.stardustextended.actions.Age;
import idv.cjcat.stardustextended.actions.ColorGradient;
import idv.cjcat.stardustextended.actions.DeathLife;
import idv.cjcat.stardustextended.actions.DeathArea;
import idv.cjcat.stardustextended.actions.Deflect;
import idv.cjcat.stardustextended.actions.Die;
import idv.cjcat.stardustextended.actions.Explode;
import idv.cjcat.stardustextended.actions.FollowWaypoints;
import idv.cjcat.stardustextended.actions.Gravity;
import idv.cjcat.stardustextended.actions.Impulse;
import idv.cjcat.stardustextended.actions.Move;
import idv.cjcat.stardustextended.actions.NormalDrift;
import idv.cjcat.stardustextended.actions.Oriented;
import idv.cjcat.stardustextended.actions.RandomDrift;
import idv.cjcat.stardustextended.actions.ScaleAnimated;
import idv.cjcat.stardustextended.actions.Spawn;
import idv.cjcat.stardustextended.actions.SpeedLimit;
import idv.cjcat.stardustextended.actions.Spin;
import idv.cjcat.stardustextended.actions.VelocityField;
import idv.cjcat.stardustextended.actions.areas.CircleArea;
import idv.cjcat.stardustextended.actions.areas.EverythingArea;
import idv.cjcat.stardustextended.actions.areas.RectArea;
import idv.cjcat.stardustextended.actions.areas.SectorArea;
import idv.cjcat.stardustextended.actions.triggers.DeathTrigger;
import idv.cjcat.stardustextended.actions.triggers.LifeTrigger;
import idv.cjcat.stardustextended.actions.waypoints.Waypoint;
import idv.cjcat.stardustextended.clocks.ImpulseClock;
import idv.cjcat.stardustextended.clocks.SteadyClock;
import idv.cjcat.stardustextended.deflectors.CircleDeflector;
import idv.cjcat.stardustextended.deflectors.LineDeflector;
import idv.cjcat.stardustextended.deflectors.WrappingBox;
import idv.cjcat.stardustextended.fields.BitmapField;
import idv.cjcat.stardustextended.fields.RadialField;
import idv.cjcat.stardustextended.fields.UniformField;
import idv.cjcat.stardustextended.initializers.Alpha;
import idv.cjcat.stardustextended.handlers.ParticleHandler;
import idv.cjcat.stardustextended.initializers.Life;
import idv.cjcat.stardustextended.initializers.Mass;
import idv.cjcat.stardustextended.initializers.Omega;
import idv.cjcat.stardustextended.initializers.PositionAnimated;
import idv.cjcat.stardustextended.initializers.Rotation;
import idv.cjcat.stardustextended.initializers.Scale;
import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.initializers.Velocity;
import idv.cjcat.stardustextended.math.UniformRandom;
import idv.cjcat.stardustextended.json.ClassPackage;
import idv.cjcat.stardustextended.zones.CircleContour;
import idv.cjcat.stardustextended.zones.CircleZone;
import idv.cjcat.stardustextended.zones.Line;
import idv.cjcat.stardustextended.zones.RectContour;
import idv.cjcat.stardustextended.zones.RectZone;
import idv.cjcat.stardustextended.zones.Sector;
import idv.cjcat.stardustextended.zones.SinglePoint;

/**
 * Packs together common classes used by the editor (except StarlingHandler).
 */
public class CommonClassPackage extends ClassPackage
{

    private static var _instance : CommonClassPackage;

    public static function getInstance() : CommonClassPackage
    {
        if (!_instance) {
            _instance = new CommonClassPackage();
        }
        return _instance;
    }

    override protected final function populateClasses() : void
    {
        //actions
        classes.push(DeathLife);
        classes.push(Die);
        classes.push(RandomDrift);
        classes.push(DeathArea);
        classes.push(Deflect);
        classes.push(Explode);
        classes.push(Gravity);
        classes.push(Impulse);
        classes.push(Move);
        classes.push(NormalDrift);
        classes.push(Oriented);
        classes.push(Spawn);
        classes.push(SpeedLimit);
        classes.push(Spin);
        classes.push(VelocityField);
        classes.push(AccelerationArea);
        classes.push(ColorGradient);
        classes.push(ScaleAnimated);
        classes.push(FollowWaypoints);

        //action triggers
        classes.push(DeathTrigger);
        classes.push(LifeTrigger);

        //deflectors
        classes.push(LineDeflector);
        classes.push(CircleDeflector);
        classes.push(WrappingBox);

        //fields
        classes.push(BitmapField);
        classes.push(RadialField);
        classes.push(UniformField);

        //clocks
        classes.push(ImpulseClock);
        classes.push(SteadyClock);

        //emitters
        classes.push(Emitter);

        //initializers
        classes.push(Age);
        classes.push(Alpha);
        classes.push(Life);
        classes.push(Mass);
        classes.push(Scale);
        classes.push(Omega);
        classes.push(Rotation);
        classes.push(Velocity);
        classes.push(PositionAnimated);

        //randoms
        classes.push(UniformRandom);

        //zones
        classes.push(CircleContour);
        classes.push(CircleZone);
        classes.push(Line);
        classes.push(RectContour);
        classes.push(RectZone);
        classes.push(Sector);
        classes.push(SinglePoint);

        // areas
        classes.push(CircleArea);
        classes.push(EverythingArea);
        classes.push(RectArea);
        classes.push(SectorArea);

        classes.push(ParticleHandler);
        
        classes.push(Waypoint);
    }
}
}