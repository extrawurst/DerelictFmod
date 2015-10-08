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
module derelict.fmod.codec;

import derelict.util.system;

import derelict.fmod.common;

alias FMOD_CODEC_OPEN_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, FMOD_MODE usermode, FMOD_CREATESOUNDEXINFO *userexinfo);
alias FMOD_CODEC_CLOSE_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state);
alias FMOD_CODEC_READ_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, void *buffer, uint samples_in, uint *samples_out);
alias FMOD_CODEC_GETLENGTH_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, uint *length, FMOD_TIMEUNIT lengthtype);
alias FMOD_CODEC_SETPOSITION_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, int subsound, uint position, FMOD_TIMEUNIT postype);
alias FMOD_CODEC_GETPOSITION_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, uint *position, FMOD_TIMEUNIT postype);
alias FMOD_CODEC_SOUNDCREATE_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, int subsound, FMOD_SOUND *sound);
alias FMOD_CODEC_METADATA_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, FMOD_TAGTYPE tagtype, char *name, void *data, uint datalen, FMOD_TAGDATATYPE datatype, int unique);
alias FMOD_CODEC_GETWAVEFORMAT_CALLBACK = FMOD_RESULT function(FMOD_CODEC_STATE *codec_state, int index, FMOD_CODEC_WAVEFORMAT *waveformat);

struct FMOD_CODEC_DESCRIPTION
{
    const(char)                       *name;            /* [w] Name of the codec. */
    uint                              version_;         /* [w] Plugin writer's version number. */
    int                               defaultasstream; /* [w] Tells FMOD to open the file as a stream when calling System::createSound, and not a static sample.  Should normally be 0 (FALSE), because generally the user wants to decode the file into memory when using System::createSound.   Mainly used for formats that decode for a very long time, or could use large amounts of memory when decoded.  Usually sequenced formats such as mod/s3m/xm/it/midi fall into this category.   It is mainly to stop users that don't know what they're doing from getting FMOD_ERR_MEMORY returned from createSound when they should have in fact called System::createStream or used FMOD_CREATESTREAM in System::createSound. */
    FMOD_TIMEUNIT                     timeunits;       /* [w] When setposition codec is called, only these time formats will be passed to the codec. Use bitwise OR to accumulate different types. */
    FMOD_CODEC_OPEN_CALLBACK          open;            /* [w] Open callback for the codec for when FMOD tries to open a sound using this codec. */
    FMOD_CODEC_CLOSE_CALLBACK         close;           /* [w] Close callback for the codec for when FMOD tries to close a sound using this codec.  */
    FMOD_CODEC_READ_CALLBACK          read;            /* [w] Read callback for the codec for when FMOD tries to read some data from the file to the destination format (specified in the open callback). */
    FMOD_CODEC_GETLENGTH_CALLBACK     getlength;       /* [w] Callback to return the length of the song in whatever format required when Sound::getLength is called. */
    FMOD_CODEC_SETPOSITION_CALLBACK   setposition;     /* [w] Seek callback for the codec for when FMOD tries to seek within the file with Channel::setPosition. */
    FMOD_CODEC_GETPOSITION_CALLBACK   getposition;     /* [w] Tell callback for the codec for when FMOD tries to get the current position within the with Channel::getPosition. */
    FMOD_CODEC_SOUNDCREATE_CALLBACK   soundcreate;     /* [w] Sound creation callback for the codec when FMOD finishes creating the sound.  (So the codec can set more parameters for the related created sound, ie loop points/mode or 3D attributes etc). */
    FMOD_CODEC_GETWAVEFORMAT_CALLBACK getwaveformat;   /* [w] Callback to tell FMOD about the waveformat of a particular subsound.  This is to save memory, rather than saving 1000 FMOD_CODEC_WAVEFORMAT structures in the codec, the codec might have a more optimal way of storing this information. */
}

struct FMOD_CODEC_WAVEFORMAT
{
    char[256]          name;     /* [w] Name of sound.  Optional. */
    FMOD_SOUND_FORMAT  format;        /* [w] Format for (decompressed) codec output, ie FMOD_SOUND_FORMAT_PCM8, FMOD_SOUND_FORMAT_PCM16.  Mandantory - Must be supplied. */
    int                channels;      /* [w] Number of channels used by codec, ie mono = 1, stereo = 2.  Mandantory - Must be supplied.  */
    int                frequency;     /* [w] Default frequency in hz of the codec, ie 44100.  Mandantory - Must be supplied.  */
    uint               lengthbytes;   /* [w] Length in bytes of the source data.  Used for FMOD_TIMEUNIT_RAWBYTES.  Optional. Default = 0. */
    uint               lengthpcm;     /* [w] Length in decompressed, PCM samples of the file, ie length in seconds * frequency.  Used for Sound::getLength and for memory allocation of static decompressed sample data.  Mandantory - Must be supplied. */
    uint               pcmblocksize;  /* [w] Minimum, optimal number of decompressed PCM samples codec can handle.  0 or 1 = no buffering.  Anything higher means FMOD will allocate a PCM buffer of this size to read in chunks.  The codec read callback will be called in multiples of this value.  Optional.  */
    int                loopstart;     /* [w] Loopstart in decompressed, PCM samples of file. Optional. Default = 0. */
    int                loopend;       /* [w] Loopend in decompressed, PCM samples of file. Optional. Default = 0. */
    FMOD_MODE          mode;          /* [w] Mode to determine whether the sound should by default load as looping, non looping, 2d or 3d.  Optional. Default = FMOD_DEFAULT. */
    FMOD_CHANNELMASK   channelmask;   /* [w] Defined channel bitmask to describe which speakers the channels in the codec map to, in order of channel count.  See fmod_common.h.  Optional. Leave at 0 to map to the speaker layout defined in FMOD_SPEAKER. */
    FMOD_CHANNELORDER  channelorder;  /* [w] Defined channel order type, to describe where each sound channel should pan for the number of channels specified.  See fmod_common.h.  Optional.  Leave at 0 to play in default speaker order. */
    float              peakvolume;    /* [w] Peak volume of sound. Optional. Default = 0 if not used. */
}

static immutable FMOD_CODEC_WAVEFORMAT_VERSION = 2;

struct FMOD_CODEC_STATE
{
    int                          numsubsounds;      /* [w] Number of 'subsounds' in this sound.  Anything other than 0 makes it a 'container' format (ie DLS/FSB etc which contain 1 or more subsounds).  For most normal, single sound codec such as WAV/AIFF/MP3, this should be 0 as they are not a container for subsounds, they are the sound by itself. */
    FMOD_CODEC_WAVEFORMAT       *waveformat;        /* [w] Pointer to an array of format structures containing information about each sample.  Can be 0 or NULL if FMOD_CODEC_GETWAVEFORMAT_CALLBACK callback is preferred.  The number of entries here must equal the number of subsounds defined in the subsound parameter. If numsubsounds = 0 then there should be 1 instance of this structure. */
    void                        *plugindata;        /* [w] Plugin writer created data the codec author wants to attach to this object. */
    
    void                        *filehandle;        /* [r] This will return an internal FMOD file handle to use with the callbacks provided.  */
    uint                         filesize;          /* [r] This will contain the size of the file in bytes. */
    FMOD_FILE_READ_CALLBACK      fileread;          /* [r] This will return a callable FMOD file function to use from codec. */
    FMOD_FILE_SEEK_CALLBACK      fileseek;          /* [r] This will return a callable FMOD file function to use from codec.  */
    FMOD_CODEC_METADATA_CALLBACK metadata;          /* [r] This will return a callable FMOD metadata function to use from codec.  */
    
    int                          waveformatversion; /* [w] Must be set to FMOD_CODEC_WAVEFORMAT_VERSION in the FMOD_CODEC_OPEN_CALLBACK. */
}