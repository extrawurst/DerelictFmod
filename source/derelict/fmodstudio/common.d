/*
 * Copyright (c) 2016 Derelict Developers
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
module derelict.fmodstudio.common;

import derelict.util.system;

import derelict.fmod.common;

align(1):

/*
    FMOD Studio types.
*/

struct FMOD_STUDIO_SYSTEM {}
struct FMOD_STUDIO_EVENTDESCRIPTION {}
struct FMOD_STUDIO_EVENTINSTANCE {}
struct FMOD_STUDIO_CUEINSTANCE {}
struct FMOD_STUDIO_PARAMETERINSTANCE {}
struct FMOD_STUDIO_BUS {}
struct FMOD_STUDIO_VCA {}
struct FMOD_STUDIO_BANK {}
struct FMOD_STUDIO_COMMANDREPLAY {}


/*
[DEFINE]
[
    [NAME]
    FMOD_STUDIO_INITFLAGS

    [DESCRIPTION]
    Studio System initialization flags.
    Use them with Studio::System::initialize in the *studioflags* parameter to change various behavior.

    [REMARKS]

    [SEE_ALSO]
    Studio::System::initialize
]
*/
static immutable FMOD_STUDIO_INIT_NORMAL                     = 0x00000000;  /* Initialize normally. */
static immutable FMOD_STUDIO_INIT_LIVEUPDATE                 = 0x00000001;  /* Enable live update. */
static immutable FMOD_STUDIO_INIT_ALLOW_MISSING_PLUGINS      = 0x00000002;  /* Load banks even if they reference plugins that have not been loaded. */
static immutable FMOD_STUDIO_INIT_SYNCHRONOUS_UPDATE         = 0x00000004;  /* Disable asynchronous processing and perform all processing on the calling thread instead. */
static immutable FMOD_STUDIO_INIT_DEFERRED_CALLBACKS         = 0x00000008;  /* Defer timeline callbacks until the main update. See Studio::EventInstance::setCallback for more information. */
/* [DEFINE_END] */

alias FMOD_STUDIO_INITFLAGS = uint;

alias FMOD_STUDIO_LOADING_STATE = int;
enum
{
    FMOD_STUDIO_LOADING_STATE_UNLOADING,        /* Currently unloading. */
    FMOD_STUDIO_LOADING_STATE_UNLOADED,         /* Not loaded. */
    FMOD_STUDIO_LOADING_STATE_LOADING,          /* Loading in progress. */
    FMOD_STUDIO_LOADING_STATE_LOADED,           /* Loaded and ready to play. */
    FMOD_STUDIO_LOADING_STATE_ERROR,            /* Failed to load and is now in error state. */
    
    FMOD_STUDIO_LOADING_STATE_FORCEINT = 65536  /* Makes sure this enum is signed 32bit. */
}

alias FMOD_STUDIO_LOAD_MEMORY_MODE = int;
enum
{
    FMOD_STUDIO_LOAD_MEMORY,                    /* When passed to Studio::System::loadBankMemory, FMOD duplicates the memory into its own buffers. Your buffer can be freed after Studio::System::loadBankMemory returns. */
    FMOD_STUDIO_LOAD_MEMORY_POINT,              /* This differs from FMOD_STUDIO_LOAD_MEMORY in that FMOD uses the memory as is, without duplicating the memory into its own buffers. Cannot not be freed after load, only after calling Studio::Bank::unload. */
    
    FMOD_STUDIO_LOAD_MEMORY_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

alias FMOD_STUDIO_PARAMETER_TYPE = int;
enum
{
    FMOD_STUDIO_PARAMETER_GAME_CONTROLLED,                  /* Controlled via the API using Studio::ParameterInstance::setValue. */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_DISTANCE,               /* Distance between the event and the listener. */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_CONE_ANGLE,       /* Angle between the event's forward vector and the vector pointing from the event to the listener (0 to 180 degrees). */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_ORIENTATION,      /* Horizontal angle between the event's forward vector and listener's forward vector (-180 to 180 degrees). */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_DIRECTION,              /* Horizontal angle between the listener's forward vector and the vector pointing from the listener to the event (-180 to 180 degrees). */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_ELEVATION,              /* Angle between the listener's XZ plane and the vector pointing from the listener to the event (-90 to 90 degrees). */
    FMOD_STUDIO_PARAMETER_AUTOMATIC_LISTENER_ORIENTATION,   /* Horizontal angle between the listener's forward vector and the global positive Z axis (-180 to 180 degrees). */
    
    FMOD_STUDIO_PARAMETER_MAX,                              /* Maximum number of parameter types supported. */
    FMOD_STUDIO_PARAMETER_FORCEINT = 65536                  /* Makes sure this enum is signed 32bit */
}

struct FMOD_STUDIO_BANK_INFO
{
    int   size;                                 /* The size of this struct (for binary compatibility) */
    void *userData;                             /* User data to be passed to the file callbacks */
    int   userDataLength;                       /* If this is non-zero, userData will be copied internally */
    FMOD_FILE_OPEN_CALLBACK  openCallback;      /* Callback for opening this file. */
    FMOD_FILE_CLOSE_CALLBACK closeCallback;     /* Callback for closing this file. */
    FMOD_FILE_READ_CALLBACK  readCallback;      /* Callback for reading from this file. */
    FMOD_FILE_SEEK_CALLBACK  seekCallback;      /* Callback for seeking within this file. */
}

struct FMOD_STUDIO_PARAMETER_DESCRIPTION
{
    const(char)* name;                           /* Name of the parameter. */
    int index;                                  /* Index of parameter */
    float minimum;                              /* Minimum parameter value. */
    float maximum;                              /* Maximum parameter value. */
    float defaultValue;                         /* Default value */
    FMOD_STUDIO_PARAMETER_TYPE type;            /* Type of the parameter */
}

alias FMOD_STUDIO_USER_PROPERTY_TYPE = int;
enum
{
    FMOD_STUDIO_USER_PROPERTY_TYPE_INTEGER,         /* Integer property */
    FMOD_STUDIO_USER_PROPERTY_TYPE_BOOLEAN,         /* Boolean property */
    FMOD_STUDIO_USER_PROPERTY_TYPE_FLOAT,           /* Float property */
    FMOD_STUDIO_USER_PROPERTY_TYPE_STRING,          /* String property */
    
    FMOD_STUDIO_USER_PROPERTY_TYPE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

alias FMOD_STUDIO_EVENT_PROPERTY = int;
enum
{
    FMOD_STUDIO_EVENT_PROPERTY_CHANNELPRIORITY,     /* Priority to set on low-level channels created by this event instance (-1 to 256). */
    FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_DELAY,      /* Schedule delay to synchronized playback for multiple tracks in DSP clocks, or -1 for default. */
    FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_LOOKAHEAD,  /* Schedule look-ahead on the timeline in DSP clocks, or -1 for default. */
    FMOD_STUDIO_EVENT_PROPERTY_MINIMUM_DISTANCE,    /* Override the event's 3D minimum distance, or -1 for default. */
    FMOD_STUDIO_EVENT_PROPERTY_MAXIMUM_DISTANCE,    /* Override the event's 3D maximum distance, or -1 for default. */
    FMOD_STUDIO_EVENT_PROPERTY_MAX,                 /* Maximum number of event properties supported. */
    
    FMOD_STUDIO_EVENT_PROPERTY_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

struct FMOD_STUDIO_USER_PROPERTY
{
    const(char)* name;                           /* Name of the user property. */
    FMOD_STUDIO_USER_PROPERTY_TYPE type;        /* Type of the user property. Use this to select one of the following values. */
    
    union
    {
        int intValue;                           /* Value of the user property. Only valid when type is FMOD_STUDIO_USER_PROPERTY_TYPE_INTEGER. */
        FMOD_BOOL boolValue;                    /* Value of the user property. Only valid when type is FMOD_STUDIO_USER_PROPERTY_TYPE_BOOLEAN. */
        float floatValue;                       /* Value of the user property. Only valid when type is FMOD_STUDIO_USER_PROPERTY_TYPE_FLOAT. */
        const(char)* stringValue;                /* Value of the user property. Only valid when type is FMOD_STUDIO_USER_PROPERTY_TYPE_STRING. */
    }
}

static immutable FMOD_STUDIO_SYSTEM_CALLBACK_PREUPDATE       = 0x00000001;  /* Called at the start of the main Studio update.  For async mode this will be on its own thread. */
static immutable FMOD_STUDIO_SYSTEM_CALLBACK_POSTUPDATE      = 0x00000002;  /* Called at the end of the main Studio update.  For async mode this will be on its own thread. */
static immutable FMOD_STUDIO_SYSTEM_CALLBACK_BANK_UNLOAD     = 0x00000004;  /* Called when bank has just been unloaded, after all resources are freed. CommandData will be the bank handle.*/
static immutable FMOD_STUDIO_SYSTEM_CALLBACK_ALL             = 0xFFFFFFFF;  /* Pass this mask to Studio::System::setCallback to receive all callback types. */

alias FMOD_STUDIO_SYSTEM_CALLBACK_TYPE = uint;

static immutable FMOD_STUDIO_EVENT_CALLBACK_CREATED                  = 0x00000001;  /* Called when an instance is fully created. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_DESTROYED                = 0x00000002;  /* Called when an instance is just about to be destroyed. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_STARTING                 = 0x00000004;  /* Called when an instance is preparing to start. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_STARTED                  = 0x00000008;  /* Called when an instance starts playing. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_RESTARTED                = 0x00000010;  /* Called when an instance is restarted. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_STOPPED                  = 0x00000020;  /* Called when an instance stops. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_START_FAILED             = 0x00000040;  /* Called when an instance did not start, e.g. due to polyphony. Parameters = unused. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_CREATE_PROGRAMMER_SOUND  = 0x00000080;  /* Called when a programmer sound needs to be created in order to play a programmer instrument. Parameters = FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_DESTROY_PROGRAMMER_SOUND = 0x00000100;  /* Called when a programmer sound needs to be destroyed. Parameters = FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_CREATED           = 0x00000200;  /* Called when a DSP plugin instance has just been created. Parameters = FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_DESTROYED         = 0x00000400;  /* Called when a DSP plugin instance is about to be destroyed. Parameters = FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_MARKER          = 0x00000800;  /* Called when the timeline passes a named marker.  Parameters = FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_BEAT            = 0x00001000;  /* Called when the timeline hits a beat in a tempo section.  Parameters = FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES. */
static immutable FMOD_STUDIO_EVENT_CALLBACK_ALL                      = 0xFFFFFFFF;  /* Pass this mask to Studio::EventDescription::setCallback or Studio::EventInstance::setCallback to receive all callback types. */

alias FMOD_STUDIO_EVENT_CALLBACK_TYPE = uint;

struct FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES
{
    const(char)* name;                           /* The name of the programmer instrument (set in FMOD Studio). */
    FMOD_SOUND *sound;                          /* The programmer-created sound. This should be filled in by the create callback, and cleaned up by the destroy callback. This can be cast to/from FMOD::Sound* type. */
    int subsoundIndex;                          /* The index of the subsound to use, or -1 if the provided sound should be used directly. Defaults to -1. */
}

struct FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES
{
    const(char)* name;                           /* The name of the plugin effect or sound (set in FMOD Studio). */
    FMOD_DSP *dsp;                              /* The DSP plugin instance. This can be cast to FMOD::DSP* type. */
}

struct FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES
{
    const(char)* name;                           /* The marker name */
    int position;                               /* The position of the marker on the timeline in milliseconds. */
}

struct FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES
{
    int bar;                                    /* The bar number (starting from 1). */
    int beat;                                   /* The beat number within the bar (starting from 1). */
    int position;                               /* The position of the beat on the timeline in milliseconds. */
    float tempo;                                /* The current tempo in beats per minute. */
    int timeSignatureUpper;                     /* The current time signature upper number (beats per bar). */
    int timeSignatureLower;                     /* The current time signature lower number (beat unit). */
}

alias FMOD_STUDIO_PLAYBACK_STATE = int;
enum
{
    FMOD_STUDIO_PLAYBACK_PLAYING,               /* Currently playing. */
    FMOD_STUDIO_PLAYBACK_SUSTAINING,            /* The timeline cursor is paused on a sustain point. */
    FMOD_STUDIO_PLAYBACK_STOPPED,               /* Not playing. */
    FMOD_STUDIO_PLAYBACK_STARTING,              /* Start has been called but the instance is not fully started yet. */
    FMOD_STUDIO_PLAYBACK_STOPPING,              /* Stop has been called but the instance is not fully stopped yet. */
    
    FMOD_STUDIO_PLAYBACK_FORCEINT = 65536       /* Makes sure this enum is signed 32bit. */
}

alias FMOD_STUDIO_STOP_MODE = int;
enum
{
    FMOD_STUDIO_STOP_ALLOWFADEOUT,              /* Allows AHDSR modulators to complete their release, and DSP effect tails to play out. */
    FMOD_STUDIO_STOP_IMMEDIATE,                 /* Stops the event instance immediately. */
    
    FMOD_STUDIO_STOP_FORCEINT = 65536           /* Makes sure this enum is signed 32bit. */
}

static immutable FMOD_STUDIO_LOAD_BANK_NORMAL                = 0x00000000;         /* Standard behaviour. */
static immutable FMOD_STUDIO_LOAD_BANK_NONBLOCKING           = 0x00000001;         /* Bank loading occurs asynchronously rather than occurring immediately. */
static immutable FMOD_STUDIO_LOAD_BANK_DECOMPRESS_SAMPLES    = 0x00000002;         /* Force samples to decompress into memory when they are loaded, rather than staying compressed. */

alias FMOD_STUDIO_LOAD_BANK_FLAGS = uint;

struct FMOD_STUDIO_ADVANCEDSETTINGS
{
    int                 cbSize;                     /* [w]   Size of this structure.  Use sizeof(FMOD_STUDIO_ADVANCEDSETTINGS)  NOTE: This must be set before calling Studio::System::getAdvancedSettings or Studio::System::setAdvancedSettings! */
    uint        commandQueueSize;           /* [r/w] Optional. Specify 0 to ignore. Specify the command queue size for studio async processing.  Default 32kB. */
    uint        handleInitialSize;          /* [r/w] Optional. Specify 0 to ignore. Specify the initial size to allocate for handles.  Memory for handles will grow as needed in pages. Default 8192 * sizeof(void*) */
    int                 studioUpdatePeriod;         /* [r/w] Optional. Specify 0 to ignore. Specify the update period of Studio when in async mode, in milliseconds.  Will be quantised to the nearest multiple of mixer duration.  Default is 20ms. */
    int                 idleSampleDataPoolSize;       /* [r/w] Optional. Specify 0 to ignore. Specify the amount of sample data to keep in memory when no longer used, to avoid repeated disk IO.  Use -1 to disable.  Default is 256kB. */
}

struct FMOD_STUDIO_CPU_USAGE
{
    float               dspUsage;                           /* Returns the % CPU time taken by DSP processing on the low level mixer thread. */
    float               streamUsage;                        /* Returns the % CPU time taken by stream processing on the low level stream thread. */
    float               geometryUsage;                      /* Returns the % CPU time taken by geometry processing on the low level geometry thread. */
    float               updateUsage;                        /* Returns the % CPU time taken by low level update, called as part of the studio update. */
    float               studioUsage;                        /* Returns the % CPU time taken by studio update, called from the studio thread. Does not include low level update time. */
}

struct FMOD_STUDIO_BUFFER_INFO
{
    int                 currentUsage;                       /* Current buffer usage in bytes. */
    int                 peakUsage;                          /* Peak buffer usage in bytes. */
    int                 capacity;                           /* Buffer capacity in bytes. */
    int                 stallCount;                         /* Cumulative number of stalls due to buffer overflow. */
    float               stallTime;                          /* Cumulative amount of time stalled due to buffer overflow, in seconds. */
}

struct FMOD_STUDIO_BUFFER_USAGE
{
    FMOD_STUDIO_BUFFER_INFO studioCommandQueue;             /* Information for the Studio Async Command buffer, controlled by FMOD_STUDIO_ADVANCEDSETTINGS commandQueueSize. */
    FMOD_STUDIO_BUFFER_INFO studioHandle;                   /* Information for the Studio handle table, controlled by FMOD_STUDIO_ADVANCEDSETTINGS handleInitialSize. */
}

struct FMOD_STUDIO_SOUND_INFO
{
    const(char)* name_or_data;           /* The filename or memory buffer that contains the sound. */
    FMOD_MODE mode;                     /* Mode flags required for loading the sound. */
    FMOD_CREATESOUNDEXINFO exinfo;      /* Extra information required for loading the sound. */
    int subsoundIndex;                  /* Subsound index for loading the sound. */
}

static immutable FMOD_STUDIO_COMMANDCAPTURE_NORMAL                      = 0x00000000;       /* Standard behaviour. */
static immutable FMOD_STUDIO_COMMANDCAPTURE_FILEFLUSH                   = 0x00000001;       /* Call file flush on every command. */
static immutable FMOD_STUDIO_COMMANDCAPTURE_SKIP_INITIAL_STATE          = 0x00000002;       /* Normally the initial state of banks and instances is captured, unless this flag is set. */

alias FMOD_STUDIO_COMMANDCAPTURE_FLAGS = uint;

static immutable FMOD_STUDIO_COMMANDREPLAY_NORMAL               = 0x00000000;       /* Standard behaviour. */
static immutable FMOD_STUDIO_COMMANDREPLAY_SKIP_CLEANUP         = 0x00000001;       /* Normally the playback will release any created resources when it stops, unless this flag is set. */

alias FMOD_STUDIO_COMMANDREPLAY_FLAGS = uint;

alias FMOD_STUDIO_INSTANCETYPE = int;
enum
{
    FMOD_STUDIO_INSTANCETYPE_NONE,
    FMOD_STUDIO_INSTANCETYPE_SYSTEM,
    FMOD_STUDIO_INSTANCETYPE_EVENTDESCRIPTION,
    FMOD_STUDIO_INSTANCETYPE_EVENTINSTANCE,
    FMOD_STUDIO_INSTANCETYPE_PARAMETERINSTANCE,
    FMOD_STUDIO_INSTANCETYPE_BUS,
    FMOD_STUDIO_INSTANCETYPE_VCA,
    FMOD_STUDIO_INSTANCETYPE_BANK,
    FMOD_STUDIO_INSTANCETYPE_COMMANDREPLAY,
    
    FMOD_STUDIO_INSTANCETYPE_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

struct FMOD_STUDIO_COMMAND_INFO
{
    const(char)* commandName;                                    /* The full name of the API function for this command. */
    int parentCommandIndex;                                     /* For commands that operate on an instance, this is the command that created the instance. */
    int frameNumber;                                            /* The frame the command belongs to. */
    float frameTime;                                            /* The playback time at which this command will be executed. */
    FMOD_STUDIO_INSTANCETYPE instanceType;                      /* The type of object that this command uses as an instance. */
    FMOD_STUDIO_INSTANCETYPE outputType;                        /* The type of object that this command outputs, if any. */
    uint instanceHandle;                                /* The original handle value of the instance.  This will no longer correspond to any actual object in playback. */
    uint outputHandle;                                  /* The original handle value of the command output.  This will no longer correspond to any actual object in playback. */
}

alias FMOD_STUDIO_SYSTEM_CALLBACK = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_SYSTEM_CALLBACK_TYPE type, void *commanddata, void *userdata);
alias FMOD_STUDIO_EVENT_CALLBACK = FMOD_RESULT function(FMOD_STUDIO_EVENT_CALLBACK_TYPE type, FMOD_STUDIO_EVENTINSTANCE *event, void *parameters);
alias FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex, float currentTime, void *userdata);
alias FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex, const FMOD_GUID *bankGuid, const char *bankFilename, FMOD_STUDIO_LOAD_BANK_FLAGS flags, FMOD_STUDIO_BANK **bank, void *userdata);
alias FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex, FMOD_STUDIO_EVENTDESCRIPTION *eventDescription, FMOD_STUDIO_EVENTINSTANCE **instance, void *userdata);
