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
module derelict.fmod.output;

import derelict.fmod.common;

align(1):

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
alias FMOD_OUTPUT_READFROMMIXER = FMOD_RESULT           function(FMOD_OUTPUT_STATE *output_state, void *buffer, uint length);  /* This one is called by plugin through FMOD_OUTPUT_STATE, not set by user as a callback. */

struct FMOD_OUTPUT_DESCRIPTION
{
    const char                        *name;                  /* [in] Name of the output. */
    uint                       version_;               /* [in] Plugin writer's version number. */
    int                                polling;               /* [in] If TRUE (non zero), this tells FMOD to start a thread and call getposition / lock / unlock for feeding data.  If 0, the output is probably callback based, so all the plugin needs to do is call readfrommixer to the appropriate pointer. */ 
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
}

struct FMOD_OUTPUT_STATE
{
    void                      *plugindata;      /* [in] Plugin writer created data the output author wants to attach to this object. */
    FMOD_OUTPUT_READFROMMIXER  readfrommixer;   /* [out] Function to update mixer and write the result to the provided pointer.  Used from callback based output only.  Polling based output uses lock/unlock/getposition. */
}
