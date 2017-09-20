/*
 * Copyright (c) 2017 Derelict Developers
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
module derelict.fmod.common;

import derelict.util.system;

import derelict.fmod.codec;
import derelict.fmod.dsp;

align(1):

static immutable FMOD_VERSION    = 0x00011000;

alias int                        FMOD_BOOL;
struct FMOD_SYSTEM         {};
struct FMOD_SOUND          {};
struct FMOD_CHANNELCONTROL {};
struct FMOD_CHANNEL        {};
struct FMOD_CHANNELGROUP   {};
struct FMOD_SOUNDGROUP     {};
struct FMOD_REVERB3D       {};
struct FMOD_DSP            {};
struct FMOD_DSPCONNECTION  {};
struct FMOD_POLYGON        {};
struct FMOD_GEOMETRY       {};
struct FMOD_SYNCPOINT      {};
alias uint          FMOD_MODE;
alias uint          FMOD_TIMEUNIT;
alias uint          FMOD_INITFLAGS;
alias uint          FMOD_DEBUG_FLAGS;
alias uint          FMOD_MEMORY_TYPE;
alias uint          FMOD_SYSTEM_CALLBACK_TYPE;
alias uint          FMOD_CHANNELMASK;
alias uint          FMOD_DRIVER_STATE;
alias uint          FMOD_PORT_TYPE;
alias ulong         FMOD_PORT_INDEX;

alias FMOD_RESULT = int;
enum
{
	FMOD_OK,                        /* No errors. */
	FMOD_ERR_BADCOMMAND,            /* Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound). */
	FMOD_ERR_CHANNEL_ALLOC,         /* Error trying to allocate a channel. */
	FMOD_ERR_CHANNEL_STOLEN,        /* The specified channel has been reused to play another sound. */
	FMOD_ERR_DMA,                   /* DMA Failure.  See debug output for more information. */
	FMOD_ERR_DSP_CONNECTION,        /* DSP connection error.  Connection possibly caused a cyclic dependency or connected dsps with incompatible buffer counts. */
	FMOD_ERR_DSP_DONTPROCESS,       /* DSP return code from a DSP process query callback.  Tells mixer not to call the process callback and therefore not consume CPU.  Use this to optimize the DSP graph. */
	FMOD_ERR_DSP_FORMAT,            /* DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format, or a matrix may have been set with the wrong size if the target unit has a specified channel map. */
	FMOD_ERR_DSP_INUSE,             /* DSP is already in the mixer's DSP network. It must be removed before being reinserted or released. */
	FMOD_ERR_DSP_NOTFOUND,          /* DSP connection error.  Couldn't find the DSP unit specified. */
	FMOD_ERR_DSP_RESERVED,          /* DSP operation error.  Cannot perform operation on this DSP as it is reserved by the system. */
	FMOD_ERR_DSP_SILENCE,           /* DSP return code from a DSP process query callback.  Tells mixer silence would be produced from read, so go idle and not consume CPU.  Use this to optimize the DSP graph. */
	FMOD_ERR_DSP_TYPE,              /* DSP operation cannot be performed on a DSP of this type. */
	FMOD_ERR_FILE_BAD,              /* Error loading file. */
	FMOD_ERR_FILE_COULDNOTSEEK,     /* Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format. */
	FMOD_ERR_FILE_DISKEJECTED,      /* Media was ejected while reading. */
	FMOD_ERR_FILE_EOF,              /* End of file unexpectedly reached while trying to read essential data (truncated?). */
	FMOD_ERR_FILE_ENDOFDATA,        /* End of current chunk reached while trying to read data. */
	FMOD_ERR_FILE_NOTFOUND,         /* File not found. */
	FMOD_ERR_FORMAT,                /* Unsupported file or audio format. */
	FMOD_ERR_HEADER_MISMATCH,       /* There is a version mismatch between the FMOD header and either the FMOD Studio library or the FMOD Low Level library. */
	FMOD_ERR_HTTP,                  /* A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere. */
	FMOD_ERR_HTTP_ACCESS,           /* The specified resource requires authentication or is forbidden. */
	FMOD_ERR_HTTP_PROXY_AUTH,       /* Proxy authentication is required to access the specified resource. */
	FMOD_ERR_HTTP_SERVER_ERROR,     /* A HTTP server error occurred. */
	FMOD_ERR_HTTP_TIMEOUT,          /* The HTTP request timed out. */
	FMOD_ERR_INITIALIZATION,        /* FMOD was not initialized correctly to support this function. */
	FMOD_ERR_INITIALIZED,           /* Cannot call this command after System::init. */
	FMOD_ERR_INTERNAL,              /* An error occurred that wasn't supposed to.  Contact support. */
	FMOD_ERR_INVALID_FLOAT,         /* Value passed in was a NaN, Inf or denormalized float. */
	FMOD_ERR_INVALID_HANDLE,        /* An invalid object handle was used. */
	FMOD_ERR_INVALID_PARAM,         /* An invalid parameter was passed to this function. */
	FMOD_ERR_INVALID_POSITION,      /* An invalid seek position was passed to this function. */
	FMOD_ERR_INVALID_SPEAKER,       /* An invalid speaker was passed to this function based on the current speaker mode. */
	FMOD_ERR_INVALID_SYNCPOINT,     /* The syncpoint did not come from this sound handle. */
	FMOD_ERR_INVALID_THREAD,        /* Tried to call a function on a thread that is not supported. */
	FMOD_ERR_INVALID_VECTOR,        /* The vectors passed in are not unit length, or perpendicular. */
	FMOD_ERR_MAXAUDIBLE,            /* Reached maximum audible playback count for this sound's soundgroup. */
	FMOD_ERR_MEMORY,                /* Not enough memory or resources. */
	FMOD_ERR_MEMORY_CANTPOINT,      /* Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_CREATECOMPRESSEDSAMPLE was used. */
	FMOD_ERR_NEEDS3D,               /* Tried to call a command on a 2d sound when the command was meant for 3d sound. */
	FMOD_ERR_NEEDSHARDWARE,         /* Tried to use a feature that requires hardware support. */
	FMOD_ERR_NET_CONNECT,           /* Couldn't connect to the specified host. */
	FMOD_ERR_NET_SOCKET_ERROR,      /* A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere. */
	FMOD_ERR_NET_URL,               /* The specified URL couldn't be resolved. */
	FMOD_ERR_NET_WOULD_BLOCK,       /* Operation on a non-blocking socket could not complete immediately. */
	FMOD_ERR_NOTREADY,              /* Operation could not be performed because specified sound/DSP connection is not ready. */
	FMOD_ERR_OUTPUT_ALLOCATED,      /* Error initializing output device, but more specifically, the output device is already in use and cannot be reused. */
	FMOD_ERR_OUTPUT_CREATEBUFFER,   /* Error creating hardware sound buffer. */
	FMOD_ERR_OUTPUT_DRIVERCALL,     /* A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted. */
	FMOD_ERR_OUTPUT_FORMAT,         /* Soundcard does not support the specified format. */
	FMOD_ERR_OUTPUT_INIT,           /* Error initializing output device. */
	FMOD_ERR_OUTPUT_NODRIVERS,      /* The output device has no drivers installed.  If pre-init, FMOD_OUTPUT_NOSOUND is selected as the output mode.  If post-init, the function just fails. */
	FMOD_ERR_PLUGIN,                /* An unspecified error has been returned from a plugin. */
	FMOD_ERR_PLUGIN_MISSING,        /* A requested output, dsp unit type or codec was not available. */
	FMOD_ERR_PLUGIN_RESOURCE,       /* A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback) */
	FMOD_ERR_PLUGIN_VERSION,        /* A plugin was built with an unsupported SDK version. */
	FMOD_ERR_RECORD,                /* An error occurred trying to initialize the recording device. */
	FMOD_ERR_REVERB_CHANNELGROUP,   /* Reverb properties cannot be set on this channel because a parent channelgroup owns the reverb connection. */
	FMOD_ERR_REVERB_INSTANCE,       /* Specified instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because it is an invalid instance number or the reverb doesn't exist. */
	FMOD_ERR_SUBSOUNDS,             /* The error occurred because the sound referenced contains subsounds when it shouldn't have, or it doesn't contain subsounds when it should have.  The operation may also not be able to be performed on a parent sound. */
	FMOD_ERR_SUBSOUND_ALLOCATED,    /* This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first. */
	FMOD_ERR_SUBSOUND_CANTMOVE,     /* Shared subsounds cannot be replaced or moved from their parent stream, such as when the parent stream is an FSB file. */
	FMOD_ERR_TAGNOTFOUND,           /* The specified tag could not be found or there are no tags. */
	FMOD_ERR_TOOMANYCHANNELS,       /* The sound created exceeds the allowable input channel count.  This can be increased using the 'maxinputchannels' parameter in System::setSoftwareFormat. */
	FMOD_ERR_TRUNCATED,             /* The retrieved string is too long to fit in the supplied buffer and has been truncated. */
	FMOD_ERR_UNIMPLEMENTED,         /* Something in FMOD hasn't been implemented when it should be! contact support! */
	FMOD_ERR_UNINITIALIZED,         /* This command failed because System::init or System::setDriver was not called. */
	FMOD_ERR_UNSUPPORTED,           /* A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified. */
	FMOD_ERR_VERSION,               /* The version number of this file format is not supported. */
	FMOD_ERR_EVENT_ALREADY_LOADED,  /* The specified bank has already been loaded. */
	FMOD_ERR_EVENT_LIVEUPDATE_BUSY, /* The live update connection failed due to the game already being connected. */
	FMOD_ERR_EVENT_LIVEUPDATE_MISMATCH, /* The live update connection failed due to the game data being out of sync with the tool. */
	FMOD_ERR_EVENT_LIVEUPDATE_TIMEOUT, /* The live update connection timed out. */
	FMOD_ERR_EVENT_NOTFOUND,        /* The requested event, bus or vca could not be found. */
	FMOD_ERR_STUDIO_UNINITIALIZED,  /* The Studio::System object is not yet initialized. */
	FMOD_ERR_STUDIO_NOT_LOADED,     /* The specified resource is not loaded, so it can't be unloaded. */
	
	FMOD_ERR_INVALID_STRING,        /* An invalid string was passed to this function. */
	FMOD_ERR_ALREADY_LOCKED,        /* The specified resource is already locked. */
	FMOD_ERR_NOT_LOCKED,            /* The specified resource is not locked, so it can't be unlocked. */
	FMOD_ERR_RECORD_DISCONNECTED,   /* The specified recording driver has been disconnected. */
	FMOD_ERR_TOOMANYSAMPLES,        /* The length provided exceed the allowable limit. */
	
	FMOD_RESULT_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

alias FMOD_CHANNELCONTROL_TYPE = int;
enum
{
	FMOD_CHANNELCONTROL_CHANNEL,
	FMOD_CHANNELCONTROL_CHANNELGROUP,
	
	FMOD_CHANNELCONTROL_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

///
struct FMOD_VECTOR
{
	float x;        /* X co-ordinate in 3D space. */
	float y;        /* Y co-ordinate in 3D space. */
	float z;        /* Z co-ordinate in 3D space. */
}

///
struct FMOD_3D_ATTRIBUTES
{
	FMOD_VECTOR position;
	FMOD_VECTOR velocity;
	FMOD_VECTOR forward;
	FMOD_VECTOR up;
}

///
struct FMOD_GUID
{
	uint   Data1;       /* Specifies the first 8 hexadecimal digits of the GUID */
	ushort Data2;       /* Specifies the first group of 4 hexadecimal digits.   */
	ushort Data3;       /* Specifies the second group of 4 hexadecimal digits.  */
	ubyte[8]  Data4;    /* Array of 8 bytes. The first 2 bytes contain the third group of 4 hexadecimal digits. The remaining 6 bytes contain the final 12 hexadecimal digits. */
}

alias FMOD_FILE_ASYNCDONE_FUNC = void function(FMOD_ASYNCREADINFO *info, FMOD_RESULT result);

///
struct FMOD_ASYNCREADINFO
{
	void                 *handle;    /* [r] The file handle that was filled out in the open callback. */
	uint          offset;    /* [r] Seek position, make sure you read from this file offset. */
	uint          sizebytes; /* [r] how many bytes requested for read. */
	int                   priority;  /* [r] 0 = low importance.  100 = extremely important (ie 'must read now or stuttering may occur') */
	
	void                 *userdata;  /* [r/w] User data pointer specific to this request.  Initially 0, can be ignored or set by the user.  Not related to the file's main userdata member.  */
	
	void                 *buffer;    /* [w] Buffer to read file data into. */
	uint          bytesread; /* [w] Fill this in before setting result code to tell FMOD how many bytes were read. */
	
	FMOD_FILE_ASYNCDONE_FUNC   done;      /* [r] FMOD file system wake up function.  Call this when user file read is finished.  Pass result of file read as a parameter. */
}

alias FMOD_OUTPUTTYPE = int;
enum
{
	FMOD_OUTPUTTYPE_AUTODETECT,      /* Picks the best output mode for the platform. This is the default. */
	
	FMOD_OUTPUTTYPE_UNKNOWN,         /* All - 3rd party plugin, unknown. This is for use with System::getOutput only. */
	FMOD_OUTPUTTYPE_NOSOUND,         /* All - Perform all mixing but discard the final output. */
	FMOD_OUTPUTTYPE_WAVWRITER,       /* All - Writes output to a .wav file. */
	FMOD_OUTPUTTYPE_NOSOUND_NRT,     /* All - Non-realtime version of FMOD_OUTPUTTYPE_NOSOUND. User can drive mixer with System::update at whatever rate they want. */
	FMOD_OUTPUTTYPE_WAVWRITER_NRT,   /* All - Non-realtime version of FMOD_OUTPUTTYPE_WAVWRITER. User can drive mixer with System::update at whatever rate they want. */
	
	FMOD_OUTPUTTYPE_DSOUND,          /* Win                  - Direct Sound.                        (Default on Windows XP and below) */
	FMOD_OUTPUTTYPE_WINMM,           /* Win                  - Windows Multimedia. */
	FMOD_OUTPUTTYPE_WASAPI,          /* Win/WinStore/XboxOne - Windows Audio Session API.           (Default on Windows Vista and above, Xbox One and Windows Store Applications) */
	FMOD_OUTPUTTYPE_ASIO,            /* Win                  - Low latency ASIO 2.0. */
	FMOD_OUTPUTTYPE_PULSEAUDIO,      /* Linux                - Pulse Audio.                         (Default on Linux if available) */
	FMOD_OUTPUTTYPE_ALSA,            /* Linux                - Advanced Linux Sound Architecture.   (Default on Linux if PulseAudio isn't available) */
	FMOD_OUTPUTTYPE_COREAUDIO,       /* Mac/iOS              - Core Audio.                          (Default on Mac and iOS) */
	FMOD_OUTPUTTYPE_XAUDIO,          /* Xbox 360             - XAudio.                              (Default on Xbox 360) */
	FMOD_OUTPUTTYPE_PS3,             /* PS3                  - Audio Out.                           (Default on PS3) */
	FMOD_OUTPUTTYPE_AUDIOTRACK,      /* Android              - Java Audio Track.                    (Default on Android 2.2 and below) */
	FMOD_OUTPUTTYPE_OPENSL,          /* Android              - OpenSL ES.                           (Default on Android 2.3 and above) */
	FMOD_OUTPUTTYPE_WIIU,            /* Wii U                - AX.                                  (Default on Wii U) */
	FMOD_OUTPUTTYPE_AUDIOOUT,        /* PS4/PSVita           - Audio Out.                           (Default on PS4 and PS Vita) */
	FMOD_OUTPUTTYPE_AUDIO3D,         /* PS4                  - Audio3D. */
	FMOD_OUTPUTTYPE_ATMOS,           /* Win                  - Dolby Atmos (WASAPI). */
	FMOD_OUTPUTTYPE_WEBAUDIO,        /* Web Browser          - JavaScript webaudio output.          (Default on JavaScript) */
	FMOD_OUTPUTTYPE_NNAUDIO,         /* NX                   - NX nn::audio.                        (Default on NX)*/
	FMOD_OUTPUTTYPE_WINSONIC,        /* Win10 / XboxOne      - Windows Sonic. */
	
	FMOD_OUTPUTTYPE_MAX,             /* Maximum number of output types supported. */
	FMOD_OUTPUTTYPE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

alias FMOD_DEBUG_MODE = int;
enum
{
	FMOD_DEBUG_MODE_TTY,             /* Default log location per platform, i.e. Visual Studio output window, stderr, LogCat, etc */
	FMOD_DEBUG_MODE_FILE,            /* Write log to specified file path */
	FMOD_DEBUG_MODE_CALLBACK,        /* Call specified callback with log information */
	
	FMOD_DEBUG_MODE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

static immutable FMOD_DEBUG_LEVEL_NONE           = 0x00000000;    /* Disable all messages */
static immutable FMOD_DEBUG_LEVEL_ERROR          = 0x00000001;    /* Enable only error messages. */
static immutable FMOD_DEBUG_LEVEL_WARNING        = 0x00000002;    /* Enable warning and error messages. */
static immutable FMOD_DEBUG_LEVEL_LOG            = 0x00000004;    /* Enable informational, warning and error messages (default). */
static immutable FMOD_DEBUG_TYPE_MEMORY          = 0x00000100;    /* Verbose logging for memory operations, only use this if you are debugging a memory related issue. */
static immutable FMOD_DEBUG_TYPE_FILE            = 0x00000200;    /* Verbose logging for file access, only use this if you are debugging a file related issue. */
static immutable FMOD_DEBUG_TYPE_CODEC           = 0x00000400;    /* Verbose logging for codec initialization, only use this if you are debugging a codec related issue. */
static immutable FMOD_DEBUG_TYPE_TRACE           = 0x00000800;    /* Verbose logging for internal errors, use this for tracking the origin of error codes. */
static immutable FMOD_DEBUG_DISPLAY_TIMESTAMPS   = 0x00010000;    /* Display the time stamp of the log message in milliseconds. */
static immutable FMOD_DEBUG_DISPLAY_LINENUMBERS  = 0x00020000;    /* Display the source code file and line number for where the message originated. */
static immutable FMOD_DEBUG_DISPLAY_THREAD       = 0x00040000;    /* Display the thread ID of the calling function that generated the message. */

static immutable FMOD_MEMORY_NORMAL             = 0x00000000;       /* Standard memory. */
static immutable FMOD_MEMORY_STREAM_FILE        = 0x00000001;       /* Stream file buffer, size controllable with System::setStreamBufferSize. */
static immutable FMOD_MEMORY_STREAM_DECODE      = 0x00000002;       /* Stream decode buffer, size controllable with FMOD_CREATESOUNDEXINFO::decodebuffersize. */
static immutable FMOD_MEMORY_SAMPLEDATA         = 0x00000004;       /* Sample data buffer.  Raw audio data, usually PCM/MPEG/ADPCM/XMA data. */
static immutable FMOD_MEMORY_DSP_BUFFER         = 0x00000008;       /* DSP memory block allocated when more than 1 output exists on a DSP node. */
static immutable FMOD_MEMORY_PLUGIN             = 0x00000010;       /* Memory allocated by a third party plugin. */
static immutable FMOD_MEMORY_XBOX360_PHYSICAL   = 0x00100000;       /* Requires XPhysicalAlloc / XPhysicalFree. */
static immutable FMOD_MEMORY_PERSISTENT         = 0x00200000;       /* Persistent memory. Memory will be freed when System::release is called. */
static immutable FMOD_MEMORY_SECONDARY          = 0x00400000;       /* Secondary memory. Allocation should be in secondary memory. For example RSX on the PS3. */
static immutable FMOD_MEMORY_ALL                = 0xFFFFFFFF;

alias FMOD_SPEAKERMODE = int;
enum 
{
	FMOD_SPEAKERMODE_DEFAULT,          /* Default speaker mode for the chosen output mode which will resolve after System::init. */
	FMOD_SPEAKERMODE_RAW,              /* Assume there is no special mapping from a given channel to a speaker, channels map 1:1 in order. Use System::setSoftwareFormat to specify the speaker count. */
	FMOD_SPEAKERMODE_MONO,             /*  1 speaker setup (monaural). */
	FMOD_SPEAKERMODE_STEREO,           /*  2 speaker setup (stereo) front left, front right. */
	FMOD_SPEAKERMODE_QUAD,             /*  4 speaker setup (4.0)    front left, front right, surround left, surround right. */
	FMOD_SPEAKERMODE_SURROUND,         /*  5 speaker setup (5.0)    front left, front right, center, surround left, surround right. */
	FMOD_SPEAKERMODE_5POINT1,          /*  6 speaker setup (5.1)    front left, front right, center, low frequency, surround left, surround right. */
	FMOD_SPEAKERMODE_7POINT1,          /*  8 speaker setup (7.1)    front left, front right, center, low frequency, surround left, surround right, back left, back right. */
	FMOD_SPEAKERMODE_7POINT1POINT4,    /* 12 speaker setup (7.1.4)  front left, front right, center, low frequency, surround left, surround right, back left, back right, top front left, top front right, top back left, top back right. */
	
	FMOD_SPEAKERMODE_MAX,              /* Maximum number of speaker modes supported. */
	FMOD_SPEAKERMODE_FORCEINT = 65536  /* Makes sure this enum is signed 32bit. */
}

static immutable FMOD_MAX_CHANNEL_WIDTH = 32;

static immutable FMOD_MAX_LISTENERS = 8;

alias FMOD_SPEAKER = int;
enum
{
	FMOD_SPEAKER_FRONT_LEFT,
	FMOD_SPEAKER_FRONT_RIGHT,
	FMOD_SPEAKER_FRONT_CENTER,
	FMOD_SPEAKER_LOW_FREQUENCY,
	FMOD_SPEAKER_SURROUND_LEFT,
	FMOD_SPEAKER_SURROUND_RIGHT,
	FMOD_SPEAKER_BACK_LEFT,
	FMOD_SPEAKER_BACK_RIGHT,
	FMOD_SPEAKER_TOP_FRONT_LEFT,    /* The top front left speaker */
	FMOD_SPEAKER_TOP_FRONT_RIGHT,   /* The top front right speaker */
	FMOD_SPEAKER_TOP_BACK_LEFT,     /* The top back left speaker */
	FMOD_SPEAKER_TOP_BACK_RIGHT,    /* The top back right speaker */
	
	FMOD_SPEAKER_MAX,               /* Maximum number of speaker types supported. */
	FMOD_SPEAKER_FORCEINT = 65536   /* Makes sure this enum is signed 32bit. */
}

static immutable FMOD_CHANNELMASK_FRONT_LEFT             = 0x00000001;
static immutable FMOD_CHANNELMASK_FRONT_RIGHT            = 0x00000002;
static immutable FMOD_CHANNELMASK_FRONT_CENTER           = 0x00000004;
static immutable FMOD_CHANNELMASK_LOW_FREQUENCY          = 0x00000008;
static immutable FMOD_CHANNELMASK_SURROUND_LEFT          = 0x00000010;
static immutable FMOD_CHANNELMASK_SURROUND_RIGHT         = 0x00000020;
static immutable FMOD_CHANNELMASK_BACK_LEFT              = 0x00000040;
static immutable FMOD_CHANNELMASK_BACK_RIGHT             = 0x00000080;
static immutable FMOD_CHANNELMASK_BACK_CENTER            = 0x00000100;

static immutable FMOD_CHANNELMASK_MONO                    = (FMOD_CHANNELMASK_FRONT_LEFT);
static immutable FMOD_CHANNELMASK_STEREO                  = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT);
static immutable FMOD_CHANNELMASK_LRC                     = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER);
static immutable FMOD_CHANNELMASK_QUAD                    = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_SURROUND_LEFT | FMOD_CHANNELMASK_SURROUND_RIGHT);
static immutable FMOD_CHANNELMASK_SURROUND                = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER | FMOD_CHANNELMASK_SURROUND_LEFT | FMOD_CHANNELMASK_SURROUND_RIGHT);
static immutable FMOD_CHANNELMASK_5POINT1                 = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER | FMOD_CHANNELMASK_LOW_FREQUENCY | FMOD_CHANNELMASK_SURROUND_LEFT | FMOD_CHANNELMASK_SURROUND_RIGHT);
static immutable FMOD_CHANNELMASK_5POINT1_REARS           = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER | FMOD_CHANNELMASK_LOW_FREQUENCY | FMOD_CHANNELMASK_BACK_LEFT | FMOD_CHANNELMASK_BACK_RIGHT);
static immutable FMOD_CHANNELMASK_7POINT0                 = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER | FMOD_CHANNELMASK_SURROUND_LEFT | FMOD_CHANNELMASK_SURROUND_RIGHT | FMOD_CHANNELMASK_BACK_LEFT | FMOD_CHANNELMASK_BACK_RIGHT);
static immutable FMOD_CHANNELMASK_7POINT1                 = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT | FMOD_CHANNELMASK_FRONT_CENTER | FMOD_CHANNELMASK_LOW_FREQUENCY | FMOD_CHANNELMASK_SURROUND_LEFT | FMOD_CHANNELMASK_SURROUND_RIGHT | FMOD_CHANNELMASK_BACK_LEFT | FMOD_CHANNELMASK_BACK_RIGHT);

alias FMOD_CHANNELORDER = int;
enum
{
	FMOD_CHANNELORDER_DEFAULT,              /* Left, Right, Center, LFE, Surround Left, Surround Right, Back Left, Back Right (see FMOD_SPEAKER enumeration)   */
	FMOD_CHANNELORDER_WAVEFORMAT,           /* Left, Right, Center, LFE, Back Left, Back Right, Surround Left, Surround Right (as per Microsoft .wav WAVEFORMAT structure master order) */
	FMOD_CHANNELORDER_PROTOOLS,             /* Left, Center, Right, Surround Left, Surround Right, LFE */
	FMOD_CHANNELORDER_ALLMONO,              /* Mono, Mono, Mono, Mono, Mono, Mono, ... (each channel all the way up to FMOD_MAX_CHANNEL_WIDTH channels are treated as if they were mono) */
	FMOD_CHANNELORDER_ALLSTEREO,            /* Left, Right, Left, Right, Left, Right, ... (each pair of channels is treated as stereo all the way up to FMOD_MAX_CHANNEL_WIDTH channels) */
	FMOD_CHANNELORDER_ALSA,                 /* Left, Right, Surround Left, Surround Right, Center, LFE (as per Linux ALSA channel order) */
	
	FMOD_CHANNELORDER_MAX,                  /* Maximum number of channel orderings supported. */
	FMOD_CHANNELORDER_FORCEINT = 65536      /* Makes sure this enum is signed 32bit. */
}

alias FMOD_PLUGINTYPE = int;
enum
{
	FMOD_PLUGINTYPE_OUTPUT,          /* The plugin type is an output module.  FMOD mixed audio will play through one of these devices */
	FMOD_PLUGINTYPE_CODEC,           /* The plugin type is a file format codec.  FMOD will use these codecs to load file formats for playback. */
	FMOD_PLUGINTYPE_DSP,             /* The plugin type is a DSP unit.  FMOD will use these plugins as part of its DSP network to apply effects to output or generate sound in realtime. */
	
	FMOD_PLUGINTYPE_MAX,             /* Maximum number of plugin types supported. */
	FMOD_PLUGINTYPE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

struct FMOD_PLUGINLIST
{
	FMOD_PLUGINTYPE   type;         /* The plugin type */
	void*             description;  /* One of FMOD_DSP_DESCRIPTION, FMOD_OUTPUT_DESCRIPTION, FMOD_CODEC_DESCRIPTION */
}

static immutable FMOD_INIT_NORMAL                     = 0x00000000; /* Initialize normally */
static immutable FMOD_INIT_STREAM_FROM_UPDATE         = 0x00000001; /* No stream thread is created internally.  Streams are driven from System::update.  Mainly used with non-realtime outputs. */
static immutable FMOD_INIT_MIX_FROM_UPDATE            = 0x00000002; /* Win/PS3/Xbox 360 Only - FMOD Mixer thread is woken up to do a mix when System::update is called rather than waking periodically on its own timer. */
static immutable FMOD_INIT_3D_RIGHTHANDED             = 0x00000004; /* FMOD will treat +X as right, +Y as up and +Z as backwards (towards you). */
static immutable FMOD_INIT_CHANNEL_LOWPASS            = 0x00000100; /* All FMOD_3D based voices will add a software lowpass filter effect into the DSP chain which is automatically used when Channel::set3DOcclusion is used or the geometry API.   This also causes sounds to sound duller when the sound goes behind the listener, as a fake HRTF style effect.  Use System::setAdvancedSettings to disable or adjust cutoff frequency for this feature. */
static immutable FMOD_INIT_CHANNEL_DISTANCEFILTER     = 0x00000200; /* All FMOD_3D based voices will add a software lowpass and highpass filter effect into the DSP chain which will act as a distance-automated bandpass filter. Use System::setAdvancedSettings to adjust the center frequency. */
static immutable FMOD_INIT_PROFILE_ENABLE             = 0x00010000; /* Enable TCP/IP based host which allows FMOD Designer or FMOD Profiler to connect to it, and view memory, CPU and the DSP network graph in real-time. */
static immutable FMOD_INIT_VOL0_BECOMES_VIRTUAL       = 0x00020000; /* Any sounds that are 0 volume will go virtual and not be processed except for having their positions updated virtually.  Use System::setAdvancedSettings to adjust what volume besides zero to switch to virtual at. */
static immutable FMOD_INIT_GEOMETRY_USECLOSEST        = 0x00040000; /* With the geometry engine, only process the closest polygon rather than accumulating all polygons the sound to listener line intersects. */
static immutable FMOD_INIT_PREFER_DOLBY_DOWNMIX       = 0x00080000; /* When using FMOD_SPEAKERMODE_5POINT1 with a stereo output device, use the Dolby Pro Logic II downmix algorithm instead of the SRS Circle Surround algorithm. */
static immutable FMOD_INIT_THREAD_UNSAFE              = 0x00100000; /* Disables thread safety for API calls. Only use this if FMOD low level is being called from a single thread, and if Studio API is not being used! */
static immutable FMOD_INIT_PROFILE_METER_ALL          = 0x00200000; /* Slower, but adds level metering for every single DSP unit in the graph.  Use DSP::setMeteringEnabled to turn meters off individually. */
static immutable FMOD_INIT_DISABLE_SRS_HIGHPASSFILTER = 0x00400000; /* Using FMOD_SPEAKERMODE_5POINT1 with a stereo output device will enable the SRS Circle Surround downmixer. By default the SRS downmixer applies a high pass filter with a cutoff frequency of 80Hz. Use this flag to diable the high pass fitler, or use FMOD_INIT_PREFER_DOLBY_DOWNMIX to use the Dolby Pro Logic II downmix algorithm instead. */

alias FMOD_SOUND_TYPE = int;
enum
{
	FMOD_SOUND_TYPE_UNKNOWN,         /* 3rd party / unknown plugin format. */
	FMOD_SOUND_TYPE_AIFF,            /* AIFF. */
	FMOD_SOUND_TYPE_ASF,             /* Microsoft Advanced Systems Format (ie WMA/ASF/WMV). */
	FMOD_SOUND_TYPE_DLS,             /* Sound font / downloadable sound bank. */
	FMOD_SOUND_TYPE_FLAC,            /* FLAC lossless codec. */
	FMOD_SOUND_TYPE_FSB,             /* FMOD Sample Bank. */
	FMOD_SOUND_TYPE_IT,              /* Impulse Tracker. */
	FMOD_SOUND_TYPE_MIDI,            /* MIDI. */
	FMOD_SOUND_TYPE_MOD,             /* Protracker / Fasttracker MOD. */
	FMOD_SOUND_TYPE_MPEG,            /* MP2/MP3 MPEG. */
	FMOD_SOUND_TYPE_OGGVORBIS,       /* Ogg vorbis. */
	FMOD_SOUND_TYPE_PLAYLIST,        /* Information only from ASX/PLS/M3U/WAX playlists */
	FMOD_SOUND_TYPE_RAW,             /* Raw PCM data. */
	FMOD_SOUND_TYPE_S3M,             /* ScreamTracker 3. */
	FMOD_SOUND_TYPE_USER,            /* User created sound. */
	FMOD_SOUND_TYPE_WAV,             /* Microsoft WAV. */
	FMOD_SOUND_TYPE_XM,              /* FastTracker 2 XM. */
	FMOD_SOUND_TYPE_XMA,             /* Xbox360 XMA */
	FMOD_SOUND_TYPE_AUDIOQUEUE,      /* iPhone hardware decoder, supports AAC, ALAC and MP3. */
	FMOD_SOUND_TYPE_AT9,             /* PS4 / PSVita ATRAC 9 format */
	FMOD_SOUND_TYPE_VORBIS,          /* Vorbis */
	FMOD_SOUND_TYPE_MEDIA_FOUNDATION,/* Windows Store Application built in system codecs */
	FMOD_SOUND_TYPE_MEDIACODEC,      /* Android MediaCodec */
	FMOD_SOUND_TYPE_FADPCM,          /* FMOD Adaptive Differential Pulse Code Modulation */
	
	FMOD_SOUND_TYPE_MAX,             /* Maximum number of sound types supported. */
	FMOD_SOUND_TYPE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

alias FMOD_SOUND_FORMAT = int;
enum
{
	FMOD_SOUND_FORMAT_NONE,             /* Unitialized / unknown. */
	FMOD_SOUND_FORMAT_PCM8,             /* 8bit integer PCM data. */
	FMOD_SOUND_FORMAT_PCM16,            /* 16bit integer PCM data. */
	FMOD_SOUND_FORMAT_PCM24,            /* 24bit integer PCM data. */
	FMOD_SOUND_FORMAT_PCM32,            /* 32bit integer PCM data. */
	FMOD_SOUND_FORMAT_PCMFLOAT,         /* 32bit floating point PCM data. */
	FMOD_SOUND_FORMAT_BITSTREAM,        /* Sound data is in its native compressed format. */
	
	FMOD_SOUND_FORMAT_MAX,              /* Maximum number of sound formats supported. */   
	FMOD_SOUND_FORMAT_FORCEINT = 65536  /* Makes sure this enum is signed 32bit. */
}

static immutable FMOD_DEFAULT                   = 0x00000000;  /* Default for all modes listed below. FMOD_LOOP_OFF, FMOD_2D, FMOD_3D_WORLDRELATIVE, FMOD_3D_INVERSEROLLOFF */
static immutable FMOD_LOOP_OFF                  = 0x00000001;  /* For non looping sounds. (DEFAULT).  Overrides FMOD_LOOP_NORMAL / FMOD_LOOP_BIDI. */
static immutable FMOD_LOOP_NORMAL               = 0x00000002;  /* For forward looping sounds. */
static immutable FMOD_LOOP_BIDI                 = 0x00000004;  /* For bidirectional looping sounds. (only works on software mixed static sounds). */
static immutable FMOD_2D                        = 0x00000008;  /* Ignores any 3d processing. (DEFAULT). */
static immutable FMOD_3D                        = 0x00000010;  /* Makes the sound positionable in 3D.  Overrides FMOD_2D. */
static immutable FMOD_CREATESTREAM              = 0x00000080;  /* Decompress at runtime, streaming from the source provided (ie from disk).  Overrides FMOD_CREATESAMPLE and FMOD_CREATECOMPRESSEDSAMPLE.  Note a stream can only be played once at a time due to a stream only having 1 stream buffer and file handle.  Open multiple streams to have them play concurrently. */
static immutable FMOD_CREATESAMPLE              = 0x00000100;  /* Decompress at loadtime, decompressing or decoding whole file into memory as the target sample format (ie PCM).  Fastest for playback and most flexible.  */
static immutable FMOD_CREATECOMPRESSEDSAMPLE    = 0x00000200;  /* Load MP2/MP3/IMAADPCM/Vorbis/AT9 or XMA into memory and leave it compressed.  Vorbis/AT9 encoding only supported in the FSB file format.  During playback the FMOD software mixer will decode it in realtime as a 'compressed sample'.  Overrides FMOD_CREATESAMPLE.  If the sound data is not one of the supported formats, it will behave as if it was created with FMOD_CREATESAMPLE and decode the sound into PCM. */
static immutable FMOD_OPENUSER                  = 0x00000400;  /* Opens a user created static sample or stream. Use FMOD_CREATESOUNDEXINFO to specify format and/or read callbacks.  If a user created 'sample' is created with no read callback, the sample will be empty.  Use Sound::lock and Sound::unlock to place sound data into the sound if this is the case. */
static immutable FMOD_OPENMEMORY                = 0x00000800;  /* "name_or_data" will be interpreted as a pointer to memory instead of filename for creating sounds.  Use FMOD_CREATESOUNDEXINFO to specify length.  If used with FMOD_CREATESAMPLE or FMOD_CREATECOMPRESSEDSAMPLE, FMOD duplicates the memory into its own buffers.  Your own buffer can be freed after open.  If used with FMOD_CREATESTREAM, FMOD will stream out of the buffer whose pointer you passed in.  In this case, your own buffer should not be freed until you have finished with and released the stream.*/
static immutable FMOD_OPENMEMORY_POINT          = 0x10000000;  /* "name_or_data" will be interpreted as a pointer to memory instead of filename for creating sounds.  Use FMOD_CREATESOUNDEXINFO to specify length.  This differs to FMOD_OPENMEMORY in that it uses the memory as is, without duplicating the memory into its own buffers.  Cannot be freed after open, only after Sound::release.   Will not work if the data is compressed and FMOD_CREATECOMPRESSEDSAMPLE is not used. */
static immutable FMOD_OPENRAW                   = 0x00001000;  /* Will ignore file format and treat as raw pcm.  Use FMOD_CREATESOUNDEXINFO to specify format.  Requires at least defaultfrequency, numchannels and format to be specified before it will open.  Must be little endian data. */
static immutable FMOD_OPENONLY                  = 0x00002000;  /* Just open the file, dont prebuffer or read.  Good for fast opens for info, or when sound::readData is to be used. */
static immutable FMOD_ACCURATETIME              = 0x00004000;  /* For System::createSound - for accurate Sound::getLength/Channel::setPosition on VBR MP3, and MOD/S3M/XM/IT/MIDI files.  Scans file first, so takes longer to open. FMOD_OPENONLY does not affect this. */
static immutable FMOD_MPEGSEARCH                = 0x00008000;  /* For corrupted / bad MP3 files.  This will search all the way through the file until it hits a valid MPEG header.  Normally only searches for 4k. */
static immutable FMOD_NONBLOCKING               = 0x00010000;  /* For opening sounds and getting streamed subsounds (seeking) asyncronously.  Use Sound::getOpenState to poll the state of the sound as it opens or retrieves the subsound in the background. */
static immutable FMOD_UNIQUE                    = 0x00020000;  /* Unique sound, can only be played one at a time */
static immutable FMOD_3D_HEADRELATIVE           = 0x00040000;  /* Make the sound's position, velocity and orientation relative to the listener. */
static immutable FMOD_3D_WORLDRELATIVE          = 0x00080000;  /* Make the sound's position, velocity and orientation absolute (relative to the world). (DEFAULT) */
static immutable FMOD_3D_INVERSEROLLOFF         = 0x00100000;  /* This sound will follow the inverse rolloff model where mindistance = full volume, maxdistance = where sound stops attenuating, and rolloff is fixed according to the global rolloff factor.  (DEFAULT) */
static immutable FMOD_3D_LINEARROLLOFF          = 0x00200000;  /* This sound will follow a linear rolloff model where mindistance = full volume, maxdistance = silence. */
static immutable FMOD_3D_LINEARSQUAREROLLOFF    = 0x00400000;  /* This sound will follow a linear-square rolloff model where mindistance = full volume, maxdistance = silence. */
static immutable FMOD_3D_INVERSETAPEREDROLLOFF  = 0x00800000;  /* This sound will follow the inverse rolloff model at distances close to mindistance and a linear-square rolloff close to maxdistance. */
static immutable FMOD_3D_CUSTOMROLLOFF          = 0x04000000;  /* This sound will follow a rolloff model defined by Sound::set3DCustomRolloff / Channel::set3DCustomRolloff.  */
static immutable FMOD_3D_IGNOREGEOMETRY         = 0x40000000;  /* Is not affect by geometry occlusion.  If not specified in Sound::setMode, or Channel::setMode, the flag is cleared and it is affected by geometry again. */
static immutable FMOD_IGNORETAGS                = 0x02000000;  /* Skips id3v2/asf/etc tag checks when opening a sound, to reduce seek/read overhead when opening files (helps with CD performance). */
static immutable FMOD_LOWMEM                    = 0x08000000;  /* Removes some features from samples to give a lower memory overhead, like Sound::getName.  See remarks. */
static immutable FMOD_LOADSECONDARYRAM          = 0x20000000;  /* Load sound into the secondary RAM of supported platform. On PS3, sounds will be loaded into RSX/VRAM. */
static immutable FMOD_VIRTUAL_PLAYFROMSTART     = 0x80000000;  /* For sounds that start virtual (due to being quiet or low importance), instead of swapping back to audible, and playing at the correct offset according to time, this flag makes the sound play from the start. */

alias FMOD_OPENSTATE = int;
enum
{
	FMOD_OPENSTATE_READY = 0,       /* Opened and ready to play. */
	FMOD_OPENSTATE_LOADING,         /* Initial load in progress. */
	FMOD_OPENSTATE_ERROR,           /* Failed to open - file not found, out of memory etc.  See return value of Sound::getOpenState for what happened. */
	FMOD_OPENSTATE_CONNECTING,      /* Connecting to remote host (internet sounds only). */
	FMOD_OPENSTATE_BUFFERING,       /* Buffering data. */
	FMOD_OPENSTATE_SEEKING,         /* Seeking to subsound and re-flushing stream buffer. */
	FMOD_OPENSTATE_PLAYING,         /* Ready and playing, but not possible to release at this time without stalling the main thread. */
	FMOD_OPENSTATE_SETPOSITION,     /* Seeking within a stream to a different position. */
	
	FMOD_OPENSTATE_MAX,             /* Maximum number of open state types. */
	FMOD_OPENSTATE_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

alias FMOD_SOUNDGROUP_BEHAVIOR = int;
enum
{
	FMOD_SOUNDGROUP_BEHAVIOR_FAIL,              /* Any sound played that puts the sound count over the SoundGroup::setMaxAudible setting, will simply fail during System::playSound. */
	FMOD_SOUNDGROUP_BEHAVIOR_MUTE,              /* Any sound played that puts the sound count over the SoundGroup::setMaxAudible setting, will be silent, then if another sound in the group stops the sound that was silent before becomes audible again. */
	FMOD_SOUNDGROUP_BEHAVIOR_STEALLOWEST,       /* Any sound played that puts the sound count over the SoundGroup::setMaxAudible setting, will steal the quietest / least important sound playing in the group. */
	
	FMOD_SOUNDGROUP_BEHAVIOR_MAX,               /* Maximum number of sound group behaviors. */
	FMOD_SOUNDGROUP_BEHAVIOR_FORCEINT = 65536   /* Makes sure this enum is signed 32bit. */
}

alias FMOD_CHANNELCONTROL_CALLBACK_TYPE = int;
enum
{
	FMOD_CHANNELCONTROL_CALLBACK_END,                  /* Called when a sound ends. */
	FMOD_CHANNELCONTROL_CALLBACK_VIRTUALVOICE,         /* Called when a voice is swapped out or swapped in. */
	FMOD_CHANNELCONTROL_CALLBACK_SYNCPOINT,            /* Called when a syncpoint is encountered.  Can be from wav file markers. */
	FMOD_CHANNELCONTROL_CALLBACK_OCCLUSION,            /* Called when the channel has its geometry occlusion value calculated.  Can be used to clamp or change the value. */
	
	FMOD_CHANNELCONTROL_CALLBACK_MAX,                  /* Maximum number of callback types supported. */
	FMOD_CHANNELCONTROL_CALLBACK_FORCEINT = 65536      /* Makes sure this enum is signed 32bit. */
}

alias FMOD_CHANNELCONTROL_DSP_INDEX = int;
enum
{
	FMOD_CHANNELCONTROL_DSP_HEAD = -1,          /* Head of the DSP chain.   Equivalent of index 0. */
	FMOD_CHANNELCONTROL_DSP_FADER = -2,         /* Built in fader DSP. */
	FMOD_CHANNELCONTROL_DSP_TAIL = -3,          /* Tail of the DSP chain.  Equivalent of the number of dsps minus 1. */
	
	FMOD_CHANNELCONTROL_DSP_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

alias FMOD_ERRORCALLBACK_INSTANCETYPE = int;
enum
{
	FMOD_ERRORCALLBACK_INSTANCETYPE_NONE,
	FMOD_ERRORCALLBACK_INSTANCETYPE_SYSTEM,
	FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNEL,
	FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNELGROUP,
	FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNELCONTROL,
	FMOD_ERRORCALLBACK_INSTANCETYPE_SOUND,
	FMOD_ERRORCALLBACK_INSTANCETYPE_SOUNDGROUP,
	FMOD_ERRORCALLBACK_INSTANCETYPE_DSP,
	FMOD_ERRORCALLBACK_INSTANCETYPE_DSPCONNECTION,
	FMOD_ERRORCALLBACK_INSTANCETYPE_GEOMETRY,
	FMOD_ERRORCALLBACK_INSTANCETYPE_REVERB3D,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_SYSTEM,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_EVENTDESCRIPTION,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_EVENTINSTANCE,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_PARAMETERINSTANCE,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_BUS,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_VCA,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_BANK,
	FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_COMMANDREPLAY,
	
	FMOD_ERRORCALLBACK_INSTANCETYPE_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

struct FMOD_ERRORCALLBACK_INFO
{
	FMOD_RESULT                      result;                     /* Error code result */
	FMOD_ERRORCALLBACK_INSTANCETYPE  instancetype;               /* Type of instance the error occurred on */
	void                            *instance;                   /* Instance pointer */
	const char                      *functionname;               /* Function that the error occurred on */
	const char                      *functionparams;             /* Function parameters that the error ocurred on */
}

static immutable FMOD_SYSTEM_CALLBACK_DEVICELISTCHANGED      = 0x00000001;  /* Called from System::update when the enumerated list of devices has changed. */
static immutable FMOD_SYSTEM_CALLBACK_DEVICELOST             = 0x00000002;  /* Called from System::update when an output device has been lost due to control panel parameter changes and FMOD cannot automatically recover. */
static immutable FMOD_SYSTEM_CALLBACK_MEMORYALLOCATIONFAILED = 0x00000004;  /* Called directly when a memory allocation fails somewhere in FMOD.  (NOTE - 'system' will be NULL in this callback type.)*/
static immutable FMOD_SYSTEM_CALLBACK_THREADCREATED          = 0x00000008;  /* Called directly when a thread is created. */
static immutable FMOD_SYSTEM_CALLBACK_BADDSPCONNECTION       = 0x00000010;  /* Called when a bad connection was made with DSP::addInput. Usually called from mixer thread because that is where the connections are made.  */
static immutable FMOD_SYSTEM_CALLBACK_PREMIX                 = 0x00000020;  /* Called each tick before a mix update happens. */
static immutable FMOD_SYSTEM_CALLBACK_POSTMIX                = 0x00000040;  /* Called each tick after a mix update happens. */
static immutable FMOD_SYSTEM_CALLBACK_ERROR                  = 0x00000080;  /* Called when each API function returns an error code, including delayed async functions. */
static immutable FMOD_SYSTEM_CALLBACK_MIDMIX                 = 0x00000100;  /* Called each tick in mix update after clocks have been updated before the main mix occurs. */
static immutable FMOD_SYSTEM_CALLBACK_THREADDESTROYED        = 0x00000200;  /* Called directly when a thread is destroyed. */
static immutable FMOD_SYSTEM_CALLBACK_PREUPDATE              = 0x00000400;  /* Called at start of System::update function. */
static immutable FMOD_SYSTEM_CALLBACK_POSTUPDATE             = 0x00000800;  /* Called at end of System::update function. */
static immutable FMOD_SYSTEM_CALLBACK_RECORDLISTCHANGED      = 0x00001000;  /* Called from System::update when the enumerated list of recording devices has changed. */
static immutable FMOD_SYSTEM_CALLBACK_ALL                    = 0xFFFFFFFF;  /* Pass this mask to System::setCallback to receive all callback types. */

alias FMOD_DEBUG_CALLBACK = FMOD_RESULT function(FMOD_DEBUG_FLAGS flags, const char *file, int line, const char *func, const char *message);
alias FMOD_SYSTEM_CALLBACK = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SYSTEM_CALLBACK_TYPE type, void *commanddata1, void *commanddata2, void *userdata);
alias FMOD_CHANNELCONTROL_CALLBACK = FMOD_RESULT function(FMOD_CHANNELCONTROL *channelcontrol, FMOD_CHANNELCONTROL_TYPE controltype, FMOD_CHANNELCONTROL_CALLBACK_TYPE callbacktype, void *commanddata1, void *commanddata2);
alias FMOD_SOUND_NONBLOCK_CALLBACK = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_RESULT result);
alias FMOD_SOUND_PCMREAD_CALLBACK = FMOD_RESULT function(FMOD_SOUND *sound, void *data, uint datalen);
alias FMOD_SOUND_PCMSETPOS_CALLBACK = FMOD_RESULT function(FMOD_SOUND *sound, int subsound, uint position, FMOD_TIMEUNIT postype);
alias FMOD_FILE_OPEN_CALLBACK = FMOD_RESULT function(const char *name, uint *filesize, void **handle, void *userdata);
alias FMOD_FILE_CLOSE_CALLBACK = FMOD_RESULT function(void *handle, void *userdata);
alias FMOD_FILE_READ_CALLBACK = FMOD_RESULT function(void *handle, void *buffer, uint sizebytes, uint *bytesread, void *userdata);
alias FMOD_FILE_SEEK_CALLBACK = FMOD_RESULT function(void *handle, uint pos, void *userdata);
alias FMOD_FILE_ASYNCREAD_CALLBACK = FMOD_RESULT function(FMOD_ASYNCREADINFO *info, void *userdata);
alias FMOD_FILE_ASYNCCANCEL_CALLBACK = FMOD_RESULT function(FMOD_ASYNCREADINFO *info, void *userdata);
alias FMOD_MEMORY_ALLOC_CALLBACK = void* function(uint size, FMOD_MEMORY_TYPE type, const char *sourcestr);
alias FMOD_MEMORY_REALLOC_CALLBACK = void* function(void *ptr, uint size, FMOD_MEMORY_TYPE type, const char *sourcestr);
alias FMOD_MEMORY_FREE_CALLBACK = void function(void *ptr, FMOD_MEMORY_TYPE type, const char *sourcestr);
alias FMOD_3D_ROLLOFF_CALLBACK = float function(FMOD_CHANNELCONTROL *channelcontrol, float distance);

alias FMOD_DSP_RESAMPLER = int;
enum
{
	FMOD_DSP_RESAMPLER_DEFAULT,         /* Default interpolation method.  Currently equal to FMOD_DSP_RESAMPLER_LINEAR. */
	FMOD_DSP_RESAMPLER_NOINTERP,        /* No interpolation.  High frequency aliasing hiss will be audible depending on the sample rate of the sound. */
	FMOD_DSP_RESAMPLER_LINEAR,          /* Linear interpolation (default method).  Fast and good quality, causes very slight lowpass effect on low frequency sounds. */
	FMOD_DSP_RESAMPLER_CUBIC,           /* Cubic interpolation.  Slower than linear interpolation but better quality. */
	FMOD_DSP_RESAMPLER_SPLINE,          /* 5 point spline interpolation.  Slowest resampling method but best quality. */
	
	FMOD_DSP_RESAMPLER_MAX,             /* Maximum number of resample methods supported. */
	FMOD_DSP_RESAMPLER_FORCEINT = 65536 /* Makes sure this enum is signed 32bit. */
}

alias FMOD_DSPCONNECTION_TYPE = int;
enum
{
	FMOD_DSPCONNECTION_TYPE_STANDARD,          /* Default connection type.         Audio is mixed from the input to the output DSP's audible buffer.  */
	FMOD_DSPCONNECTION_TYPE_SIDECHAIN,         /* Sidechain connection type.       Audio is mixed from the input to the output DSP's sidechain buffer.  */
	FMOD_DSPCONNECTION_TYPE_SEND,              /* Send connection type.            Audio is mixed from the input to the output DSP's audible buffer, but the input is NOT executed, only copied from.  A standard connection or sidechain needs to make an input execute to generate data. */
	FMOD_DSPCONNECTION_TYPE_SEND_SIDECHAIN,    /* Send sidechain connection type.  Audio is mixed from the input to the output DSP's sidechain buffer, but the input is NOT executed, only copied from.  A standard connection or sidechain needs to make an input execute to generate data. */
	
	FMOD_DSPCONNECTION_TYPE_MAX,               /* Maximum number of DSP connection types supported. */
	FMOD_DSPCONNECTION_TYPE_FORCEINT = 65536   /* Makes sure this enum is signed 32bit. */
}

alias FMOD_TAGTYPE = int;
enum
{
	FMOD_TAGTYPE_UNKNOWN = 0,
	FMOD_TAGTYPE_ID3V1,
	FMOD_TAGTYPE_ID3V2,
	FMOD_TAGTYPE_VORBISCOMMENT,
	FMOD_TAGTYPE_SHOUTCAST,
	FMOD_TAGTYPE_ICECAST,
	FMOD_TAGTYPE_ASF,
	FMOD_TAGTYPE_MIDI,
	FMOD_TAGTYPE_PLAYLIST,
	FMOD_TAGTYPE_FMOD,
	FMOD_TAGTYPE_USER,
	
	FMOD_TAGTYPE_MAX,               /* Maximum number of tag types supported. */
	FMOD_TAGTYPE_FORCEINT = 65536   /* Makes sure this enum is signed 32bit. */
}

alias FMOD_TAGDATATYPE = int;
enum
{
	FMOD_TAGDATATYPE_BINARY = 0,
	FMOD_TAGDATATYPE_INT,
	FMOD_TAGDATATYPE_FLOAT,
	FMOD_TAGDATATYPE_STRING,
	FMOD_TAGDATATYPE_STRING_UTF16,
	FMOD_TAGDATATYPE_STRING_UTF16BE,
	FMOD_TAGDATATYPE_STRING_UTF8,
	FMOD_TAGDATATYPE_CDTOC,
	
	FMOD_TAGDATATYPE_MAX,               /* Maximum number of tag datatypes supported. */
	FMOD_TAGDATATYPE_FORCEINT = 65536   /* Makes sure this enum is signed 32bit. */
}

struct FMOD_TAG
{
	FMOD_TAGTYPE      type;         /* [r] The type of this tag. */
	FMOD_TAGDATATYPE  datatype;     /* [r] The type of data that this tag contains */
	char             *name;         /* [r] The name of this tag i.e. "TITLE", "ARTIST" etc. */
	void             *data;         /* [r] Pointer to the tag data - its format is determined by the datatype member */
	uint      datalen;      /* [r] Length of the data contained in this tag */
	FMOD_BOOL         updated;      /* [r] True if this tag has been updated since last being accessed with Sound::getTag */
}

static immutable FMOD_TIMEUNIT_MS                = 0x00000001;  /* Milliseconds. */
static immutable FMOD_TIMEUNIT_PCM               = 0x00000002;  /* PCM samples, related to milliseconds * samplerate / 1000. */
static immutable FMOD_TIMEUNIT_PCMBYTES          = 0x00000004;  /* Bytes, related to PCM samples * channels * datawidth (ie 16bit = 2 bytes). */
static immutable FMOD_TIMEUNIT_RAWBYTES          = 0x00000008;  /* Raw file bytes of (compressed) sound data (does not include headers).  Only used by Sound::getLength and Channel::getPosition. */
static immutable FMOD_TIMEUNIT_PCMFRACTION       = 0x00000010;  /* Fractions of 1 PCM sample.  uint range 0 to 0xFFFFFFFF.  Used for sub-sample granularity for DSP purposes. */
static immutable FMOD_TIMEUNIT_MODORDER          = 0x00000100;  /* MOD/S3M/XM/IT.  Order in a sequenced module format.  Use Sound::getFormat to determine the PCM format being decoded to. */
static immutable FMOD_TIMEUNIT_MODROW            = 0x00000200;  /* MOD/S3M/XM/IT.  Current row in a sequenced module format.  Sound::getLength will return the number of rows in the currently playing or seeked to pattern. */
static immutable FMOD_TIMEUNIT_MODPATTERN        = 0x00000400;  /* MOD/S3M/XM/IT.  Current pattern in a sequenced module format.  Sound::getLength will return the number of patterns in the song and Channel::getPosition will return the currently playing pattern. */

static immutable FMOD_PORT_INDEX_NONE            = 0xFFFFFFFFFFFFFFFF;

struct FMOD_CREATESOUNDEXINFO
{
	int                            cbsize;             /* [w]   Size of this structure.  This is used so the structure can be expanded in the future and still work on older versions of FMOD Studio. */
	uint                   length;             /* [w]   Optional. Specify 0 to ignore. Number of bytes to load starting at 'fileoffset', or size of sound to create (if FMOD_OPENUSER is used).  Required if loading from memory.  If 0 is specified, then it will use the size of the file (unless loading from memory then an error will be returned). */
	uint                   fileoffset;         /* [w]   Optional. Specify 0 to ignore. Offset from start of the file to start loading from.  This is useful for loading files from inside big data files. */
	int                            numchannels;        /* [w]   Optional. Specify 0 to ignore. Number of channels in a sound mandatory if FMOD_OPENUSER or FMOD_OPENRAW is used.  Can be specified up to FMOD_MAX_CHANNEL_WIDTH. */
	int                            defaultfrequency;   /* [w]   Optional. Specify 0 to ignore. Default frequency of sound in Hz, mandatory if FMOD_OPENUSER or FMOD_OPENRAW is used.  Other formats use the frequency determined by the file format. */
	FMOD_SOUND_FORMAT              format;             /* [w]   Optional. Specify 0 or FMOD_SOUND_FORMAT_NONE to ignore. Format of the sound, mandatory if FMOD_OPENUSER or FMOD_OPENRAW is used.  Other formats use the format determined by the file format.   */
	uint                   decodebuffersize;   /* [w]   Optional. Specify 0 to ignore. For streams.  This determines the size of the double buffer (in PCM samples) that a stream uses.  Use this for user created streams if you want to determine the size of the callback buffer passed to you.  Specify 0 to use FMOD's default size which is currently equivalent to 400ms of the sound format created/loaded. */
	int                            initialsubsound;    /* [w]   Optional. Specify 0 to ignore. In a multi-sample file format such as .FSB/.DLS, specify the initial subsound to seek to, only if FMOD_CREATESTREAM is used. */
	int                            numsubsounds;       /* [w]   Optional. Specify 0 to ignore or have no subsounds.  In a sound created with FMOD_OPENUSER, specify the number of subsounds that are accessable with Sound::getSubSound.  If not created with FMOD_OPENUSER, this will limit the number of subsounds loaded within a multi-subsound file.  If using FSB, then if FMOD_CREATESOUNDEXINFO::inclusionlist is used, this will shuffle subsounds down so that there are not any gaps.  It will mean that the indices of the sounds will be different. */
	int                           *inclusionlist;      /* [w]   Optional. Specify 0 to ignore. In a multi-sample format such as .FSB/.DLS it may be desirable to specify only a subset of sounds to be loaded out of the whole file.  This is an array of subsound indices to load into memory when created. */
	int                            inclusionlistnum;   /* [w]   Optional. Specify 0 to ignore. This is the number of integers contained within the inclusionlist array. */
	FMOD_SOUND_PCMREAD_CALLBACK    pcmreadcallback;    /* [w]   Optional. Specify 0 to ignore. Callback to 'piggyback' on FMOD's read functions and accept or even write PCM data while FMOD is opening the sound.  Used for user sounds created with FMOD_OPENUSER or for capturing decoded data as FMOD reads it. */
	FMOD_SOUND_PCMSETPOS_CALLBACK  pcmsetposcallback;  /* [w]   Optional. Specify 0 to ignore. Callback for when the user calls a seeking function such as Channel::setTime or Channel::setPosition within a multi-sample sound, and for when it is opened.*/
	FMOD_SOUND_NONBLOCK_CALLBACK   nonblockcallback;   /* [w]   Optional. Specify 0 to ignore. Callback for successful completion, or error while loading a sound that used the FMOD_NONBLOCKING flag.  Also called duing seeking, when setPosition is called or a stream is restarted. */
	const(char)                    *dlsname;            /* [w]   Optional. Specify 0 to ignore. Filename for a DLS sample set when loading a MIDI file. If not specified, on Windows it will attempt to open /windows/system32/drivers/gm.dls or /windows/system32/drivers/etc/gm.dls, on Mac it will attempt to load /System/Library/Components/CoreAudio.component/Contents/Resources/gs_instruments.dls, otherwise the MIDI will fail to open. Current DLS support is for level 1 of the specification. */
	const(char)                    *encryptionkey;      /* [w]   Optional. Specify 0 to ignore. Key for encrypted FSB file.  Without this key an encrypted FSB file will not load. */
	int                            maxpolyphony;       /* [w]   Optional. Specify 0 to ignore. For sequenced formats with dynamic channel allocation such as .MID and .IT, this specifies the maximum voice count allowed while playing.  .IT defaults to 64.  .MID defaults to 32. */
	void                          *userdata;           /* [w]   Optional. Specify 0 to ignore. This is user data to be attached to the sound during creation.  Access via Sound::getUserData.  Note: This is not passed to FMOD_FILE_OPEN_CALLBACK - use fileuserdata for that. */
	FMOD_SOUND_TYPE                suggestedsoundtype; /* [w]   Optional. Specify 0 or FMOD_SOUND_TYPE_UNKNOWN to ignore.  Instead of scanning all codec types, use this to speed up loading by making it jump straight to this codec. */
	FMOD_FILE_OPEN_CALLBACK        fileuseropen;       /* [w]   Optional. Specify 0 to ignore. Callback for opening this file. */
	FMOD_FILE_CLOSE_CALLBACK       fileuserclose;      /* [w]   Optional. Specify 0 to ignore. Callback for closing this file. */
	FMOD_FILE_READ_CALLBACK        fileuserread;       /* [w]   Optional. Specify 0 to ignore. Callback for reading from this file. */
	FMOD_FILE_SEEK_CALLBACK        fileuserseek;       /* [w]   Optional. Specify 0 to ignore. Callback for seeking within this file. */
	FMOD_FILE_ASYNCREAD_CALLBACK   fileuserasyncread;  /* [w]   Optional. Specify 0 to ignore. Callback for seeking within this file. */
	FMOD_FILE_ASYNCCANCEL_CALLBACK fileuserasynccancel;/* [w]   Optional. Specify 0 to ignore. Callback for seeking within this file. */
	void                          *fileuserdata;       /* [w]   Optional. Specify 0 to ignore. User data to be passed into the file callbacks. */
	int                            filebuffersize;     /* [w]   Optional. Specify 0 to ignore. Buffer size for reading the file, -1 to disable buffering, or 0 for system default. */
	FMOD_CHANNELORDER              channelorder;       /* [w]   Optional. Specify 0 to ignore. Use this to differ the way fmod maps multichannel sounds to speakers.  See FMOD_CHANNELORDER for more. */
	FMOD_CHANNELMASK               channelmask;        /* [w]   Optional. Specify 0 to ignore. Use this to specify which channels map to which speakers.  See FMOD_CHANNELMASK for more. */
	FMOD_SOUNDGROUP               *initialsoundgroup;  /* [w]   Optional. Specify 0 to ignore. Specify a sound group if required, to put sound in as it is created. */
	uint                   initialseekposition;/* [w]   Optional. Specify 0 to ignore. For streams. Specify an initial position to seek the stream to. */
	FMOD_TIMEUNIT                  initialseekpostype; /* [w]   Optional. Specify 0 to ignore. For streams. Specify the time unit for the position set in initialseekposition. */
	int                            ignoresetfilesystem;/* [w]   Optional. Specify 0 to ignore. Set to 1 to use fmod's built in file system. Ignores setFileSystem callbacks and also FMOD_CREATESOUNEXINFO file callbacks.  Useful for specific cases where you don't want to use your own file system but want to use fmod's file system (ie net streaming). */
	uint                   audioqueuepolicy;   /* [w]   Optional. Specify 0 or FMOD_AUDIOQUEUE_CODECPOLICY_DEFAULT to ignore. Policy used to determine whether hardware or software is used for decoding, see FMOD_AUDIOQUEUE_CODECPOLICY for options (iOS >= 3.0 required, otherwise only hardware is available) */ 
	uint                   minmidigranularity; /* [w]   Optional. Specify 0 to ignore. Allows you to set a minimum desired MIDI mixer granularity. Values smaller than 512 give greater than default accuracy at the cost of more CPU and vice versa. Specify 0 for default (512 samples). */
	int                            nonblockthreadid;   /* [w]   Optional. Specify 0 to ignore. Specifies a thread index to execute non blocking load on.  Allows for up to 5 threads to be used for loading at once.  This is to avoid one load blocking another.  Maximum value = 4. */
	FMOD_GUID                     *fsbguid;            /* [r/w] Optional. Specify 0 to ignore. Allows you to provide the GUID lookup for cached FSB header info. Once loaded the GUID will be written back to the pointer. This is to avoid seeking and reading the FSB header. */
}

static immutable FMOD_REVERB_MAXINSTANCES = 4;

struct FMOD_REVERB_PROPERTIES
{                                   /*       MIN    MAX     DEFAULT DESCRIPTION */
	float        DecayTime;         /* [r/w] 0.0    20000.0 1500.0  Reverberation decay time in ms                                        */
	float        EarlyDelay;        /* [r/w] 0.0    300.0   7.0     Initial reflection delay time                                         */
	float        LateDelay;         /* [r/w] 0.0    100     11.0    Late reverberation delay time relative to initial reflection          */
	float        HFReference;       /* [r/w] 20.0   20000.0 5000    Reference high frequency (hz)                                         */
	float        HFDecayRatio;      /* [r/w] 10.0   100.0   50.0    High-frequency to mid-frequency decay time ratio                      */
	float        Diffusion;         /* [r/w] 0.0    100.0   100.0   Value that controls the echo density in the late reverberation decay. */
	float        Density;           /* [r/w] 0.0    100.0   100.0   Value that controls the modal density in the late reverberation decay */
	float        LowShelfFrequency; /* [r/w] 20.0   1000.0  250.0   Reference low frequency (hz)                                          */
	float        LowShelfGain;      /* [r/w] -36.0  12.0    0.0     Relative room effect level at low frequencies                         */
	float        HighCut;           /* [r/w] 20.0   20000.0 20000.0 Relative room effect level at high frequencies                        */
	float        EarlyLateMix;      /* [r/w] 0.0    100.0   50.0    Early reflections level relative to room effect                       */
	float        WetLevel;          /* [r/w] -80.0  20.0    -6.0    Room effect level (at mid frequencies)                                */
}

//static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_OFF              = {  1000,    7,  11, 5000, 100, 100, 100, 250, 0,    20,  96, -80.0f };
/+
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_GENERIC          = {  1500,    7,  11, 5000,  83, 100, 100, 250, 0, 14500,  96,  -8.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_PADDEDCELL       = {   170,    1,   2, 5000,  10, 100, 100, 250, 0,   160,  84,  -7.8f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_ROOM             = {   400,    2,   3, 5000,  83, 100, 100, 250, 0,  6050,  88,  -9.4f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_BATHROOM         = {  1500,    7,  11, 5000,  54, 100,  60, 250, 0,  2900,  83,   0.5f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_LIVINGROOM       = {   500,    3,   4, 5000,  10, 100, 100, 250, 0,   160,  58, -19.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_STONEROOM        = {  2300,   12,  17, 5000,  64, 100, 100, 250, 0,  7800,  71,  -8.5f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_AUDITORIUM       = {  4300,   20,  30, 5000,  59, 100, 100, 250, 0,  5850,  64, -11.7f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_CONCERTHALL      = {  3900,   20,  29, 5000,  70, 100, 100, 250, 0,  5650,  80,  -9.8f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_CAVE             = {  2900,   15,  22, 5000, 100, 100, 100, 250, 0, 20000,  59, -11.3f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_ARENA            = {  7200,   20,  30, 5000,  33, 100, 100, 250, 0,  4500,  80,  -9.6f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_HANGAR           = { 10000,   20,  30, 5000,  23, 100, 100, 250, 0,  3400,  72,  -7.4f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_CARPETTEDHALLWAY = {   300,    2,  30, 5000,  10, 100, 100, 250, 0,   500,  56, -24.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_HALLWAY          = {  1500,    7,  11, 5000,  59, 100, 100, 250, 0,  7800,  87,  -5.5f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_STONECORRIDOR    = {   270,   13,  20, 5000,  79, 100, 100, 250, 0,  9000,  86,  -6.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_ALLEY            = {  1500,    7,  11, 5000,  86, 100, 100, 250, 0,  8300,  80,  -9.8f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_FOREST           = {  1500,  162,  88, 5000,  54,  79, 100, 250, 0,   760,  94, -12.3f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_CITY             = {  1500,    7,  11, 5000,  67,  50, 100, 250, 0,  4050,  66, -26.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_MOUNTAINS        = {  1500,  300, 100, 5000,  21,  27, 100, 250, 0,  1220,  82, -24.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_QUARRY           = {  1500,   61,  25, 5000,  83, 100, 100, 250, 0,  3400, 100,  -5.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_PLAIN            = {  1500,  179, 100, 5000,  50,  21, 100, 250, 0,  1670,  65, -28.0f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_PARKINGLOT       = {  1700,    8,  12, 5000, 100, 100, 100, 250, 0, 20000,  56, -19.5f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_SEWERPIPE        = {  2800,   14,  21, 5000,  14,  80,  60, 250, 0,  3400,  66,   1.2f };
static immutable FMOD_REVERB_PROPERTIES FMOD_PRESET_UNDERWATER       = {  1500,    7,  11, 5000,  10, 100, 100, 250, 0,   500,  92,   7.0f };
+/
struct FMOD_ADVANCEDSETTINGS
{                       
	int                 cbSize;                     /* [w]   Size of this structure.  Use sizeof(FMOD_ADVANCEDSETTINGS)  NOTE: This must be set before calling System::getAdvancedSettings or System::setAdvancedSettings! */
	int                 maxMPEGCodecs;              /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  MPEG   codecs consume 22,216 bytes per instance and this number will determine how many MPEG   channels can be played simultaneously. Default = 32. */
	int                 maxADPCMCodecs;             /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  ADPCM  codecs consume  2,480 bytes per instance and this number will determine how many ADPCM  channels can be played simultaneously. Default = 32. */
	int                 maxXMACodecs;               /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  XMA    codecs consume  6,263 bytes per instance and this number will determine how many XMA    channels can be played simultaneously. Default = 32. */
	int                 maxVorbisCodecs;            /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  Vorbis codecs consume 16,512 bytes per instance and this number will determine how many Vorbis channels can be played simultaneously. Default = 32. */    
	int                 maxAT9Codecs;               /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  AT9    codecs consume 20,664 bytes per instance and this number will determine how many AT9    channels can be played simultaneously. Default = 32. */    
	int                 maxFADPCMCodecs;            /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_CREATECOMPRESSEDSAMPLE only.  FADPCM codecs consume  2,232 bytes per instance and this number will determine how many FADPCM channels can be played simultaneously. Default = 32. */
	int                 maxPCMCodecs;               /* [r/w] Optional. Specify 0 to ignore. For use with PS3 only.                          PCM    codecs consume  2,536 bytes per instance and this number will determine how many streams and PCM voices can be played simultaneously. Default = 32. */
	int                 ASIONumChannels;            /* [r/w] Optional. Specify 0 to ignore. Number of channels available on the ASIO device. */
	char              **ASIOChannelList;            /* [r/w] Optional. Specify 0 to ignore. Pointer to an array of strings (number of entries defined by ASIONumChannels) with ASIO channel names. */
	FMOD_SPEAKER       *ASIOSpeakerList;            /* [r/w] Optional. Specify 0 to ignore. Pointer to a list of speakers that the ASIO channels map to.  This can be called after System::init to remap ASIO output. */
	float               HRTFMinAngle;               /* [r/w] Optional.                      For use with FMOD_INIT_HRTF_LOWPASS.  The angle range (0-360) of a 3D sound in relation to the listener, at which the HRTF function begins to have an effect. 0 = in front of the listener. 180 = from 90 degrees to the left of the listener to 90 degrees to the right. 360 = behind the listener. Default = 180.0. */
	float               HRTFMaxAngle;               /* [r/w] Optional.                      For use with FMOD_INIT_HRTF_LOWPASS.  The angle range (0-360) of a 3D sound in relation to the listener, at which the HRTF function has maximum effect. 0 = front of the listener. 180 = from 90 degrees to the left of the listener to 90 degrees to the right. 360 = behind the listener. Default = 360.0. */
	float               HRTFFreq;                   /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_INIT_HRTF_LOWPASS.  The cutoff frequency of the HRTF's lowpass filter function when at maximum effect. (i.e. at HRTFMaxAngle).  Default = 4000.0. */
	float               vol0virtualvol;             /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_INIT_VOL0_BECOMES_VIRTUAL.  If this flag is used, and the volume is below this, then the sound will become virtual.  Use this value to raise the threshold to a different point where a sound goes virtual. */
	uint                defaultDecodeBufferSize;    /* [r/w] Optional. Specify 0 to ignore. For streams. This determines the default size of the double buffer (in milliseconds) that a stream uses.  Default = 400ms */
	ushort              profilePort;                /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_INIT_PROFILE_ENABLE.  Specify the port to listen on for connections by the profiler application. */
	uint                geometryMaxFadeTime;        /* [r/w] Optional. Specify 0 to ignore. The maximum time in miliseconds it takes for a channel to fade to the new level when its occlusion changes. */
	float               distanceFilterCenterFreq;   /* [r/w] Optional. Specify 0 to ignore. For use with FMOD_INIT_DISTANCE_FILTERING.  The default center frequency in Hz for the distance filtering effect. Default = 1500.0. */
	int                 reverb3Dinstance;           /* [r/w] Optional. Specify 0 to ignore. Out of 0 to 3, 3d reverb spheres will create a phyical reverb unit on this instance slot.  See FMOD_REVERB_PROPERTIES. */
	int                 DSPBufferPoolSize;          /* [r/w] Optional. Specify 0 to ignore. Number of buffers in DSP buffer pool.  Each buffer will be DSPBlockSize * sizeof(float) * SpeakerModeChannelCount.  ie 7.1 @ 1024 DSP block size = 8 * 1024 * 4 = 32kb.  Default = 8. */
	uint                stackSizeStream;            /* [r/w] Optional. Specify 0 to ignore. Specify the stack size for the FMOD Stream thread in bytes.  Useful for custom codecs that use excess stack.  Default 49,152 (48kb) */
	uint                stackSizeNonBlocking;       /* [r/w] Optional. Specify 0 to ignore. Specify the stack size for the FMOD_NONBLOCKING loading thread.  Useful for custom codecs that use excess stack.  Default 65,536 (64kb) */
	uint                stackSizeMixer;             /* [r/w] Optional. Specify 0 to ignore. Specify the stack size for the FMOD mixer thread.  Useful for custom dsps that use excess stack.  Default 49,152 (48kb) */
	FMOD_DSP_RESAMPLER  resamplerMethod;            /* [r/w] Optional. Specify 0 to ignore. Resampling method used with fmod's software mixer.  See FMOD_DSP_RESAMPLER for details on methods. */
	uint                commandQueueSize;           /* [r/w] Optional. Specify 0 to ignore. Specify the command queue size for thread safe processing.  Default 2048 (2kb) */
	uint                randomSeed;                 /* [r/w] Optional. Specify 0 to ignore. Seed value that FMOD will use to initialize its internal random number generators. */
}

static immutable FMOD_DRIVER_STATE_CONNECTED = 0x00000001;  /* Device is currently plugged in. */
static immutable FMOD_DRIVER_STATE_DEFAULT   = 0x00000002;  /* Device is the users preferred choice. */
