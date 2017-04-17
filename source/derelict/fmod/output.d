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
module derelict.fmod.output;

import derelict.fmod.common;

align(1):

static immutable FMOD_OUTPUT_PLUGIN_VERSION = 1;

alias FMOD_OUTPUT_GETNUMDRIVERS_CALLBACK = FMOD_RESULT  function(FMOD_OUTPUT_STATE *output_state, int *numdrivers);
alias FMOD_OUTPUT_GETDRIVERINFO_CALLBACK = FMOD_RESULT  function(FMOD_OUTPUT_STATE *output, int id, char *name, int namelen, FMOD_GUID *guid, int *systemrate, FMOD_SPEAKERMODE *speakermode, int *speakermodechannels);
alias FMOD_OUTPUT_INIT_CALLBACK = FMOD_RESULT           function(FMOD_OUTPUT_STATE *output_state, int selecteddriver, FMOD_INITFLAGS flags, int *outputrate, FMOD_SPEAKERMODE *speakermode, int *speakermodechannels, FMOD_SOUND_FORMAT *outputformat, int dspbufferlength, int dspnumbuffers, void *extradriverdata);
alias FMOD_OUTPUT_START_CALLBACK = FMOD_RESULT          function(FMOD_OUTPUT_STATE *output_state);
alias FMOD_OUTPUT_STOP_CALLBACK = FMOD_RESULT           function(FMOD_OUTPUT_STATE *output_state);
alias FMOD_OUTPUT_CLOSE_CALLBACK = FMOD_RESULT          function(FMOD_OUTPUT_STATE *output_state);
alias FMOD_OUTPUT_UPDATE_CALLBACK = FMOD_RESULT         function(FMOD_OUTPUT_STATE *output_state);
alias FMOD_OUTPUT_GETHANDLE_CALLBACK = FMOD_RESULT       function(FMOD_OUTPUT_STATE *output_state, void **handle);
alias FMOD_OUTPUT_GETPOSITION_CALLBACK = FMOD_RESULT     function(FMOD_OUTPUT_STATE *output_state, uint *pcm);
alias FMOD_OUTPUT_LOCK_CALLBACK = FMOD_RESULT            function(FMOD_OUTPUT_STATE *output_state, uint offset, uint length, void **ptr1, void **ptr2, uint *len1, uint *len2);
alias FMOD_OUTPUT_UNLOCK_CALLBACK = FMOD_RESULT          function(FMOD_OUTPUT_STATE *output_state, void *ptr1, void *ptr2, uint len1, uint len2);
alias FMOD_OUTPUT_MIXER_CALLBACK = FMOD_RESULT           function(FMOD_OUTPUT_STATE *output_state);

alias FMOD_OUTPUT_OBJECT3DGETINFO_CALLBACK = FMOD_RESULT    function(FMOD_OUTPUT_STATE *output_state, int *maxhardwareobjects);
alias FMOD_OUTPUT_OBJECT3DALLOC_CALLBACK = FMOD_RESULT      function(FMOD_OUTPUT_STATE *output_state, void **object3d);
alias FMOD_OUTPUT_OBJECT3DFREE_CALLBACK = FMOD_RESULT       function(FMOD_OUTPUT_STATE *output_state, void *object3d);
alias FMOD_OUTPUT_OBJECT3DUPDATE_CALLBACK = FMOD_RESULT     function(FMOD_OUTPUT_STATE *output_state, void *object3d, const FMOD_OUTPUT_OBJECT3DINFO *info);

alias FMOD_OUTPUT_READFROMMIXER = FMOD_RESULT           function(FMOD_OUTPUT_STATE *output_state, void *buffer, uint length);  /* This one is called by plugin through FMOD_OUTPUT_STATE, not set by user as a callback. */
alias FMOD_OUTPUT_ALLOC = void*                         function(uint size, uint align_, const(char) *file, int line);
alias FMOD_OUTPUT_FREE = void                           function(void *ptr, const(char) *file, int line);
alias FMOD_OUTPUT_LOG = void                            function(FMOD_DEBUG_FLAGS level, const(char) *file, int line, const(char) *function_, const(char) *string, ...);
 

struct FMOD_OUTPUT_DESCRIPTION
{
    uint                            apiversion;         /* [w] The output plugin API version this plugin is built for. Set to this to FMOD_OUTPUT_PLUGIN_VERSION defined above. */
    const(char)                         *name;                  /* [in] Name of the output. */
    uint                                version_;               /* [in] Plugin writer's version number. */
    int                                 polling;               /* [in] If TRUE (non zero), this tells FMOD to start a thread and call getposition / lock / unlock for feeding data.  If 0, the output is probably callback based, so all the plugin needs to do is call readfrommixer to the appropriate pointer. */ 
    FMOD_OUTPUT_GETNUMDRIVERS_CALLBACK  getnumdrivers;         /* [in] For sound device enumeration.  This callback is to give System::getNumDrivers somthing to return. */
    FMOD_OUTPUT_GETDRIVERINFO_CALLBACK  getdriverinfo;         /* [in] For sound device enumeration.  This callback is to give System::getDriverName somthing to return. */
    FMOD_OUTPUT_INIT_CALLBACK           init;                  /* [in] Initialization function for the output device.  This is called from System::init. */
    FMOD_OUTPUT_START_CALLBACK          start;                 /* [in] Initialization function for the output device to start accepting audio data from the FMOD software mixer.  This is called from System::init. */
    FMOD_OUTPUT_STOP_CALLBACK           stop;                  /* [in] Initialization function for the output device to stop accepting audio data from FMOD the software mixer.  This is called from System::close. */
    FMOD_OUTPUT_CLOSE_CALLBACK          close;                 /* [in] Cleanup / close down function for the output device.  This is called from System::close. */
    FMOD_OUTPUT_UPDATE_CALLBACK         update;                /* [in] Update function that is called once a frame by the user.  This is called from System::update. */
    FMOD_OUTPUT_GETHANDLE_CALLBACK      gethandle;             /* [in] This is called from System::getOutputHandle.  This is just to return a pointer to the internal system device object that the system may be using.*/
    FMOD_OUTPUT_GETPOSITION_CALLBACK    getposition;           /* [in] This is called from the FMOD software mixer thread if 'polling' = true.  This returns a position value in samples so that FMOD knows where and when to fill its buffer. */
    FMOD_OUTPUT_LOCK_CALLBACK           lock;                  /* [in] This is called from the FMOD software mixer thread if 'polling' = true.  This function provides a pointer to data that FMOD can write to when software mixing. */
    FMOD_OUTPUT_UNLOCK_CALLBACK         unlock;                /* [in] This is called from the FMOD software mixer thread if 'polling' = true.  This optional function accepts the data that has been mixed and copies it or does whatever it needs to before sending it to the hardware. */
    FMOD_OUTPUT_MIXER_CALLBACK              mixer;              /* [w] ('polling' == FALSE) Mixer thread that will continually retrigger. Wait on a synchronization primitive until ready, then call FMOD_OUTPUT_READFROMMIXER, then leave the callback (will retrigger immediately if mixer is still running). Called continually after FMOD_OUTPUT_START_CALLBACK and before FMOD_OUTPUT_STOP_CALLBACK. */
    FMOD_OUTPUT_OBJECT3DGETINFO_CALLBACK    object3dgetinfo;    /* [w] Provide information about the capabilities of the 3D object hardware. Called during a mix. */
    FMOD_OUTPUT_OBJECT3DALLOC_CALLBACK      object3dalloc;      /* [w] Reserve a hardware resources for a single 3D object. Called during a mix. */
    FMOD_OUTPUT_OBJECT3DFREE_CALLBACK       object3dfree;       /* [w] Release a hardware resource previously acquired with FMOD_OUTPUT_OBJECT3DALLOC_CALLBACK. Called during a mix. */
    FMOD_OUTPUT_OBJECT3DUPDATE_CALLBACK     object3dupdate;     /* [w] Called once for every acquired 3D object every mix to provide 3D information and buffered audio. Called during a mix. */
}

struct FMOD_OUTPUT_STATE
{
    void                      *plugindata;      /* [in] Plugin writer created data the output author wants to attach to this object. */
    FMOD_OUTPUT_READFROMMIXER   readfrommixer;  /* [r] Function to execute the mixer producing a buffer of audio. Used to control when the mix occurs manually as an alternative to FMOD_OUTPUT_DESCRIPTION::polling == TRUE. */
    FMOD_OUTPUT_ALLOC           alloc;          /* [r] Function to allocate memory using the FMOD memory system. */
    FMOD_OUTPUT_FREE            free;           /* [r] Function to free memory allocated with FMOD_OUTPUT_ALLOC. */
    FMOD_OUTPUT_LOG             log;            /* [r] Function to write to the FMOD logging system. */
}

struct FMOD_OUTPUT_OBJECT3DINFO
{
    float          *buffer;         /* [r] Mono PCM floating point buffer. This buffer needs to be scaled by the gain value to get distance attenuation.  */
    uint            bufferlength;   /* [r] Length in PCM samples of buffer. */
    FMOD_VECTOR     position;       /* [r] Vector relative between object and listener. */
    float           gain;           /* [r] 0.0 to 1.0 - 1 = 'buffer' is not attenuated, 0 = 'buffer' is fully attenuated. */
    float           spread;         /* [r] 0 - 360 degrees.  0 = point source, 360 = sound is spread around all speakers */
    float           priority;       /* [r] 0.0 to 1.0 - 0 = most important, 1 = least important. Based on height and distance (height is more important). */
}