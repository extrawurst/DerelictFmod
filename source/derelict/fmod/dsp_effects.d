/*
 * Copyright (c) 2015 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictFmod', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.fmod.dsp_effects;

alias FMOD_DSP_TYPE = int;
enum
{
    FMOD_DSP_TYPE_UNKNOWN,            /* This unit was created via a non FMOD plugin so has an unknown purpose. */
    FMOD_DSP_TYPE_MIXER,              /* This unit does nothing but take inputs and mix them together then feed the result to the soundcard unit. */
    FMOD_DSP_TYPE_OSCILLATOR,         /* This unit generates sine/square/saw/triangle or noise tones. */
    FMOD_DSP_TYPE_LOWPASS,            /* This unit filters sound using a high quality, resonant lowpass filter algorithm but consumes more CPU time. */
    FMOD_DSP_TYPE_ITLOWPASS,          /* This unit filters sound using a resonant lowpass filter algorithm that is used in Impulse Tracker, but with limited cutoff range (0 to 8060hz). */
    FMOD_DSP_TYPE_HIGHPASS,           /* This unit filters sound using a resonant highpass filter algorithm. */
    FMOD_DSP_TYPE_ECHO,               /* This unit produces an echo on the sound and fades out at the desired rate. */
    FMOD_DSP_TYPE_FADER,              /* This unit pans and scales the volume of a unit. */
    FMOD_DSP_TYPE_FLANGE,             /* This unit produces a flange effect on the sound. */
    FMOD_DSP_TYPE_DISTORTION,         /* This unit distorts the sound. */
    FMOD_DSP_TYPE_NORMALIZE,          /* This unit normalizes or amplifies the sound to a certain level. */
    FMOD_DSP_TYPE_LIMITER,            /* This unit limits the sound to a certain level.*/
    FMOD_DSP_TYPE_PARAMEQ,            /* This unit attenuates or amplifies a selected frequency range. */
    FMOD_DSP_TYPE_PITCHSHIFT,         /* This unit bends the pitch of a sound without changing the speed of playback. */
    FMOD_DSP_TYPE_CHORUS,             /* This unit produces a chorus effect on the sound. */
    FMOD_DSP_TYPE_VSTPLUGIN,          /* This unit allows the use of Steinberg VST plugins */
    FMOD_DSP_TYPE_WINAMPPLUGIN,       /* This unit allows the use of Nullsoft Winamp plugins */
    FMOD_DSP_TYPE_ITECHO,             /* This unit produces an echo on the sound and fades out at the desired rate as is used in Impulse Tracker. */
    FMOD_DSP_TYPE_COMPRESSOR,         /* This unit implements dynamic compression (linked multichannel, wideband) */
    FMOD_DSP_TYPE_SFXREVERB,          /* This unit implements SFX reverb */
    FMOD_DSP_TYPE_LOWPASS_SIMPLE,     /* This unit filters sound using a simple lowpass with no resonance, but has flexible cutoff and is fast. */
    FMOD_DSP_TYPE_DELAY,              /* This unit produces different delays on individual channels of the sound. */
    FMOD_DSP_TYPE_TREMOLO,            /* This unit produces a tremolo / chopper effect on the sound. */
    FMOD_DSP_TYPE_LADSPAPLUGIN,       /* Unsupported / Deprecated. */
    FMOD_DSP_TYPE_SEND,               /* This unit sends a copy of the signal to a return DSP anywhere in the DSP tree. */
    FMOD_DSP_TYPE_RETURN,             /* This unit receives signals from a number of send DSPs. */
    FMOD_DSP_TYPE_HIGHPASS_SIMPLE,    /* This unit filters sound using a simple highpass with no resonance, but has flexible cutoff and is fast. */
    FMOD_DSP_TYPE_PAN,                /* This unit pans the signal, possibly upmixing or downmixing as well. */
    FMOD_DSP_TYPE_THREE_EQ,           /* This unit is a three-band equalizer. */
    FMOD_DSP_TYPE_FFT,                /* This unit simply analyzes the signal and provides spectrum information back through getParameter. */
    FMOD_DSP_TYPE_LOUDNESS_METER,     /* This unit analyzes the loudness and true peak of the signal. */
    FMOD_DSP_TYPE_ENVELOPEFOLLOWER,   /* This unit tracks the envelope of the input/sidechain signal. Format to be publicly disclosed soon. */
    FMOD_DSP_TYPE_CONVOLUTIONREVERB,  /* This unit implements convolution reverb. */
    FMOD_DSP_TYPE_CHANNELMIX,         /* This unit provides per signal channel gain, and output channel mapping to allow 1 multichannel signal made up of many groups of signals to map to a single output signal. */
    FMOD_DSP_TYPE_TRANSCEIVER,        /* This unit 'sends' and 'receives' from a selection of up to 32 different slots.  It is like a send/return but it uses global slots rather than returns as the destination.  It also has other features.  Multiple transceivers can receive from a single channel, or multiple transceivers can send to a single channel, or a combination of both. */
    
    FMOD_DSP_TYPE_MAX,                /* Maximum number of pre-defined DSP types. */
    FMOD_DSP_TYPE_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

alias FMOD_DSP_OSCILLATOR = int;
enum
{
    FMOD_DSP_OSCILLATOR_TYPE,   /* (Type:int) - Waveform type.  0 = sine.  1 = square. 2 = sawup. 3 = sawdown. 4 = triangle. 5 = noise.  */
    FMOD_DSP_OSCILLATOR_RATE    /* (Type:float) - Frequency of the sinewave in hz.  1.0 to 22000.0.  Default = 220.0. */
}

alias FMOD_DSP_LOWPASS = int;
enum
{
    FMOD_DSP_LOWPASS_CUTOFF,    /* (Type:float) - Lowpass cutoff frequency in hz.   10.0 to 22000.0.  Default = 5000.0. */
    FMOD_DSP_LOWPASS_RESONANCE  /* (Type:float) - Lowpass resonance Q value. 1.0 to 10.0.  Default = 1.0. */
}

alias FMOD_DSP_ITLOWPASS = int;
enum
{
    FMOD_DSP_ITLOWPASS_CUTOFF,    /* (Type:float) - Lowpass cutoff frequency in hz.  1.0 to 22000.0.  Default = 5000.0/ */
    FMOD_DSP_ITLOWPASS_RESONANCE  /* (Type:float) - Lowpass resonance Q value.  0.0 to 127.0.  Default = 1.0. */
}

alias FMOD_DSP_HIGHPASS = int;
enum
{
    FMOD_DSP_HIGHPASS_CUTOFF,    /* (Type:float) - Highpass cutoff frequency in hz.  1.0 to output 22000.0.  Default = 5000.0. */
    FMOD_DSP_HIGHPASS_RESONANCE  /* (Type:float) - Highpass resonance Q value.  1.0 to 10.0.  Default = 1.0. */
}

alias FMOD_DSP_ECHO = int;
enum
{
    FMOD_DSP_ECHO_DELAY,       /* (Type:float) - Echo delay in ms.  10  to 5000.  Default = 500. */
    FMOD_DSP_ECHO_FEEDBACK,    /* (Type:float) - Echo decay per delay.  0 to 100.  100.0 = No decay, 0.0 = total decay (ie simple 1 line delay).  Default = 50.0. */
    FMOD_DSP_ECHO_DRYLEVEL,    /* (Type:float) - Original sound volume in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_ECHO_WETLEVEL     /* (Type:float) - Volume of echo signal to pass to output in dB.  -80.0 to 10.0.  Default = 0. */
}

alias FMOD_DSP_FLANGE = int;
enum
{
    FMOD_DSP_FLANGE_MIX,         /* (Type:float) - Percentage of wet signal in mix.  0 to 100. Default = 50. */
    FMOD_DSP_FLANGE_DEPTH,       /* (Type:float) - Flange depth (percentage of 40ms delay).  0.01 to 1.0.  Default = 1.0. */
    FMOD_DSP_FLANGE_RATE         /* (Type:float) - Flange speed in hz.  0.0 to 20.0.  Default = 0.1. */
}

alias FMOD_DSP_DISTORTION = int;
enum
{
    FMOD_DSP_DISTORTION_LEVEL    /* (Type:float) - Distortion value.  0.0 to 1.0.  Default = 0.5. */
}

alias FMOD_DSP_NORMALIZE = int;
enum
{
    FMOD_DSP_NORMALIZE_FADETIME,    /* (Type:float) - Time to ramp the silence to full in ms.  0.0 to 20000.0. Default = 5000.0. */
    FMOD_DSP_NORMALIZE_THRESHHOLD,  /* (Type:float) - Lower volume range threshold to ignore.  0.0 to 1.0.  Default = 0.1.  Raise higher to stop amplification of very quiet signals. */
    FMOD_DSP_NORMALIZE_MAXAMP       /* (Type:float) - Maximum amplification allowed.  1.0 to 100000.0.  Default = 20.0.  1.0 = no amplifaction, higher values allow more boost. */
}

alias FMOD_DSP_LIMITER = int;
enum
{
    FMOD_DSP_LIMITER_RELEASETIME,   /* (Type:float) - Time to ramp the silence to full in ms.  1.0 to 1000.0. Default = 10.0. */
    FMOD_DSP_LIMITER_CEILING,       /* (Type:float) - Maximum level of the output signal in dB.  -12.0 to 0.0.  Default = 0.0. */
    FMOD_DSP_LIMITER_MAXIMIZERGAIN, /* (Type:float) - Maximum amplification allowed in dB.  0.0 to 12.0.  Default = 0.0. 0.0 = no amplifaction, higher values allow more boost. */
    FMOD_DSP_LIMITER_MODE,          /* (Type:float) - Channel processing mode. 0 or 1. Default = 0. 0 = Independent (limiter per channel), 1 = Linked*/
}

alias FMOD_DSP_PARAMEQ = int;
enum
{
    FMOD_DSP_PARAMEQ_CENTER,     /* (Type:float) - Frequency center.  20.0 to 22000.0.  Default = 8000.0. */
    FMOD_DSP_PARAMEQ_BANDWIDTH,  /* (Type:float) - Octave range around the center frequency to filter.  0.2 to 5.0.  Default = 1.0. */
    FMOD_DSP_PARAMEQ_GAIN        /* (Type:float) - Frequency Gain in dB.  -30 to 30.  Default = 0.  */
}

alias FMOD_DSP_PITCHSHIFT = int;
enum
{
    FMOD_DSP_PITCHSHIFT_PITCH,       /* (Type:float) - Pitch value.  0.5 to 2.0.  Default = 1.0. 0.5 = one octave down, 2.0 = one octave up.  1.0 does not change the pitch. */
    FMOD_DSP_PITCHSHIFT_FFTSIZE,     /* (Type:float) - FFT window size.  256, 512, 1024, 2048, 4096.  Default = 1024.  Increase this to reduce 'smearing'.  This effect is a warbling sound similar to when an mp3 is encoded at very low bitrates. */
    FMOD_DSP_PITCHSHIFT_OVERLAP,     /* (Type:float) - Removed.  Do not use.  FMOD now uses 4 overlaps and cannot be changed. */
    FMOD_DSP_PITCHSHIFT_MAXCHANNELS  /* (Type:float) - Maximum channels supported.  0 to 16.  0 = same as fmod's default output polyphony, 1 = mono, 2 = stereo etc.  See remarks for more.  Default = 0.  It is suggested to leave at 0! */
}

alias FMOD_DSP_CHORUS = int;
enum
{
    FMOD_DSP_CHORUS_MIX,      /* (Type:float) - Volume of original signal to pass to output.  0.0 to 100.0. Default = 50.0. */
    FMOD_DSP_CHORUS_RATE,     /* (Type:float) - Chorus modulation rate in Hz.  0.0 to 20.0.  Default = 0.8 Hz. */
    FMOD_DSP_CHORUS_DEPTH,    /* (Type:float) - Chorus modulation depth.  0.0 to 100.0.  Default = 3.0. */
}

alias FMOD_DSP_ITECHO = int;
enum
{
    FMOD_DSP_ITECHO_WETDRYMIX,      /* (Type:float) - Ratio of wet (processed) signal to dry (unprocessed) signal. Must be in the range from 0.0 through 100.0 (all wet). The default value is 50. */
    FMOD_DSP_ITECHO_FEEDBACK,       /* (Type:float) - Percentage of output fed back into input, in the range from 0.0 through 100.0. The default value is 50. */
    FMOD_DSP_ITECHO_LEFTDELAY,      /* (Type:float) - Delay for left channel, in milliseconds, in the range from 1.0 through 2000.0. The default value is 500 ms. */
    FMOD_DSP_ITECHO_RIGHTDELAY,     /* (Type:float) - Delay for right channel, in milliseconds, in the range from 1.0 through 2000.0. The default value is 500 ms. */
    FMOD_DSP_ITECHO_PANDELAY        /* (Type:float) - Value that specifies whether to swap left and right delays with each successive echo. The default value is zero, meaning no swap. Possible values are defined as 0.0 (equivalent to FALSE) and 1.0 (equivalent to TRUE).  CURRENTLY NOT SUPPORTED. */
}

alias FMOD_DSP_COMPRESSOR = int;
enum
{
    FMOD_DSP_COMPRESSOR_THRESHOLD,		/* (Type:float) - Threshold level (dB) in the range from -80 through 0. The default value is 0. */ 
    FMOD_DSP_COMPRESSOR_RATIO,			/* (Type:float) - Compression Ratio (dB/dB) in the range from 1 to 50. The default value is 2.5. */ 
    FMOD_DSP_COMPRESSOR_ATTACK,			/* (Type:float) - Attack time (milliseconds), in the range from 0.1 through 1000. The default value is 20. */
    FMOD_DSP_COMPRESSOR_RELEASE,		/* (Type:float) - Release time (milliseconds), in the range from 10 through 5000. The default value is 100 */
    FMOD_DSP_COMPRESSOR_GAINMAKEUP,		/* (Type:float) - Make-up gain (dB) applied after limiting, in the range from 0 through 30. The default value is 0. */
    FMOD_DSP_COMPRESSOR_USESIDECHAIN,	/* (Type:bool)  - Whether to analyse the sidechain signal instead of the input signal. The default value is false */
	FMOD_DSP_COMPRESSOR_LINKED			/* (Type:bool)  - FALSE = Independent (compressor per channel), TRUE = Linked.  The default value is TRUE. */
}

alias FMOD_DSP_SFXREVERB = int;
enum
{
    FMOD_DSP_SFXREVERB_DECAYTIME,           /* (Type:float) - Decay Time       : Reverberation decay time at low-frequencies in milliseconds.  Ranges from 100.0 to 20000.0. Default is 1500. */
    FMOD_DSP_SFXREVERB_EARLYDELAY,          /* (Type:float) - Early Delay      : Delay time of first reflection in milliseconds.  Ranges from 0.0 to 300.0.  Default is 20. */
    FMOD_DSP_SFXREVERB_LATEDELAY,           /* (Type:float) - Reverb Delay     : Late reverberation delay time relative to first reflection in milliseconds.  Ranges from 0.0 to 100.0.  Default is 40. */
    FMOD_DSP_SFXREVERB_HFREFERENCE,         /* (Type:float) - HF Reference     : Reference frequency for high-frequency decay in Hz.  Ranges from 20.0 to 20000.0. Default is 5000. */
    FMOD_DSP_SFXREVERB_HFDECAYRATIO,        /* (Type:float) - Decay HF Ratio   : High-frequency decay time relative to decay time in percent.  Ranges from 10.0 to 100.0. Default is 50. */
    FMOD_DSP_SFXREVERB_DIFFUSION,           /* (Type:float) - Diffusion        : Reverberation diffusion (echo density) in percent.  Ranges from 0.0 to 100.0.  Default is 100. */
    FMOD_DSP_SFXREVERB_DENSITY,             /* (Type:float) - Density          : Reverberation density (modal density) in percent.  Ranges from 0.0 to 100.0.  Default is 100. */
    FMOD_DSP_SFXREVERB_LOWSHELFFREQUENCY,   /* (Type:float) - Low Shelf Frequency : Transition frequency of low-shelf filter in Hz.  Ranges from 20.0 to 1000.0. Default is 250. */
    FMOD_DSP_SFXREVERB_LOWSHELFGAIN,        /* (Type:float) - Low Shelf Gain   : Gain of low-shelf filter in dB.  Ranges from -36.0 to 12.0.  Default is 0. */
    FMOD_DSP_SFXREVERB_HIGHCUT,             /* (Type:float) - High Cut         : Cutoff frequency of low-pass filter in Hz.  Ranges from 20.0 to 20000.0. Default is 20000. */
    FMOD_DSP_SFXREVERB_EARLYLATEMIX,        /* (Type:float) - Early/Late Mix   : Blend ratio of late reverb to early reflections in percent.  Ranges from 0.0 to 100.0.  Default is 50. */
    FMOD_DSP_SFXREVERB_WETLEVEL,            /* (Type:float) - Wet Level        : Reverb signal level in dB.  Ranges from -80.0 to 20.0.  Default is -6. */
    FMOD_DSP_SFXREVERB_DRYLEVEL             /* (Type:float) - Dry Level        : Dry signal level in dB.  Ranges from -80.0 to 20.0.  Default is 0. */
}

alias FMOD_DSP_LOWPASS_SIMPLE = int;
enum
{
    FMOD_DSP_LOWPASS_SIMPLE_CUTOFF     /* (Type:float) - Lowpass cutoff frequency in hz.  10.0 to 22000.0.  Default = 5000.0 */
}

alias FMOD_DSP_DELAY = int;
enum
{
    FMOD_DSP_DELAY_CH0,      /* (Type:float) - Channel  #0 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH1,      /* (Type:float) - Channel  #1 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH2,      /* (Type:float) - Channel  #2 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH3,      /* (Type:float) - Channel  #3 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH4,      /* (Type:float) - Channel  #4 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH5,      /* (Type:float) - Channel  #5 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH6,      /* (Type:float) - Channel  #6 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH7,      /* (Type:float) - Channel  #7 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH8,      /* (Type:float) - Channel  #8 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH9,      /* (Type:float) - Channel  #9 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH10,     /* (Type:float) - Channel #10 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH11,     /* (Type:float) - Channel #11 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH12,     /* (Type:float) - Channel #12 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH13,     /* (Type:float) - Channel #13 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH14,     /* (Type:float) - Channel #14 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_CH15,     /* (Type:float) - Channel #15 Delay in ms.  0  to 10000.  Default = 0. */
    FMOD_DSP_DELAY_MAXDELAY  /* (Type:float) - Maximum delay in ms.      0  to 10000.  Default = 10. */
}

alias FMOD_DSP_TREMOLO = int;
enum
{
    FMOD_DSP_TREMOLO_FREQUENCY,     /* (Type:float) - LFO frequency in Hz.  0.1 to 20.  Default = 5. */
    FMOD_DSP_TREMOLO_DEPTH,         /* (Type:float) - Tremolo depth.  0 to 1.  Default = 1. */
    FMOD_DSP_TREMOLO_SHAPE,         /* (Type:float) - LFO shape morph between triangle and sine.  0 to 1.  Default = 0. */
    FMOD_DSP_TREMOLO_SKEW,          /* (Type:float) - Time-skewing of LFO cycle.  -1 to 1.  Default = 0. */
    FMOD_DSP_TREMOLO_DUTY,          /* (Type:float) - LFO on-time.  0 to 1.  Default = 0.5. */
    FMOD_DSP_TREMOLO_SQUARE,        /* (Type:float) - Flatness of the LFO shape.  0 to 1.  Default = 0. */
    FMOD_DSP_TREMOLO_PHASE,         /* (Type:float) - Instantaneous LFO phase.  0 to 1.  Default = 0. */
    FMOD_DSP_TREMOLO_SPREAD         /* (Type:float) - Rotation / auto-pan effect.  -1 to 1.  Default = 0. */
}

alias FMOD_DSP_SEND = int;
enum
{
    FMOD_DSP_SEND_RETURNID,     /* (Type:int) - ID of the Return DSP this send is connected to (integer values only). -1 indicates no connected Return DSP. Default = -1. */
    FMOD_DSP_SEND_LEVEL,        /* (Type:float) - Send level. 0.0 to 1.0. Default = 1.0 */
}

alias FMOD_DSP_RETURN = int;
enum
{
    FMOD_DSP_RETURN_ID,                /* (Type:int) - [r]   ID of this Return DSP. Read-only.  Default = -1*/
    FMOD_DSP_RETURN_INPUT_SPEAKER_MODE /* (Type:int) - [r/w] Input speaker mode of this return.  Default = FMOD_SPEAKERMODE_DEFAULT.*/
}

alias FMOD_DSP_HIGHPASS_SIMPLE = int;
enum
{
    FMOD_DSP_HIGHPASS_SIMPLE_CUTOFF     /* (Type:float) - Highpass cutoff frequency in hz.  10.0 to 22000.0.  Default = 1000.0 */
}

alias FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_TYPE = int;
enum
{
    FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_DISTRIBUTED,
    FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_DISCRETE
}

alias FMOD_DSP_PAN_MODE_TYPE = int;
enum
{
    FMOD_DSP_PAN_MODE_MONO,
    FMOD_DSP_PAN_MODE_STEREO,
    FMOD_DSP_PAN_MODE_SURROUND
}

alias FMOD_DSP_PAN_3D_ROLLOFF_TYPE = int;
enum
{
    FMOD_DSP_PAN_3D_ROLLOFF_LINEARSQUARED,
    FMOD_DSP_PAN_3D_ROLLOFF_LINEAR,
    FMOD_DSP_PAN_3D_ROLLOFF_INVERSE,
    FMOD_DSP_PAN_3D_ROLLOFF_INVERSETAPERED,
    FMOD_DSP_PAN_3D_ROLLOFF_CUSTOM
}

alias FMOD_DSP_PAN_3D_EXTENT_MODE_TYPE = int;
enum
{
    FMOD_DSP_PAN_3D_EXTENT_MODE_AUTO,
    FMOD_DSP_PAN_3D_EXTENT_MODE_USER,
    FMOD_DSP_PAN_3D_EXTENT_MODE_OFF
}

alias FMOD_DSP_PAN = int;
enum
{
    FMOD_DSP_PAN_MODE,                          /* (Type:int)   - Panner mode.               FMOD_DSP_PAN_MODE_MONO for mono down-mix, FMOD_DSP_PAN_MODE_STEREO for stereo panning or FMOD_DSP_PAN_MODE_SURROUND for surround panning.  Default = FMOD_DSP_PAN_MODE_SURROUND */
    FMOD_DSP_PAN_STEREO_POSITION,               /* (Type:float) - Stereo pan position.       -100.0 to 100.0.  Default = 0.0. */
    FMOD_DSP_PAN_SURROUND_DIRECTION,            /* (Type:float) - Surround pan direction.    -180.0 (degrees) to 180.0 (degrees).  Default = 0.0. */
    FMOD_DSP_PAN_SURROUND_EXTENT,               /* (Type:float) - Surround pan extent.       0.0 (degrees) to 360.0 (degrees).  Distance from center point of panning circle.  Default = 360.0. */
    FMOD_DSP_PAN_SURROUND_ROTATION,             /* (Type:float) - Surround pan rotation.     -180.0 (degrees) to 180.0 (degrees).  Default = 0.0. */
    FMOD_DSP_PAN_SURROUND_LFE_LEVEL,            /* (Type:float) - Surround pan LFE level.    -80.0 (db) to 20.0 (db).  Default = 0.0. */
    FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE,     /* (Type:int)   - Stereo-To-Surround Mode.   FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_DISTRIBUTED to FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_DISCRETE.  Default = FMOD_DSP_PAN_SURROUND_FROM_STEREO_MODE_DISCRETE. */
    FMOD_DSP_PAN_SURROUND_STEREO_SEPARATION,    /* (Type:float) - Stereo-To-Surround Stereo  Separation. -180.0 (degrees) to +180.0 (degrees).  Default = 60.0. */
    FMOD_DSP_PAN_SURROUND_STEREO_AXIS,          /* (Type:float) - Stereo-To-Surround Stereo  Axis. -180.0 (degrees) to +180.0 (degrees).  Default = 0.0. */
    FMOD_DSP_PAN_ENABLED_SURROUND_SPEAKERS,     /* (Type:int)   - Surround Speakers Enabled. 0 to 0xFFF.  Default = 0xFFF.  */
    FMOD_DSP_PAN_3D_POSITION,                   /* (Type:data)  - 3D Position.               data of type FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI */
    FMOD_DSP_PAN_3D_ROLLOFF,                    /* (Type:int)   - 3D Rolloff.                FMOD_DSP_PAN_3D_ROLLOFF_LINEARSQUARED to FMOD_DSP_PAN_3D_ROLLOFF_CUSTOM.  Default = FMOD_DSP_PAN_3D_ROLLOFF_LINEARSQUARED. */
    FMOD_DSP_PAN_3D_MIN_DISTANCE,               /* (Type:float) - 3D Min Distance.           0.0 to 1e+19f.  Default = 1.0. */
    FMOD_DSP_PAN_3D_MAX_DISTANCE,               /* (Type:float) - 3D Max Distance.           0.0 to 1e+19f.  Default = 20.0. */
    FMOD_DSP_PAN_3D_EXTENT_MODE,                /* (Type:int)   - 3D Extent Mode.            FMOD_DSP_PAN_3D_EXTENT_MODE_AUTO to FMOD_DSP_PAN_3D_EXTENT_MODE_OFF.  Default = FMOD_DSP_PAN_3D_EXTENT_MODE_AUTO. */
    FMOD_DSP_PAN_3D_SOUND_SIZE,                 /* (Type:float) - 3D Sound Size.             0.0 to 1e+19f.  Default = 0.0. */
    FMOD_DSP_PAN_3D_MIN_EXTENT,                 /* (Type:float) - 3D Min Extent.             0.0 (degrees) to 360.0 (degrees).  Default = 0.0. */
    FMOD_DSP_PAN_3D_PAN_BLEND,                  /* (Type:float) - 3D Pan Blend.              0.0 (fully 2D) to 1.0 (fully 3D).  Default = 0.0. */
    FMOD_DSP_PAN_LFE_UPMIX_ENABLED,             /* (Type:int)   - LFE Upmix Enabled.         0 to 1.  Default = 0. */
    FMOD_DSP_PAN_OVERALL_GAIN,                  /* (Type:data)  - Overall gain.              data of type FMOD_DSP_PARAMETER_DATA_TYPE_OVERALLGAIN */
    FMOD_DSP_PAN_SURROUND_SPEAKER_MODE          /* (Type:int)   - Surround speaker mode.     Target speaker mode for surround panning. */
}

alias FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_TYPE = int;
enum
{
    FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_12DB,
    FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_24DB,
    FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_48DB
}

alias FMOD_DSP_THREE_EQ = int;
enum
{
    FMOD_DSP_THREE_EQ_LOWGAIN,       /* (Type:float) - Low frequency gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_THREE_EQ_MIDGAIN,       /* (Type:float) - Mid frequency gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_THREE_EQ_HIGHGAIN,      /* (Type:float) - High frequency gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_THREE_EQ_LOWCROSSOVER,  /* (Type:float) - Low-to-mid crossover frequency in Hz.  10.0 to 22000.0.  Default = 400.0. */
    FMOD_DSP_THREE_EQ_HIGHCROSSOVER, /* (Type:float) - Mid-to-high crossover frequency in Hz.  10.0 to 22000.0.  Default = 4000.0. */
    FMOD_DSP_THREE_EQ_CROSSOVERSLOPE /* (Type:int)   - Crossover Slope.  0 = 12dB/Octave, 1 = 24dB/Octave, 2 = 48dB/Octave.  Default = 1 (24dB/Octave). */
}

alias FMOD_DSP_FFT_WINDOW = int;
enum
{
    FMOD_DSP_FFT_WINDOW_RECT,            /* w[n] = 1.0                                                                                            */
    FMOD_DSP_FFT_WINDOW_TRIANGLE,        /* w[n] = TRI(2n/N)                                                                                      */
    FMOD_DSP_FFT_WINDOW_HAMMING,         /* w[n] = 0.54 - (0.46 * COS(n/N) )                                                                      */
    FMOD_DSP_FFT_WINDOW_HANNING,         /* w[n] = 0.5 *  (1.0  - COS(n/N) )                                                                      */
    FMOD_DSP_FFT_WINDOW_BLACKMAN,        /* w[n] = 0.42 - (0.5  * COS(n/N) ) + (0.08 * COS(2.0 * n/N) )                                           */
    FMOD_DSP_FFT_WINDOW_BLACKMANHARRIS   /* w[n] = 0.35875 - (0.48829 * COS(1.0 * n/N)) + (0.14128 * COS(2.0 * n/N)) - (0.01168 * COS(3.0 * n/N)) */
}

alias FMOD_DSP_FFT = int;
enum
{
    FMOD_DSP_FFT_WINDOWSIZE,            /*  (Type:int)   - [r/w] Must be a power of 2 between 128 and 16384.  128, 256, 512, 1024, 2048, 4096, 8192, 16384 are accepted.  Default = 2048. */
    FMOD_DSP_FFT_WINDOWTYPE,            /*  (Type:int)   - [r/w] Refer to FMOD_DSP_FFT_WINDOW enumeration.  Default = FMOD_DSP_FFT_WINDOW_HAMMING. */
    FMOD_DSP_FFT_SPECTRUMDATA,          /*  (Type:data)  - [r]   Returns the current spectrum values between 0 and 1 for each 'fft bin'.  Cast data to FMOD_DSP_PARAMETER_DATA_TYPE_FFT.  Divide the niquist rate by the window size to get the hz value per entry. */
    FMOD_DSP_FFT_DOMINANT_FREQ          /*  (Type:float) - [r]   Returns the dominant frequencies for each channel. */
}

alias FMOD_DSP_ENVELOPEFOLLOWER = int;
enum
{
    FMOD_DSP_ENVELOPEFOLLOWER_ATTACK,      /* (Type:float) [r/w] - Attack time (milliseconds), in the range from 0.1 through 1000. The default value is 20. */
    FMOD_DSP_ENVELOPEFOLLOWER_RELEASE,     /* (Type:float) [r/w] - Release time (milliseconds), in the range from 10 through 5000. The default value is 100 */
    FMOD_DSP_ENVELOPEFOLLOWER_ENVELOPE,    /* (Type:float) [r]   - Current value of the envelope, in the range 0 to 1. Read-only. */
    FMOD_DSP_ENVELOPEFOLLOWER_USESIDECHAIN /* (Type:bool)  [r/w] - Whether to analyse the sidechain signal instead of the input signal. The default value is false */
}

alias FMOD_DSP_CONVOLUTION_REVERB = int;
enum
{
    FMOD_DSP_CONVOLUTION_REVERB_PARAM_IR,       /* (Type:data)  - [w]   16-bit reverb IR (short*) with an extra sample prepended to the start which specifies the number of channels. */
    FMOD_DSP_CONVOLUTION_REVERB_PARAM_WET,      /* (Type:float) - [r/w] Volume of echo signal to pass to output in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CONVOLUTION_REVERB_PARAM_DRY       /* (Type:float) - [r/w] Original sound volume in dB.  -80.0 to 10.0.  Default = 0. */
}

alias FMOD_DSP_CHANNELMIX_OUTPUT = int;
enum
{
    FMOD_DSP_CHANNELMIX_OUTPUT_DEFAULT,      /*  Output channel count = input channel count.  Mapping: See FMOD_SPEAKER enumeration. */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALLMONO,      /*  Output channel count = 1.  Mapping: Mono, Mono, Mono, Mono, Mono, Mono, ... (each channel all the way up to FMOD_MAX_CHANNEL_WIDTH channels are treated as if they were mono) */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALLSTEREO,    /*  Output channel count = 2.  Mapping: Left, Right, Left, Right, Left, Right, ... (each pair of channels is treated as stereo all the way up to FMOD_MAX_CHANNEL_WIDTH channels) */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALLQUAD,      /*  Output channel count = 4.  Mapping: Repeating pattern of Front Left, Front Right, Surround Left, Surround Right. */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALL5POINT1,   /*  Output channel count = 6.  Mapping: Repeating pattern of Front Left, Front Right, Center, LFE, Surround Left, Surround Right. */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALL7POINT1,   /*  Output channel count = 8.  Mapping: Repeating pattern of Front Left, Front Right, Center, LFE, Surround Left, Surround Right, Back Left, Back Right.  */
    FMOD_DSP_CHANNELMIX_OUTPUT_ALLLFE        /*  Output channel count = 6.  Mapping: Repeating pattern of LFE in a 5.1 output signal.  */
}

alias FMOD_DSP_CHANNELMIX = int;
enum
{
    FMOD_DSP_CHANNELMIX_OUTPUTGROUPING,     /* (Type:int)   - Refer to FMOD_DSP_CHANNELMIX_OUTPUT enumeration.  Default = FMOD_DSP_CHANNELGAIN_OUTPUT_DEFAULT.  See remarks. */
    FMOD_DSP_CHANNELMIX_GAIN_CH0,           /* (Type:float) - Channel  #0 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH1,           /* (Type:float) - Channel  #1 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH2,           /* (Type:float) - Channel  #2 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH3,           /* (Type:float) - Channel  #3 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH4,           /* (Type:float) - Channel  #4 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH5,           /* (Type:float) - Channel  #5 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH6,           /* (Type:float) - Channel  #6 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH7,           /* (Type:float) - Channel  #7 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH8,           /* (Type:float) - Channel  #8 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH9,           /* (Type:float) - Channel  #9 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH10,          /* (Type:float) - Channel #10 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH11,          /* (Type:float) - Channel #11 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH12,          /* (Type:float) - Channel #12 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH13,          /* (Type:float) - Channel #13 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH14,          /* (Type:float) - Channel #14 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH15,          /* (Type:float) - Channel #15 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH16,          /* (Type:float) - Channel #16 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH17,          /* (Type:float) - Channel #17 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH18,          /* (Type:float) - Channel #18 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH19,          /* (Type:float) - Channel #19 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH20,          /* (Type:float) - Channel #20 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH21,          /* (Type:float) - Channel #21 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH22,          /* (Type:float) - Channel #22 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH23,          /* (Type:float) - Channel #23 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH24,          /* (Type:float) - Channel #24 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH25,          /* (Type:float) - Channel #25 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH26,          /* (Type:float) - Channel #26 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH27,          /* (Type:float) - Channel #27 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH28,          /* (Type:float) - Channel #28 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH29,          /* (Type:float) - Channel #29 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH30,          /* (Type:float) - Channel #30 gain in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_CHANNELMIX_GAIN_CH31           /* (Type:float) - Channel #31 gain in dB.  -80.0 to 10.0.  Default = 0. */
}

alias FMOD_DSP_TRANSCEIVER_SPEAKERMODE = int;
enum
{
    FMOD_DSP_TRANSCEIVER_SPEAKERMODE_AUTO = -1,     /* A transmitter will use whatever signal channel count coming in to the transmitter, to determine which speaker mode is allocated for the transceiver channel. */
    FMOD_DSP_TRANSCEIVER_SPEAKERMODE_MONO = 0,      /* A transmitter will always downmix to a mono channel buffer. */
    FMOD_DSP_TRANSCEIVER_SPEAKERMODE_STEREO,        /* A transmitter will always upmix or downmix to a stereo channel buffer. */
    FMOD_DSP_TRANSCEIVER_SPEAKERMODE_SURROUND,      /* A transmitter will always upmix or downmix to a surround channel buffer.   Surround is the speaker mode of the system above stereo, so could be quad/surround/5.1/7.1. */
}

alias FMOD_DSP_TRANSCEIVER = int;
enum
{
    FMOD_DSP_TRANSCEIVER_TRANSMIT,            /* (Type:bool)  - [r/w] - FALSE = Transceiver is a 'receiver' (like a return) and accepts data from a channel.  TRUE = Transceiver is a 'transmitter' (like a send).  Default = FALSE. */
    FMOD_DSP_TRANSCEIVER_GAIN,                /* (Type:float) - [r/w] - Gain to receive or transmit at in dB.  -80.0 to 10.0.  Default = 0. */
    FMOD_DSP_TRANSCEIVER_CHANNEL,             /* (Type:int)   - [r/w] - Integer to select current global slot, shared by all Transceivers, that can be transmitted to or received from.  0 to 31.  Default = 0.*/
    FMOD_DSP_TRANSCEIVER_TRANSMITSPEAKERMODE  /* (Type:int)   - [r/w] - Speaker mode (transmitter mode only).  Specifies either 0 (Auto) Default = 0.*/
}
