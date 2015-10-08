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
module derelict.fmod.funcs;

private
{
    import derelict.util.system;
    import derelict.fmod.codec;
    import derelict.fmod.dsp;
    import derelict.fmod.dsp_effects;
    import derelict.fmod.output;
    import derelict.fmod.common;
}

extern(C) @nogc nothrow
{
    /*
    FMOD global system functions (optional).
*/
    
    alias da_FMOD_Memory_Initialize = FMOD_RESULT function(void *poolmem, int poollen, FMOD_MEMORY_ALLOC_CALLBACK useralloc, FMOD_MEMORY_REALLOC_CALLBACK userrealloc, FMOD_MEMORY_FREE_CALLBACK userfree, FMOD_MEMORY_TYPE memtypeflags);
    alias da_FMOD_Memory_GetStats = FMOD_RESULT function(int *currentalloced, int *maxalloced, FMOD_BOOL blocking);
    alias da_FMOD_Debug_Initialize = FMOD_RESULT function(FMOD_DEBUG_FLAGS flags, FMOD_DEBUG_MODE mode, FMOD_DEBUG_CALLBACK callback, const char *filename);
    alias da_FMOD_File_SetDiskBusy = FMOD_RESULT function(int busy);
    alias da_FMOD_File_GetDiskBusy = FMOD_RESULT function(int *busy);
    
    /*
    FMOD System factory functions.  Use this to create an FMOD System Instance.  below you will see FMOD_System_Init/Close to get started.
*/
    
    alias da_FMOD_System_Create = FMOD_RESULT function(FMOD_SYSTEM **system); 
    alias da_FMOD_System_Release = FMOD_RESULT function(FMOD_SYSTEM *system); 
    
    /*$ preserve end $*/
    
    /*
    'System' API
*/
    
    /*
     Setup functions.
*/
    
    alias da_FMOD_System_SetOutput = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_OUTPUTTYPE output);
    alias da_FMOD_System_GetOutput = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_OUTPUTTYPE *output);
    alias da_FMOD_System_GetNumDrivers = FMOD_RESULT function(FMOD_SYSTEM *system, int *numdrivers);
    alias da_FMOD_System_GetDriverInfo = FMOD_RESULT function(FMOD_SYSTEM *system, int id, char *name, int namelen, FMOD_GUID *guid, int *systemrate, FMOD_SPEAKERMODE *speakermode, int *speakermodechannels);
    alias da_FMOD_System_SetDriver = FMOD_RESULT function(FMOD_SYSTEM *system, int driver);
    alias da_FMOD_System_GetDriver = FMOD_RESULT function(FMOD_SYSTEM *system, int *driver);
    alias da_FMOD_System_SetSoftwareChannels = FMOD_RESULT function(FMOD_SYSTEM *system, int numsoftwarechannels);
    alias da_FMOD_System_GetSoftwareChannels = FMOD_RESULT function(FMOD_SYSTEM *system, int *numsoftwarechannels);
    alias da_FMOD_System_SetSoftwareFormat = FMOD_RESULT function(FMOD_SYSTEM *system, int samplerate, FMOD_SPEAKERMODE speakermode, int numrawspeakers);
    alias da_FMOD_System_GetSoftwareFormat = FMOD_RESULT function(FMOD_SYSTEM *system, int *samplerate, FMOD_SPEAKERMODE *speakermode, int *numrawspeakers);
    alias da_FMOD_System_SetDSPBufferSize = FMOD_RESULT function(FMOD_SYSTEM *system, uint bufferlength, int numbuffers);
    alias da_FMOD_System_GetDSPBufferSize = FMOD_RESULT function(FMOD_SYSTEM *system, uint *bufferlength, int *numbuffers);
    alias da_FMOD_System_SetFileSystem = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_FILE_OPEN_CALLBACK useropen, FMOD_FILE_CLOSE_CALLBACK userclose, FMOD_FILE_READ_CALLBACK userread, FMOD_FILE_SEEK_CALLBACK userseek, FMOD_FILE_ASYNCREAD_CALLBACK userasyncread, FMOD_FILE_ASYNCCANCEL_CALLBACK userasynccancel, int blockalign);
    alias da_FMOD_System_AttachFileSystem = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_FILE_OPEN_CALLBACK useropen, FMOD_FILE_CLOSE_CALLBACK userclose, FMOD_FILE_READ_CALLBACK userread, FMOD_FILE_SEEK_CALLBACK userseek);
    alias da_FMOD_System_SetAdvancedSettings = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_ADVANCEDSETTINGS *settings);
    alias da_FMOD_System_GetAdvancedSettings = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_ADVANCEDSETTINGS *settings);
    alias da_FMOD_System_SetCallback = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SYSTEM_CALLBACK callback, FMOD_SYSTEM_CALLBACK_TYPE callbackmask);
    
    /*
     Plug-in support.
*/
    
    alias da_FMOD_System_SetPluginPath = FMOD_RESULT function(FMOD_SYSTEM *system, const char *path);
    alias da_FMOD_System_LoadPlugin = FMOD_RESULT function(FMOD_SYSTEM *system, const char *filename,  uint *handle,  uint priority);
    alias da_FMOD_System_UnloadPlugin = FMOD_RESULT function(FMOD_SYSTEM *system,  uint handle);
    alias da_FMOD_System_GetNumPlugins = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_PLUGINTYPE plugintype, int *numplugins);
    alias da_FMOD_System_GetPluginHandle = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_PLUGINTYPE plugintype, int index,  uint *handle);
    alias da_FMOD_System_GetPluginInfo = FMOD_RESULT function(FMOD_SYSTEM *system, uint handle, FMOD_PLUGINTYPE *plugintype, char *name, int namelen, uint  *version__);
    alias da_FMOD_System_SetOutputByPlugin = FMOD_RESULT function(FMOD_SYSTEM *system, uint handle);
    alias da_FMOD_System_GetOutputByPlugin = FMOD_RESULT function(FMOD_SYSTEM *system, uint *handle);
    alias da_FMOD_System_CreateDSPByPlugin = FMOD_RESULT function(FMOD_SYSTEM *system, uint handle, FMOD_DSP **dsp);
    alias da_FMOD_System_GetDSPInfoByPlugin = FMOD_RESULT function(FMOD_SYSTEM *system, uint handle, const FMOD_DSP_DESCRIPTION **description);
    alias da_FMOD_System_RegisterCodec = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_CODEC_DESCRIPTION *description,  uint *handle,  uint priority);
    alias da_FMOD_System_RegisterDSP = FMOD_RESULT function(FMOD_SYSTEM *system, const FMOD_DSP_DESCRIPTION *description,  uint *handle);
    alias da_FMOD_System_RegisterOutput = FMOD_RESULT function(FMOD_SYSTEM *system, const FMOD_OUTPUT_DESCRIPTION *description,  uint *handle);
    
    /*
     Init/Close.
*/
    
    alias da_FMOD_System_Init = FMOD_RESULT function(FMOD_SYSTEM *system, int maxchannels, FMOD_INITFLAGS flags, void *extradriverdata);
    alias da_FMOD_System_Close = FMOD_RESULT function(FMOD_SYSTEM *system);
    
    /*
     General post-init system functions.
*/
    
    alias da_FMOD_System_Update = FMOD_RESULT function(FMOD_SYSTEM *system);
    
    alias da_FMOD_System_SetSpeakerPosition = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SPEAKER speaker, float x, float y, FMOD_BOOL active);
    alias da_FMOD_System_GetSpeakerPosition = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SPEAKER speaker, float *x, float *y, FMOD_BOOL *active);
    alias da_FMOD_System_SetStreamBufferSize = FMOD_RESULT function(FMOD_SYSTEM *system,  uint filebuffersize, FMOD_TIMEUNIT filebuffersizetype);
    alias da_FMOD_System_GetStreamBufferSize = FMOD_RESULT function(FMOD_SYSTEM *system,  uint *filebuffersize, FMOD_TIMEUNIT *filebuffersizetype);
    alias da_FMOD_System_Set3DSettings = FMOD_RESULT function(FMOD_SYSTEM *system, float dopplerscale, float distancefactor, float rolloffscale);
    alias da_FMOD_System_Get3DSettings = FMOD_RESULT function(FMOD_SYSTEM *system, float *dopplerscale, float *distancefactor, float *rolloffscale);
    alias da_FMOD_System_Set3DNumListeners = FMOD_RESULT function(FMOD_SYSTEM *system, int numlisteners);
    alias da_FMOD_System_Get3DNumListeners = FMOD_RESULT function(FMOD_SYSTEM *system, int *numlisteners);
    alias da_FMOD_System_Set3DListenerAttributes = FMOD_RESULT function(FMOD_SYSTEM *system, int listener, const FMOD_VECTOR *pos, const FMOD_VECTOR *vel, const FMOD_VECTOR *forward, const FMOD_VECTOR *up);
    alias da_FMOD_System_Get3DListenerAttributes = FMOD_RESULT function(FMOD_SYSTEM *system, int listener, FMOD_VECTOR *pos, FMOD_VECTOR *vel, FMOD_VECTOR *forward, FMOD_VECTOR *up);
    alias da_FMOD_System_Set3DRolloffCallback = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_3D_ROLLOFF_CALLBACK callback);
    alias da_FMOD_System_MixerSuspend = FMOD_RESULT function(FMOD_SYSTEM *system);
    alias da_FMOD_System_MixerResume = FMOD_RESULT function(FMOD_SYSTEM *system);
    alias da_FMOD_System_GetDefaultMixMatrix = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SPEAKERMODE sourcespeakermode, FMOD_SPEAKERMODE targetspeakermode, float *matrix, int matrixhop);
    alias da_FMOD_System_GetSpeakerModeChannels = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SPEAKERMODE mode, int *channels);
    
    /*
     System information functions.
*/
    
    alias da_FMOD_System_GetVersion = FMOD_RESULT function(FMOD_SYSTEM *system,  uint  *version_);
    alias da_FMOD_System_GetOutputHandle = FMOD_RESULT function(FMOD_SYSTEM *system, void **handle);
    alias da_FMOD_System_GetChannelsPlaying = FMOD_RESULT function(FMOD_SYSTEM *system, int *channels);
    alias da_FMOD_System_GetCPUUsage = FMOD_RESULT function(FMOD_SYSTEM *system, float *dsp, float *stream, float *geometry, float *update, float *total);
    alias da_FMOD_System_GetSoundRAM = FMOD_RESULT function(FMOD_SYSTEM *system, int *currentalloced, int *maxalloced, int *total);
    
    /*
     Sound/DSP/Channel/FX creation and retrieval.
*/
    
    alias da_FMOD_System_CreateSound = FMOD_RESULT function(FMOD_SYSTEM *system, const char *name_or_data, FMOD_MODE mode, FMOD_CREATESOUNDEXINFO *exinfo, FMOD_SOUND **sound);
    alias da_FMOD_System_CreateStream = FMOD_RESULT function(FMOD_SYSTEM *system, const char *name_or_data, FMOD_MODE mode, FMOD_CREATESOUNDEXINFO *exinfo, FMOD_SOUND **sound);
    alias da_FMOD_System_CreateDSP = FMOD_RESULT function(FMOD_SYSTEM *system, const FMOD_DSP_DESCRIPTION *description, FMOD_DSP **dsp);
    alias da_FMOD_System_CreateDSPByType = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_DSP_TYPE type, FMOD_DSP **dsp);
    alias da_FMOD_System_CreateChannelGroup = FMOD_RESULT function(FMOD_SYSTEM *system, const char *name, FMOD_CHANNELGROUP **channelgroup);
    alias da_FMOD_System_CreateSoundGroup = FMOD_RESULT function(FMOD_SYSTEM *system, const char *name, FMOD_SOUNDGROUP **soundgroup);
    alias da_FMOD_System_CreateReverb3D = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_REVERB3D **reverb);
    
    alias da_FMOD_System_PlaySound = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SOUND *sound, FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL paused, FMOD_CHANNEL **channel);
    alias da_FMOD_System_PlayDSP = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_DSP *dsp, FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL paused, FMOD_CHANNEL **channel);
    alias da_FMOD_System_GetChannel = FMOD_RESULT function(FMOD_SYSTEM *system, int channelid, FMOD_CHANNEL **channel);
    alias da_FMOD_System_GetMasterChannelGroup = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_CHANNELGROUP **channelgroup);
    alias da_FMOD_System_GetMasterSoundGroup = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_SOUNDGROUP **soundgroup);
    
    /*
     Routing to ports.
*/
    
    alias da_FMOD_System_AttachChannelGroupToPort = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_PORT_TYPE portType, FMOD_PORT_INDEX portIndex, FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL passThru);
    alias da_FMOD_System_DetachChannelGroupFromPort = FMOD_RESULT function(FMOD_SYSTEM *system, FMOD_CHANNELGROUP *channelgroup);
    
    /*
     Reverb API.
*/
    
    alias da_FMOD_System_SetReverbProperties = FMOD_RESULT function(FMOD_SYSTEM *system, int instance, const FMOD_REVERB_PROPERTIES *prop);
    alias da_FMOD_System_GetReverbProperties = FMOD_RESULT function(FMOD_SYSTEM *system, int instance, FMOD_REVERB_PROPERTIES *prop);
    
    /*
     System level DSP functionality.
*/
    
    alias da_FMOD_System_LockDSP = FMOD_RESULT function(FMOD_SYSTEM *system);
    alias da_FMOD_System_UnlockDSP = FMOD_RESULT function(FMOD_SYSTEM *system);
    
    /*
     Recording API.
*/
    
    alias da_FMOD_System_GetRecordNumDrivers = FMOD_RESULT function(FMOD_SYSTEM *system, int *numdrivers, int *numconnected);
    alias da_FMOD_System_GetRecordDriverInfo = FMOD_RESULT function(FMOD_SYSTEM *system, int id, char *name, int namelen, FMOD_GUID *guid, int *systemrate, FMOD_SPEAKERMODE *speakermode, int *speakermodechannels, FMOD_DRIVER_STATE *state);
    alias da_FMOD_System_GetRecordPosition = FMOD_RESULT function(FMOD_SYSTEM *system, int id,  uint *position);
    alias da_FMOD_System_RecordStart = FMOD_RESULT function(FMOD_SYSTEM *system, int id, FMOD_SOUND *sound, FMOD_BOOL loop);
    alias da_FMOD_System_RecordStop = FMOD_RESULT function(FMOD_SYSTEM *system, int id);
    alias da_FMOD_System_IsRecording = FMOD_RESULT function(FMOD_SYSTEM *system, int id, FMOD_BOOL *recording);
    
    /*
     Geometry API.
*/
    
    alias da_FMOD_System_CreateGeometry = FMOD_RESULT function(FMOD_SYSTEM *system, int maxpolygons, int maxvertices, FMOD_GEOMETRY **geometry);
    alias da_FMOD_System_SetGeometrySettings = FMOD_RESULT function(FMOD_SYSTEM *system, float maxworldsize);
    alias da_FMOD_System_GetGeometrySettings = FMOD_RESULT function(FMOD_SYSTEM *system, float *maxworldsize);
    alias da_FMOD_System_LoadGeometry = FMOD_RESULT function(FMOD_SYSTEM *system, const void *data, int datasize, FMOD_GEOMETRY **geometry);
    alias da_FMOD_System_GetGeometryOcclusion = FMOD_RESULT function(FMOD_SYSTEM *system, const FMOD_VECTOR *listener, const FMOD_VECTOR *source, float *direct, float *reverb);
    
    /*
     Network functions.
*/
    
    alias da_FMOD_System_SetNetworkProxy = FMOD_RESULT function(FMOD_SYSTEM *system, const char *proxy);
    alias da_FMOD_System_GetNetworkProxy = FMOD_RESULT function(FMOD_SYSTEM *system, char *proxy, int proxylen);
    alias da_FMOD_System_SetNetworkTimeout = FMOD_RESULT function(FMOD_SYSTEM *system, int timeout);
    alias da_FMOD_System_GetNetworkTimeout = FMOD_RESULT function(FMOD_SYSTEM *system, int *timeout);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_System_SetUserData = FMOD_RESULT function(FMOD_SYSTEM *system, void *userdata);
    alias da_FMOD_System_GetUserData = FMOD_RESULT function(FMOD_SYSTEM *system, void **userdata);
    
    /*
    'Sound' API
*/
    
    alias da_FMOD_Sound_Release = FMOD_RESULT function(FMOD_SOUND *sound);
    alias da_FMOD_Sound_GetSystemObject = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SYSTEM **system);
    
    /*
     Standard sound manipulation functions.
*/
    
    alias da_FMOD_Sound_Lock = FMOD_RESULT function(FMOD_SOUND *sound,  uint offset,  uint length, void **ptr1, void **ptr2,  uint *len1,  uint *len2);
    alias da_FMOD_Sound_Unlock = FMOD_RESULT function(FMOD_SOUND *sound, void *ptr1, void *ptr2,  uint len1,  uint len2);
    alias da_FMOD_Sound_SetDefaults = FMOD_RESULT function(FMOD_SOUND *sound, float frequency, int priority);
    alias da_FMOD_Sound_GetDefaults = FMOD_RESULT function(FMOD_SOUND *sound, float *frequency, int *priority);
    alias da_FMOD_Sound_Set3DMinMaxDistance = FMOD_RESULT function(FMOD_SOUND *sound, float min, float max);
    alias da_FMOD_Sound_Get3DMinMaxDistance = FMOD_RESULT function(FMOD_SOUND *sound, float *min, float *max);
    alias da_FMOD_Sound_Set3DConeSettings = FMOD_RESULT function(FMOD_SOUND *sound, float insideconeangle, float outsideconeangle, float outsidevolume);
    alias da_FMOD_Sound_Get3DConeSettings = FMOD_RESULT function(FMOD_SOUND *sound, float *insideconeangle, float *outsideconeangle, float *outsidevolume);
    alias da_FMOD_Sound_Set3DCustomRolloff = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_VECTOR *points, int numpoints);
    alias da_FMOD_Sound_Get3DCustomRolloff = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_VECTOR **points, int *numpoints);
    alias da_FMOD_Sound_GetSubSound = FMOD_RESULT function(FMOD_SOUND *sound, int index, FMOD_SOUND **subsound);
    alias da_FMOD_Sound_GetSubSoundParent = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SOUND **parentsound);
    alias da_FMOD_Sound_GetName = FMOD_RESULT function(FMOD_SOUND *sound, char *name, int namelen);
    alias da_FMOD_Sound_GetLength = FMOD_RESULT function(FMOD_SOUND *sound,  uint *length, FMOD_TIMEUNIT lengthtype);
    alias da_FMOD_Sound_GetFormat = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SOUND_TYPE *type, FMOD_SOUND_FORMAT *format, int *channels, int *bits);
    alias da_FMOD_Sound_GetNumSubSounds = FMOD_RESULT function(FMOD_SOUND *sound, int *numsubsounds);
    alias da_FMOD_Sound_GetNumTags = FMOD_RESULT function(FMOD_SOUND *sound, int *numtags, int *numtagsupdated);
    alias da_FMOD_Sound_GetTag = FMOD_RESULT function(FMOD_SOUND *sound, const char *name, int index, FMOD_TAG *tag);
    alias da_FMOD_Sound_GetOpenState = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_OPENSTATE *openstate,  uint *percentbuffered, FMOD_BOOL *starving, FMOD_BOOL *diskbusy);
    alias da_FMOD_Sound_ReadData = FMOD_RESULT function(FMOD_SOUND *sound, void *buffer,  uint lenbytes,  uint *read);
    alias da_FMOD_Sound_SeekData = FMOD_RESULT function(FMOD_SOUND *sound,  uint pcm);
    
    alias da_FMOD_Sound_SetSoundGroup = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SOUNDGROUP *soundgroup);
    alias da_FMOD_Sound_GetSoundGroup = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SOUNDGROUP **soundgroup);
    
    /*
     Synchronization point API.  These points can come from markers embedded in wav files, and can also generate channel callbacks.
*/
    
    alias da_FMOD_Sound_GetNumSyncPoints = FMOD_RESULT function(FMOD_SOUND *sound, int *numsyncpoints);
    alias da_FMOD_Sound_GetSyncPoint = FMOD_RESULT function(FMOD_SOUND *sound, int index, FMOD_SYNCPOINT **point);
    alias da_FMOD_Sound_GetSyncPointInfo = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SYNCPOINT *point, char *name, int namelen,  uint *offset, FMOD_TIMEUNIT offsettype);
    alias da_FMOD_Sound_AddSyncPoint = FMOD_RESULT function(FMOD_SOUND *sound,  uint offset, FMOD_TIMEUNIT offsettype, const char *name, FMOD_SYNCPOINT **point);
    alias da_FMOD_Sound_DeleteSyncPoint = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_SYNCPOINT *point);
    
    /*
     Functions also in Channel class but here they are the 'default' to save having to change it in Channel all the time.
*/
    
    alias da_FMOD_Sound_SetMode = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_MODE mode);
    alias da_FMOD_Sound_GetMode = FMOD_RESULT function(FMOD_SOUND *sound, FMOD_MODE *mode);
    alias da_FMOD_Sound_SetLoopCount = FMOD_RESULT function(FMOD_SOUND *sound, int loopcount);
    alias da_FMOD_Sound_GetLoopCount = FMOD_RESULT function(FMOD_SOUND *sound, int *loopcount);
    alias da_FMOD_Sound_SetLoopPoints = FMOD_RESULT function(FMOD_SOUND *sound,  uint loopstart, FMOD_TIMEUNIT loopstarttype,  uint loopend, FMOD_TIMEUNIT loopendtype);
    alias da_FMOD_Sound_GetLoopPoints = FMOD_RESULT function(FMOD_SOUND *sound,  uint *loopstart, FMOD_TIMEUNIT loopstarttype,  uint *loopend, FMOD_TIMEUNIT loopendtype);
    
    /*
     For MOD/S3M/XM/IT/MID sequenced formats only.
*/
    
    alias da_FMOD_Sound_GetMusicNumChannels = FMOD_RESULT function(FMOD_SOUND *sound, int *numchannels);
    alias da_FMOD_Sound_SetMusicChannelVolume = FMOD_RESULT function(FMOD_SOUND *sound, int channel, float volume);
    alias da_FMOD_Sound_GetMusicChannelVolume = FMOD_RESULT function(FMOD_SOUND *sound, int channel, float *volume);
    alias da_FMOD_Sound_SetMusicSpeed = FMOD_RESULT function(FMOD_SOUND *sound, float speed);
    alias da_FMOD_Sound_GetMusicSpeed = FMOD_RESULT function(FMOD_SOUND *sound, float *speed);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_Sound_SetUserData = FMOD_RESULT function(FMOD_SOUND *sound, void *userdata);
    alias da_FMOD_Sound_GetUserData = FMOD_RESULT function(FMOD_SOUND *sound, void **userdata);
    
    /*
    'Channel' API
*/
    
    alias da_FMOD_Channel_GetSystemObject = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_SYSTEM **system);
    
    /*
     General control functionality for Channels and ChannelGroups.
*/
    
    alias da_FMOD_Channel_Stop = FMOD_RESULT function(FMOD_CHANNEL *channel);
    alias da_FMOD_Channel_SetPaused = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL paused);
    alias da_FMOD_Channel_GetPaused = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *paused);
    alias da_FMOD_Channel_SetVolume = FMOD_RESULT function(FMOD_CHANNEL *channel, float volume);
    alias da_FMOD_Channel_GetVolume = FMOD_RESULT function(FMOD_CHANNEL *channel, float *volume);
    alias da_FMOD_Channel_SetVolumeRamp = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL ramp);
    alias da_FMOD_Channel_GetVolumeRamp = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *ramp);
    alias da_FMOD_Channel_GetAudibility = FMOD_RESULT function(FMOD_CHANNEL *channel, float *audibility);
    alias da_FMOD_Channel_SetPitch = FMOD_RESULT function(FMOD_CHANNEL *channel, float pitch);
    alias da_FMOD_Channel_GetPitch = FMOD_RESULT function(FMOD_CHANNEL *channel, float *pitch);
    alias da_FMOD_Channel_SetMute = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL mute);
    alias da_FMOD_Channel_GetMute = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *mute);
    alias da_FMOD_Channel_SetReverbProperties = FMOD_RESULT function(FMOD_CHANNEL *channel, int instance, float wet);
    alias da_FMOD_Channel_GetReverbProperties = FMOD_RESULT function(FMOD_CHANNEL *channel, int instance, float *wet);
    alias da_FMOD_Channel_SetLowPassGain = FMOD_RESULT function(FMOD_CHANNEL *channel, float gain);
    alias da_FMOD_Channel_GetLowPassGain = FMOD_RESULT function(FMOD_CHANNEL *channel, float *gain);
    alias da_FMOD_Channel_SetMode = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_MODE mode);
    alias da_FMOD_Channel_GetMode = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_MODE *mode);
    alias da_FMOD_Channel_SetCallback = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_CHANNELCONTROL_CALLBACK callback);
    alias da_FMOD_Channel_IsPlaying = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *isplaying);
    
    /*
     Note all 'set' functions alter a final matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
*/
    
    alias da_FMOD_Channel_SetPan = FMOD_RESULT function(FMOD_CHANNEL *channel, float pan);
    alias da_FMOD_Channel_SetMixLevelsOutput = FMOD_RESULT function(FMOD_CHANNEL *channel, float frontleft, float frontright, float center, float lfe, float surroundleft, float surroundright, float backleft, float backright);
    alias da_FMOD_Channel_SetMixLevelsInput = FMOD_RESULT function(FMOD_CHANNEL *channel, float *levels, int numlevels);
    alias da_FMOD_Channel_SetMixMatrix = FMOD_RESULT function(FMOD_CHANNEL *channel, float *matrix, int outchannels, int inchannels, int inchannel_hop);
    alias da_FMOD_Channel_GetMixMatrix = FMOD_RESULT function(FMOD_CHANNEL *channel, float *matrix, int *outchannels, int *inchannels, int inchannel_hop);
    
    /*
     Clock based functionality.
*/
    
    alias da_FMOD_Channel_GetDSPClock = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong *dspclock, ulong *parentclock);
    alias da_FMOD_Channel_SetDelay = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong dspclock_start, ulong dspclock_end, FMOD_BOOL stopchannels);
    alias da_FMOD_Channel_GetDelay = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong *dspclock_start, ulong *dspclock_end, FMOD_BOOL *stopchannels);
    alias da_FMOD_Channel_AddFadePoint = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong dspclock, float volume);
    alias da_FMOD_Channel_SetFadePointRamp = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong dspclock, float volume);
    alias da_FMOD_Channel_RemoveFadePoints = FMOD_RESULT function(FMOD_CHANNEL *channel, ulong dspclock_start, ulong dspclock_end);
    alias da_FMOD_Channel_GetFadePoints = FMOD_RESULT function(FMOD_CHANNEL *channel,  uint *numpoints, ulong *point_dspclock, float *point_volume);
    
    /*
     DSP effects.
*/
    
    alias da_FMOD_Channel_GetDSP = FMOD_RESULT function(FMOD_CHANNEL *channel, int index, FMOD_DSP **dsp);
    alias da_FMOD_Channel_AddDSP = FMOD_RESULT function(FMOD_CHANNEL *channel, int index, FMOD_DSP *dsp);
    alias da_FMOD_Channel_RemoveDSP = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_DSP *dsp);
    alias da_FMOD_Channel_GetNumDSPs = FMOD_RESULT function(FMOD_CHANNEL *channel, int *numdsps);
    alias da_FMOD_Channel_SetDSPIndex = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_DSP *dsp, int index);
    alias da_FMOD_Channel_GetDSPIndex = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_DSP *dsp, int *index);
    alias da_FMOD_Channel_OverridePanDSP = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_DSP *pan);
    
    /*
     3D functionality.
*/
    
    alias da_FMOD_Channel_Set3DAttributes = FMOD_RESULT function(FMOD_CHANNEL *channel, const FMOD_VECTOR *pos, const FMOD_VECTOR *vel, const FMOD_VECTOR *alt_pan_pos);
    alias da_FMOD_Channel_Get3DAttributes = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_VECTOR *pos, FMOD_VECTOR *vel, FMOD_VECTOR *alt_pan_pos);
    alias da_FMOD_Channel_Set3DMinMaxDistance = FMOD_RESULT function(FMOD_CHANNEL *channel, float mindistance, float maxdistance);
    alias da_FMOD_Channel_Get3DMinMaxDistance = FMOD_RESULT function(FMOD_CHANNEL *channel, float *mindistance, float *maxdistance);
    alias da_FMOD_Channel_Set3DConeSettings = FMOD_RESULT function(FMOD_CHANNEL *channel, float insideconeangle, float outsideconeangle, float outsidevolume);
    alias da_FMOD_Channel_Get3DConeSettings = FMOD_RESULT function(FMOD_CHANNEL *channel, float *insideconeangle, float *outsideconeangle, float *outsidevolume);
    alias da_FMOD_Channel_Set3DConeOrientation = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_VECTOR *orientation);
    alias da_FMOD_Channel_Get3DConeOrientation = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_VECTOR *orientation);
    alias da_FMOD_Channel_Set3DCustomRolloff = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_VECTOR *points, int numpoints);
    alias da_FMOD_Channel_Get3DCustomRolloff = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_VECTOR **points, int *numpoints);
    alias da_FMOD_Channel_Set3DOcclusion = FMOD_RESULT function(FMOD_CHANNEL *channel, float directocclusion, float reverbocclusion);
    alias da_FMOD_Channel_Get3DOcclusion = FMOD_RESULT function(FMOD_CHANNEL *channel, float *directocclusion, float *reverbocclusion);
    alias da_FMOD_Channel_Set3DSpread = FMOD_RESULT function(FMOD_CHANNEL *channel, float angle);
    alias da_FMOD_Channel_Get3DSpread = FMOD_RESULT function(FMOD_CHANNEL *channel, float *angle);
    alias da_FMOD_Channel_Set3DLevel = FMOD_RESULT function(FMOD_CHANNEL *channel, float level);
    alias da_FMOD_Channel_Get3DLevel = FMOD_RESULT function(FMOD_CHANNEL *channel, float *level);
    alias da_FMOD_Channel_Set3DDopplerLevel = FMOD_RESULT function(FMOD_CHANNEL *channel, float level);
    alias da_FMOD_Channel_Get3DDopplerLevel = FMOD_RESULT function(FMOD_CHANNEL *channel, float *level);
    alias da_FMOD_Channel_Set3DDistanceFilter = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL custom, float customLevel, float centerFreq);
    alias da_FMOD_Channel_Get3DDistanceFilter = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *custom, float *customLevel, float *centerFreq);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_Channel_SetUserData = FMOD_RESULT function(FMOD_CHANNEL *channel, void *userdata);
    alias da_FMOD_Channel_GetUserData = FMOD_RESULT function(FMOD_CHANNEL *channel, void **userdata);
    
    /*
     Channel specific control functionality.
*/
    
    alias da_FMOD_Channel_SetFrequency = FMOD_RESULT function(FMOD_CHANNEL *channel, float frequency);
    alias da_FMOD_Channel_GetFrequency = FMOD_RESULT function(FMOD_CHANNEL *channel, float *frequency);
    alias da_FMOD_Channel_SetPriority = FMOD_RESULT function(FMOD_CHANNEL *channel, int priority);
    alias da_FMOD_Channel_GetPriority = FMOD_RESULT function(FMOD_CHANNEL *channel, int *priority);
    alias da_FMOD_Channel_SetPosition = FMOD_RESULT function(FMOD_CHANNEL *channel,  uint position, FMOD_TIMEUNIT postype);
    alias da_FMOD_Channel_GetPosition = FMOD_RESULT function(FMOD_CHANNEL *channel,  uint *position, FMOD_TIMEUNIT postype);
    alias da_FMOD_Channel_SetChannelGroup = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_CHANNELGROUP *channelgroup);
    alias da_FMOD_Channel_GetChannelGroup = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_CHANNELGROUP **channelgroup);
    alias da_FMOD_Channel_SetLoopCount = FMOD_RESULT function(FMOD_CHANNEL *channel, int loopcount);
    alias da_FMOD_Channel_GetLoopCount = FMOD_RESULT function(FMOD_CHANNEL *channel, int *loopcount);
    alias da_FMOD_Channel_SetLoopPoints = FMOD_RESULT function(FMOD_CHANNEL *channel,  uint loopstart, FMOD_TIMEUNIT loopstarttype,  uint loopend, FMOD_TIMEUNIT loopendtype);
    alias da_FMOD_Channel_GetLoopPoints = FMOD_RESULT function(FMOD_CHANNEL *channel,  uint *loopstart, FMOD_TIMEUNIT loopstarttype,  uint *loopend, FMOD_TIMEUNIT loopendtype);
    
    /*
     Information only functions.
*/
    
    alias da_FMOD_Channel_IsVirtual = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_BOOL *isvirtual);
    alias da_FMOD_Channel_GetCurrentSound = FMOD_RESULT function(FMOD_CHANNEL *channel, FMOD_SOUND **sound);
    alias da_FMOD_Channel_GetIndex = FMOD_RESULT function(FMOD_CHANNEL *channel, int *index);
    
    /*
    'ChannelGroup' API
*/
    
    alias da_FMOD_ChannelGroup_GetSystemObject = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_SYSTEM **system);
    
    /*
     General control functionality for Channels and ChannelGroups.
*/
    
    alias da_FMOD_ChannelGroup_Stop = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup);
    alias da_FMOD_ChannelGroup_SetPaused = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL paused);
    alias da_FMOD_ChannelGroup_GetPaused = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL *paused);
    alias da_FMOD_ChannelGroup_SetVolume = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float volume);
    alias da_FMOD_ChannelGroup_GetVolume = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *volume);
    alias da_FMOD_ChannelGroup_SetVolumeRamp = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL ramp);
    alias da_FMOD_ChannelGroup_GetVolumeRamp = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL *ramp);
    alias da_FMOD_ChannelGroup_GetAudibility = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *audibility);
    alias da_FMOD_ChannelGroup_SetPitch = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float pitch);
    alias da_FMOD_ChannelGroup_GetPitch = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *pitch);
    alias da_FMOD_ChannelGroup_SetMute = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL mute);
    alias da_FMOD_ChannelGroup_GetMute = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL *mute);
    alias da_FMOD_ChannelGroup_SetReverbProperties = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int instance, float wet);
    alias da_FMOD_ChannelGroup_GetReverbProperties = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int instance, float *wet);
    alias da_FMOD_ChannelGroup_SetLowPassGain = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float gain);
    alias da_FMOD_ChannelGroup_GetLowPassGain = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *gain);
    alias da_FMOD_ChannelGroup_SetMode = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_MODE mode);
    alias da_FMOD_ChannelGroup_GetMode = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_MODE *mode);
    alias da_FMOD_ChannelGroup_SetCallback = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_CHANNELCONTROL_CALLBACK callback);
    alias da_FMOD_ChannelGroup_IsPlaying = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL *isplaying);
    
    /*
     Note all 'set' functions alter a final matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
*/
    
    alias da_FMOD_ChannelGroup_SetPan = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float pan);
    alias da_FMOD_ChannelGroup_SetMixLevelsOutput = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float frontleft, float frontright, float center, float lfe, float surroundleft, float surroundright, float backleft, float backright);
    alias da_FMOD_ChannelGroup_SetMixLevelsInput = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *levels, int numlevels);
    alias da_FMOD_ChannelGroup_SetMixMatrix = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *matrix, int outchannels, int inchannels, int inchannel_hop);
    alias da_FMOD_ChannelGroup_GetMixMatrix = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *matrix, int *outchannels, int *inchannels, int inchannel_hop);
    
    /*
     Clock based functionality.
*/
    
    alias da_FMOD_ChannelGroup_GetDSPClock = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong *dspclock, ulong *parentclock);
    alias da_FMOD_ChannelGroup_SetDelay = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong dspclock_start, ulong dspclock_end, FMOD_BOOL stopchannels);
    alias da_FMOD_ChannelGroup_GetDelay = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong *dspclock_start, ulong *dspclock_end, FMOD_BOOL *stopchannels);
    alias da_FMOD_ChannelGroup_AddFadePoint = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong dspclock, float volume);
    alias da_FMOD_ChannelGroup_SetFadePointRamp = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong dspclock, float volume);
    alias da_FMOD_ChannelGroup_RemoveFadePoints = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, ulong dspclock_start, ulong dspclock_end);
    alias da_FMOD_ChannelGroup_GetFadePoints = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup,  uint *numpoints, ulong *point_dspclock, float *point_volume);
    
    /*
     DSP effects.
*/
    
    alias da_FMOD_ChannelGroup_GetDSP = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int index, FMOD_DSP **dsp);
    alias da_FMOD_ChannelGroup_AddDSP = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int index, FMOD_DSP *dsp);
    alias da_FMOD_ChannelGroup_RemoveDSP = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_DSP *dsp);
    alias da_FMOD_ChannelGroup_GetNumDSPs = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int *numdsps);
    alias da_FMOD_ChannelGroup_SetDSPIndex = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_DSP *dsp, int index);
    alias da_FMOD_ChannelGroup_GetDSPIndex = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_DSP *dsp, int *index);
    alias da_FMOD_ChannelGroup_OverridePanDSP = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_DSP *pan);
    
    /*
     3D functionality.
*/
    
    alias da_FMOD_ChannelGroup_Set3DAttributes = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, const FMOD_VECTOR *pos, const FMOD_VECTOR *vel, const FMOD_VECTOR *alt_pan_pos);
    alias da_FMOD_ChannelGroup_Get3DAttributes = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_VECTOR *pos, FMOD_VECTOR *vel, FMOD_VECTOR *alt_pan_pos);
    alias da_FMOD_ChannelGroup_Set3DMinMaxDistance = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float mindistance, float maxdistance);
    alias da_FMOD_ChannelGroup_Get3DMinMaxDistance = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *mindistance, float *maxdistance);
    alias da_FMOD_ChannelGroup_Set3DConeSettings = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float insideconeangle, float outsideconeangle, float outsidevolume);
    alias da_FMOD_ChannelGroup_Get3DConeSettings = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *insideconeangle, float *outsideconeangle, float *outsidevolume);
    alias da_FMOD_ChannelGroup_Set3DConeOrientation = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_VECTOR *orientation);
    alias da_FMOD_ChannelGroup_Get3DConeOrientation = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_VECTOR *orientation);
    alias da_FMOD_ChannelGroup_Set3DCustomRolloff = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_VECTOR *points, int numpoints);
    alias da_FMOD_ChannelGroup_Get3DCustomRolloff = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_VECTOR **points, int *numpoints);
    alias da_FMOD_ChannelGroup_Set3DOcclusion = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float directocclusion, float reverbocclusion);
    alias da_FMOD_ChannelGroup_Get3DOcclusion = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *directocclusion, float *reverbocclusion);
    alias da_FMOD_ChannelGroup_Set3DSpread = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float angle);
    alias da_FMOD_ChannelGroup_Get3DSpread = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *angle);
    alias da_FMOD_ChannelGroup_Set3DLevel = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float level);
    alias da_FMOD_ChannelGroup_Get3DLevel = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *level);
    alias da_FMOD_ChannelGroup_Set3DDopplerLevel = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float level);
    alias da_FMOD_ChannelGroup_Get3DDopplerLevel = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, float *level);
    alias da_FMOD_ChannelGroup_Set3DDistanceFilter = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL custom, float customLevel, float centerFreq);
    alias da_FMOD_ChannelGroup_Get3DDistanceFilter = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_BOOL *custom, float *customLevel, float *centerFreq);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_ChannelGroup_SetUserData = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, void *userdata);
    alias da_FMOD_ChannelGroup_GetUserData = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, void **userdata);
    
    alias da_FMOD_ChannelGroup_Release = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup);
    
    /*
     Nested channel groups.
*/
    
    alias da_FMOD_ChannelGroup_AddGroup = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_CHANNELGROUP *group, FMOD_BOOL propagatedspclock, FMOD_DSPCONNECTION **connection);
    alias da_FMOD_ChannelGroup_GetNumGroups = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int *numgroups);
    alias da_FMOD_ChannelGroup_GetGroup = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int index, FMOD_CHANNELGROUP **group);
    alias da_FMOD_ChannelGroup_GetParentGroup = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, FMOD_CHANNELGROUP **group);
    
    /*
     Information only functions.
*/
    
    alias da_FMOD_ChannelGroup_GetName = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, char *name, int namelen);
    alias da_FMOD_ChannelGroup_GetNumChannels = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int *numchannels);
    alias da_FMOD_ChannelGroup_GetChannel = FMOD_RESULT function(FMOD_CHANNELGROUP *channelgroup, int index, FMOD_CHANNEL **channel);
    
    /*
    'SoundGroup' API
*/
    
    alias da_FMOD_SoundGroup_Release = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup);
    alias da_FMOD_SoundGroup_GetSystemObject = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, FMOD_SYSTEM **system);
    
    /*
     SoundGroup control functions.
*/
    
    alias da_FMOD_SoundGroup_SetMaxAudible = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, int maxaudible);
    alias da_FMOD_SoundGroup_GetMaxAudible = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, int *maxaudible);
    alias da_FMOD_SoundGroup_SetMaxAudibleBehavior = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, FMOD_SOUNDGROUP_BEHAVIOR behavior);
    alias da_FMOD_SoundGroup_GetMaxAudibleBehavior = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, FMOD_SOUNDGROUP_BEHAVIOR *behavior);
    alias da_FMOD_SoundGroup_SetMuteFadeSpeed = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, float speed);
    alias da_FMOD_SoundGroup_GetMuteFadeSpeed = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, float *speed);
    alias da_FMOD_SoundGroup_SetVolume = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, float volume);
    alias da_FMOD_SoundGroup_GetVolume = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, float *volume);
    alias da_FMOD_SoundGroup_Stop = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup);
    
    /*
     Information only functions.
*/
    
    alias da_FMOD_SoundGroup_GetName = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, char *name, int namelen);
    alias da_FMOD_SoundGroup_GetNumSounds = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, int *numsounds);
    alias da_FMOD_SoundGroup_GetSound = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, int index, FMOD_SOUND **sound);
    alias da_FMOD_SoundGroup_GetNumPlaying = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, int *numplaying);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_SoundGroup_SetUserData = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, void *userdata);
    alias da_FMOD_SoundGroup_GetUserData = FMOD_RESULT function(FMOD_SOUNDGROUP *soundgroup, void **userdata);
    
    /*
    'DSP' API
*/
    
    alias da_FMOD_DSP_Release = FMOD_RESULT function(FMOD_DSP *dsp);
    alias da_FMOD_DSP_GetSystemObject = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_SYSTEM **system);
    
    /*
     Connection / disconnection / input and output enumeration.
*/
    
    alias da_FMOD_DSP_AddInput = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_DSP *input, FMOD_DSPCONNECTION **connection, FMOD_DSPCONNECTION_TYPE type);
    alias da_FMOD_DSP_DisconnectFrom = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_DSP *target, FMOD_DSPCONNECTION *connection);
    alias da_FMOD_DSP_DisconnectAll = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL inputs, FMOD_BOOL outputs);
    alias da_FMOD_DSP_GetNumInputs = FMOD_RESULT function(FMOD_DSP *dsp, int *numinputs);
    alias da_FMOD_DSP_GetNumOutputs = FMOD_RESULT function(FMOD_DSP *dsp, int *numoutputs);
    alias da_FMOD_DSP_GetInput = FMOD_RESULT function(FMOD_DSP *dsp, int index, FMOD_DSP **input, FMOD_DSPCONNECTION **inputconnection);
    alias da_FMOD_DSP_GetOutput = FMOD_RESULT function(FMOD_DSP *dsp, int index, FMOD_DSP **output, FMOD_DSPCONNECTION **outputconnection);
    
    /*
     DSP unit control.
*/
    
    alias da_FMOD_DSP_SetActive = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL active);
    alias da_FMOD_DSP_GetActive = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL *active);
    alias da_FMOD_DSP_SetBypass = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL bypass);
    alias da_FMOD_DSP_GetBypass = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL *bypass);
    alias da_FMOD_DSP_SetWetDryMix = FMOD_RESULT function(FMOD_DSP *dsp, float prewet, float postwet, float dry);
    alias da_FMOD_DSP_GetWetDryMix = FMOD_RESULT function(FMOD_DSP *dsp, float *prewet, float *postwet, float *dry);
    alias da_FMOD_DSP_SetChannelFormat = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_CHANNELMASK channelmask, int numchannels, FMOD_SPEAKERMODE source_speakermode);
    alias da_FMOD_DSP_GetChannelFormat = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_CHANNELMASK *channelmask, int *numchannels, FMOD_SPEAKERMODE *source_speakermode);
    alias da_FMOD_DSP_GetOutputChannelFormat = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_CHANNELMASK inmask, int inchannels, FMOD_SPEAKERMODE inspeakermode, FMOD_CHANNELMASK *outmask, int *outchannels, FMOD_SPEAKERMODE *outspeakermode);
    alias da_FMOD_DSP_Reset = FMOD_RESULT function(FMOD_DSP *dsp);
    
    /*
     DSP parameter control.
*/
    
    alias da_FMOD_DSP_SetParameterFloat = FMOD_RESULT function(FMOD_DSP *dsp, int index, float value);
    alias da_FMOD_DSP_SetParameterInt = FMOD_RESULT function(FMOD_DSP *dsp, int index, int value);
    alias da_FMOD_DSP_SetParameterBool = FMOD_RESULT function(FMOD_DSP *dsp, int index, FMOD_BOOL value);
    alias da_FMOD_DSP_SetParameterData = FMOD_RESULT function(FMOD_DSP *dsp, int index, void *data,  uint length);
    alias da_FMOD_DSP_GetParameterFloat = FMOD_RESULT function(FMOD_DSP *dsp, int index, float *value, char *valuestr, int valuestrlen);
    alias da_FMOD_DSP_GetParameterInt = FMOD_RESULT function(FMOD_DSP *dsp, int index, int *value, char *valuestr, int valuestrlen);
    alias da_FMOD_DSP_GetParameterBool = FMOD_RESULT function(FMOD_DSP *dsp, int index, FMOD_BOOL *value, char *valuestr, int valuestrlen);
    alias da_FMOD_DSP_GetParameterData = FMOD_RESULT function(FMOD_DSP *dsp, int index, void **data,  uint *length, char *valuestr, int valuestrlen);
    alias da_FMOD_DSP_GetNumParameters = FMOD_RESULT function(FMOD_DSP *dsp, int *numparams);
    alias da_FMOD_DSP_GetParameterInfo = FMOD_RESULT function(FMOD_DSP *dsp, int index, FMOD_DSP_PARAMETER_DESC **desc);
    alias da_FMOD_DSP_GetDataParameterIndex = FMOD_RESULT function(FMOD_DSP *dsp, int datatype, int *index);
    alias da_FMOD_DSP_ShowConfigDialog = FMOD_RESULT function(FMOD_DSP *dsp, void *hwnd, FMOD_BOOL show);
    
    /*
     DSP attributes.
*/
    
    alias da_FMOD_DSP_GetInfo = FMOD_RESULT function(FMOD_DSP *dsp, char *name,  uint  *version_, int *channels, int *configwidth, int *configheight);
    alias da_FMOD_DSP_GetType = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_DSP_TYPE *type);
    alias da_FMOD_DSP_GetIdle = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL *idle);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_DSP_SetUserData = FMOD_RESULT function(FMOD_DSP *dsp, void *userdata);
    alias da_FMOD_DSP_GetUserData = FMOD_RESULT function(FMOD_DSP *dsp, void **userdata);
    
    /*
     Metering.
*/
    
    alias da_FMOD_DSP_SetMeteringEnabled = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL inputEnabled, FMOD_BOOL outputEnabled);
    alias da_FMOD_DSP_GetMeteringEnabled = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_BOOL *inputEnabled, FMOD_BOOL *outputEnabled);
    alias da_FMOD_DSP_GetMeteringInfo = FMOD_RESULT function(FMOD_DSP *dsp, FMOD_DSP_METERING_INFO *inputInfo, FMOD_DSP_METERING_INFO *outputInfo);
    
    /*
    'DSPConnection' API
*/
    
    alias da_FMOD_DSPConnection_GetInput = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, FMOD_DSP **input);
    alias da_FMOD_DSPConnection_GetOutput = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, FMOD_DSP **output);
    alias da_FMOD_DSPConnection_SetMix = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, float volume);
    alias da_FMOD_DSPConnection_GetMix = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, float *volume);
    alias da_FMOD_DSPConnection_SetMixMatrix = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, float *matrix, int outchannels, int inchannels, int inchannel_hop);
    alias da_FMOD_DSPConnection_GetMixMatrix = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, float *matrix, int *outchannels, int *inchannels, int inchannel_hop);
    alias da_FMOD_DSPConnection_GetType = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, FMOD_DSPCONNECTION_TYPE *type);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_DSPConnection_SetUserData = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, void *userdata);
    alias da_FMOD_DSPConnection_GetUserData = FMOD_RESULT function(FMOD_DSPCONNECTION *dspconnection, void **userdata);
    
    /*
    'Geometry' API
*/
    
    alias da_FMOD_Geometry_Release = FMOD_RESULT function(FMOD_GEOMETRY *geometry);
    
    /*
     Polygon manipulation.
*/
    
    alias da_FMOD_Geometry_AddPolygon = FMOD_RESULT function(FMOD_GEOMETRY *geometry, float directocclusion, float reverbocclusion, FMOD_BOOL doublesided, int numvertices, const FMOD_VECTOR *vertices, int *polygonindex);
    alias da_FMOD_Geometry_GetNumPolygons = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int *numpolygons);
    alias da_FMOD_Geometry_GetMaxPolygons = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int *maxpolygons, int *maxvertices);
    alias da_FMOD_Geometry_GetPolygonNumVertices = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int index, int *numvertices);
    alias da_FMOD_Geometry_SetPolygonVertex = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int index, int vertexindex, const FMOD_VECTOR *vertex);
    alias da_FMOD_Geometry_GetPolygonVertex = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int index, int vertexindex, FMOD_VECTOR *vertex);
    alias da_FMOD_Geometry_SetPolygonAttributes = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int index, float directocclusion, float reverbocclusion, FMOD_BOOL doublesided);
    alias da_FMOD_Geometry_GetPolygonAttributes = FMOD_RESULT function(FMOD_GEOMETRY *geometry, int index, float *directocclusion, float *reverbocclusion, FMOD_BOOL *doublesided);
    
    /*
     Object manipulation.
*/
    
    alias da_FMOD_Geometry_SetActive = FMOD_RESULT function(FMOD_GEOMETRY *geometry, FMOD_BOOL active);
    alias da_FMOD_Geometry_GetActive = FMOD_RESULT function(FMOD_GEOMETRY *geometry, FMOD_BOOL *active);
    alias da_FMOD_Geometry_SetRotation = FMOD_RESULT function(FMOD_GEOMETRY *geometry, const FMOD_VECTOR *forward, const FMOD_VECTOR *up);
    alias da_FMOD_Geometry_GetRotation = FMOD_RESULT function(FMOD_GEOMETRY *geometry, FMOD_VECTOR *forward, FMOD_VECTOR *up);
    alias da_FMOD_Geometry_SetPosition = FMOD_RESULT function(FMOD_GEOMETRY *geometry, const FMOD_VECTOR *position);
    alias da_FMOD_Geometry_GetPosition = FMOD_RESULT function(FMOD_GEOMETRY *geometry, FMOD_VECTOR *position);
    alias da_FMOD_Geometry_SetScale = FMOD_RESULT function(FMOD_GEOMETRY *geometry, const FMOD_VECTOR *scale);
    alias da_FMOD_Geometry_GetScale = FMOD_RESULT function(FMOD_GEOMETRY *geometry, FMOD_VECTOR *scale);
    alias da_FMOD_Geometry_Save = FMOD_RESULT function(FMOD_GEOMETRY *geometry, void *data, int *datasize);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_Geometry_SetUserData = FMOD_RESULT function(FMOD_GEOMETRY *geometry, void *userdata);
    alias da_FMOD_Geometry_GetUserData = FMOD_RESULT function(FMOD_GEOMETRY *geometry, void **userdata);
    
    /*
    'Reverb3D' API
*/
    
    alias da_FMOD_Reverb3D_Release = FMOD_RESULT function(FMOD_REVERB3D *reverb3d);
    
    /*
     Reverb manipulation.
*/
    
    alias da_FMOD_Reverb3D_Set3DAttributes = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, const FMOD_VECTOR *position, float mindistance, float maxdistance);
    alias da_FMOD_Reverb3D_Get3DAttributes = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, FMOD_VECTOR *position, float *mindistance, float *maxdistance);
    alias da_FMOD_Reverb3D_SetProperties = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, const FMOD_REVERB_PROPERTIES *properties);
    alias da_FMOD_Reverb3D_GetProperties = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, FMOD_REVERB_PROPERTIES *properties);
    alias da_FMOD_Reverb3D_SetActive = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, FMOD_BOOL active);
    alias da_FMOD_Reverb3D_GetActive = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, FMOD_BOOL *active);
    
    /*
     Userdata set/get.
*/
    
    alias da_FMOD_Reverb3D_SetUserData = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, void *userdata);
    alias da_FMOD_Reverb3D_GetUserData = FMOD_RESULT function(FMOD_REVERB3D *reverb3d, void **userdata);
}

__gshared
{
    da_FMOD_Memory_Initialize FMOD_Memory_Initialize;
    da_FMOD_Memory_GetStats FMOD_Memory_GetStats;
    da_FMOD_Debug_Initialize FMOD_Debug_Initialize;
    da_FMOD_File_SetDiskBusy FMOD_File_SetDiskBusy;
    da_FMOD_File_GetDiskBusy FMOD_File_GetDiskBusy;
    da_FMOD_System_Create FMOD_System_Create;
    da_FMOD_System_Release FMOD_System_Release;
    da_FMOD_System_SetOutput FMOD_System_SetOutput;
    da_FMOD_System_GetOutput FMOD_System_GetOutput;
    da_FMOD_System_GetNumDrivers FMOD_System_GetNumDrivers;
    da_FMOD_System_GetDriverInfo FMOD_System_GetDriverInfo;
    da_FMOD_System_SetDriver FMOD_System_SetDriver;
    da_FMOD_System_GetDriver FMOD_System_GetDriver;
    da_FMOD_System_SetSoftwareChannels FMOD_System_SetSoftwareChannels;
    da_FMOD_System_GetSoftwareChannels FMOD_System_GetSoftwareChannels;
    da_FMOD_System_SetSoftwareFormat FMOD_System_SetSoftwareFormat;
    da_FMOD_System_GetSoftwareFormat FMOD_System_GetSoftwareFormat;
    da_FMOD_System_SetDSPBufferSize FMOD_System_SetDSPBufferSize;
    da_FMOD_System_GetDSPBufferSize FMOD_System_GetDSPBufferSize;
    da_FMOD_System_SetFileSystem FMOD_System_SetFileSystem;
    da_FMOD_System_AttachFileSystem FMOD_System_AttachFileSystem;
    da_FMOD_System_SetAdvancedSettings FMOD_System_SetAdvancedSettings;
    da_FMOD_System_GetAdvancedSettings FMOD_System_GetAdvancedSettings;
    da_FMOD_System_SetCallback FMOD_System_SetCallback;
    da_FMOD_System_SetPluginPath FMOD_System_SetPluginPath;
    da_FMOD_System_LoadPlugin FMOD_System_LoadPlugin;
    da_FMOD_System_UnloadPlugin FMOD_System_UnloadPlugin;
    da_FMOD_System_GetNumPlugins FMOD_System_GetNumPlugins;
    da_FMOD_System_GetPluginHandle FMOD_System_GetPluginHandle;
    da_FMOD_System_GetPluginInfo FMOD_System_GetPluginInfo;
    da_FMOD_System_SetOutputByPlugin FMOD_System_SetOutputByPlugin;
    da_FMOD_System_GetOutputByPlugin FMOD_System_GetOutputByPlugin;
    da_FMOD_System_CreateDSPByPlugin FMOD_System_CreateDSPByPlugin;
    da_FMOD_System_GetDSPInfoByPlugin FMOD_System_GetDSPInfoByPlugin;
    da_FMOD_System_RegisterCodec FMOD_System_RegisterCodec;
    da_FMOD_System_RegisterDSP FMOD_System_RegisterDSP;
    da_FMOD_System_RegisterOutput FMOD_System_RegisterOutput;
    da_FMOD_System_Init FMOD_System_Init;
    da_FMOD_System_Close FMOD_System_Close;
    da_FMOD_System_Update FMOD_System_Update;
    da_FMOD_System_SetSpeakerPosition FMOD_System_SetSpeakerPosition;
    da_FMOD_System_GetSpeakerPosition FMOD_System_GetSpeakerPosition;
    da_FMOD_System_SetStreamBufferSize FMOD_System_SetStreamBufferSize;
    da_FMOD_System_GetStreamBufferSize FMOD_System_GetStreamBufferSize;
    da_FMOD_System_Set3DSettings FMOD_System_Set3DSettings;
    da_FMOD_System_Get3DSettings FMOD_System_Get3DSettings;
    da_FMOD_System_Set3DNumListeners FMOD_System_Set3DNumListeners;
    da_FMOD_System_Get3DNumListeners FMOD_System_Get3DNumListeners;
    da_FMOD_System_Set3DListenerAttributes FMOD_System_Set3DListenerAttributes;
    da_FMOD_System_Get3DListenerAttributes FMOD_System_Get3DListenerAttributes;
    da_FMOD_System_Set3DRolloffCallback FMOD_System_Set3DRolloffCallback;
    da_FMOD_System_MixerSuspend FMOD_System_MixerSuspend;
    da_FMOD_System_MixerResume FMOD_System_MixerResume;
    da_FMOD_System_GetDefaultMixMatrix FMOD_System_GetDefaultMixMatrix;
    da_FMOD_System_GetSpeakerModeChannels FMOD_System_GetSpeakerModeChannels;
    da_FMOD_System_GetVersion FMOD_System_GetVersion;
    da_FMOD_System_GetOutputHandle FMOD_System_GetOutputHandle;
    da_FMOD_System_GetChannelsPlaying FMOD_System_GetChannelsPlaying;
    da_FMOD_System_GetCPUUsage FMOD_System_GetCPUUsage;
    da_FMOD_System_GetSoundRAM FMOD_System_GetSoundRAM;
    da_FMOD_System_CreateSound FMOD_System_CreateSound;
    da_FMOD_System_CreateStream FMOD_System_CreateStream;
    da_FMOD_System_CreateDSP FMOD_System_CreateDSP;
    da_FMOD_System_CreateDSPByType FMOD_System_CreateDSPByType;
    da_FMOD_System_CreateChannelGroup FMOD_System_CreateChannelGroup;
    da_FMOD_System_CreateSoundGroup FMOD_System_CreateSoundGroup;
    da_FMOD_System_CreateReverb3D FMOD_System_CreateReverb3D;
    da_FMOD_System_PlaySound FMOD_System_PlaySound;
    da_FMOD_System_PlayDSP FMOD_System_PlayDSP;
    da_FMOD_System_GetChannel FMOD_System_GetChannel;
    da_FMOD_System_GetMasterChannelGroup FMOD_System_GetMasterChannelGroup;
    da_FMOD_System_GetMasterSoundGroup FMOD_System_GetMasterSoundGroup;
    da_FMOD_System_AttachChannelGroupToPort FMOD_System_AttachChannelGroupToPort;
    da_FMOD_System_DetachChannelGroupFromPort FMOD_System_DetachChannelGroupFromPort;
    da_FMOD_System_SetReverbProperties FMOD_System_SetReverbProperties;
    da_FMOD_System_GetReverbProperties FMOD_System_GetReverbProperties;
    da_FMOD_System_LockDSP FMOD_System_LockDSP;
    da_FMOD_System_UnlockDSP FMOD_System_UnlockDSP;
    da_FMOD_System_GetRecordNumDrivers FMOD_System_GetRecordNumDrivers;
    da_FMOD_System_GetRecordDriverInfo FMOD_System_GetRecordDriverInfo;
    da_FMOD_System_GetRecordPosition FMOD_System_GetRecordPosition;
    da_FMOD_System_RecordStart FMOD_System_RecordStart;
    da_FMOD_System_RecordStop FMOD_System_RecordStop;
    da_FMOD_System_IsRecording FMOD_System_IsRecording;
    da_FMOD_System_CreateGeometry FMOD_System_CreateGeometry;
    da_FMOD_System_SetGeometrySettings FMOD_System_SetGeometrySettings;
    da_FMOD_System_GetGeometrySettings FMOD_System_GetGeometrySettings;
    da_FMOD_System_LoadGeometry FMOD_System_LoadGeometry;
    da_FMOD_System_GetGeometryOcclusion FMOD_System_GetGeometryOcclusion;
    da_FMOD_System_SetNetworkProxy FMOD_System_SetNetworkProxy;
    da_FMOD_System_GetNetworkProxy FMOD_System_GetNetworkProxy;
    da_FMOD_System_SetNetworkTimeout FMOD_System_SetNetworkTimeout;
    da_FMOD_System_GetNetworkTimeout FMOD_System_GetNetworkTimeout;
    da_FMOD_System_SetUserData FMOD_System_SetUserData;
    da_FMOD_System_GetUserData FMOD_System_GetUserData;
    da_FMOD_Sound_Release FMOD_Sound_Release;
    da_FMOD_Sound_GetSystemObject FMOD_Sound_GetSystemObject;
    da_FMOD_Sound_Lock FMOD_Sound_Lock;
    da_FMOD_Sound_Unlock FMOD_Sound_Unlock;
    da_FMOD_Sound_SetDefaults FMOD_Sound_SetDefaults;
    da_FMOD_Sound_GetDefaults FMOD_Sound_GetDefaults;
    da_FMOD_Sound_Set3DMinMaxDistance FMOD_Sound_Set3DMinMaxDistance;
    da_FMOD_Sound_Get3DMinMaxDistance FMOD_Sound_Get3DMinMaxDistance;
    da_FMOD_Sound_Set3DConeSettings FMOD_Sound_Set3DConeSettings;
    da_FMOD_Sound_Get3DConeSettings FMOD_Sound_Get3DConeSettings;
    da_FMOD_Sound_Set3DCustomRolloff FMOD_Sound_Set3DCustomRolloff;
    da_FMOD_Sound_Get3DCustomRolloff FMOD_Sound_Get3DCustomRolloff;
    da_FMOD_Sound_GetSubSound FMOD_Sound_GetSubSound;
    da_FMOD_Sound_GetSubSoundParent FMOD_Sound_GetSubSoundParent;
    da_FMOD_Sound_GetName FMOD_Sound_GetName;
    da_FMOD_Sound_GetLength FMOD_Sound_GetLength;
    da_FMOD_Sound_GetFormat FMOD_Sound_GetFormat;
    da_FMOD_Sound_GetNumSubSounds FMOD_Sound_GetNumSubSounds;
    da_FMOD_Sound_GetNumTags FMOD_Sound_GetNumTags;
    da_FMOD_Sound_GetTag FMOD_Sound_GetTag;
    da_FMOD_Sound_GetOpenState FMOD_Sound_GetOpenState;
    da_FMOD_Sound_ReadData FMOD_Sound_ReadData;
    da_FMOD_Sound_SeekData FMOD_Sound_SeekData;
    da_FMOD_Sound_SetSoundGroup FMOD_Sound_SetSoundGroup;
    da_FMOD_Sound_GetSoundGroup FMOD_Sound_GetSoundGroup;
    da_FMOD_Sound_GetNumSyncPoints FMOD_Sound_GetNumSyncPoints;
    da_FMOD_Sound_GetSyncPoint FMOD_Sound_GetSyncPoint;
    da_FMOD_Sound_GetSyncPointInfo FMOD_Sound_GetSyncPointInfo;
    da_FMOD_Sound_AddSyncPoint FMOD_Sound_AddSyncPoint;
    da_FMOD_Sound_DeleteSyncPoint FMOD_Sound_DeleteSyncPoint;
    da_FMOD_Sound_SetMode FMOD_Sound_SetMode;
    da_FMOD_Sound_GetMode FMOD_Sound_GetMode;
    da_FMOD_Sound_SetLoopCount FMOD_Sound_SetLoopCount;
    da_FMOD_Sound_GetLoopCount FMOD_Sound_GetLoopCount;
    da_FMOD_Sound_SetLoopPoints FMOD_Sound_SetLoopPoints;
    da_FMOD_Sound_GetLoopPoints FMOD_Sound_GetLoopPoints;
    da_FMOD_Sound_GetMusicNumChannels FMOD_Sound_GetMusicNumChannels;
    da_FMOD_Sound_SetMusicChannelVolume FMOD_Sound_SetMusicChannelVolume;
    da_FMOD_Sound_GetMusicChannelVolume FMOD_Sound_GetMusicChannelVolume;
    da_FMOD_Sound_SetMusicSpeed FMOD_Sound_SetMusicSpeed;
    da_FMOD_Sound_GetMusicSpeed FMOD_Sound_GetMusicSpeed;
    da_FMOD_Sound_SetUserData FMOD_Sound_SetUserData;
    da_FMOD_Sound_GetUserData FMOD_Sound_GetUserData;
    da_FMOD_Channel_GetSystemObject FMOD_Channel_GetSystemObject;
    da_FMOD_Channel_Stop FMOD_Channel_Stop;
    da_FMOD_Channel_SetPaused FMOD_Channel_SetPaused;
    da_FMOD_Channel_GetPaused FMOD_Channel_GetPaused;
    da_FMOD_Channel_SetVolume FMOD_Channel_SetVolume;
    da_FMOD_Channel_GetVolume FMOD_Channel_GetVolume;
    da_FMOD_Channel_SetVolumeRamp FMOD_Channel_SetVolumeRamp;
    da_FMOD_Channel_GetVolumeRamp FMOD_Channel_GetVolumeRamp;
    da_FMOD_Channel_GetAudibility FMOD_Channel_GetAudibility;
    da_FMOD_Channel_SetPitch FMOD_Channel_SetPitch;
    da_FMOD_Channel_GetPitch FMOD_Channel_GetPitch;
    da_FMOD_Channel_SetMute FMOD_Channel_SetMute;
    da_FMOD_Channel_GetMute FMOD_Channel_GetMute;
    da_FMOD_Channel_SetReverbProperties FMOD_Channel_SetReverbProperties;
    da_FMOD_Channel_GetReverbProperties FMOD_Channel_GetReverbProperties;
    da_FMOD_Channel_SetLowPassGain FMOD_Channel_SetLowPassGain;
    da_FMOD_Channel_GetLowPassGain FMOD_Channel_GetLowPassGain;
    da_FMOD_Channel_SetMode FMOD_Channel_SetMode;
    da_FMOD_Channel_GetMode FMOD_Channel_GetMode;
    da_FMOD_Channel_SetCallback FMOD_Channel_SetCallback;
    da_FMOD_Channel_IsPlaying FMOD_Channel_IsPlaying;
    da_FMOD_Channel_SetPan FMOD_Channel_SetPan;
    da_FMOD_Channel_SetMixLevelsOutput FMOD_Channel_SetMixLevelsOutput;
    da_FMOD_Channel_SetMixLevelsInput FMOD_Channel_SetMixLevelsInput;
    da_FMOD_Channel_SetMixMatrix FMOD_Channel_SetMixMatrix;
    da_FMOD_Channel_GetMixMatrix FMOD_Channel_GetMixMatrix;
    da_FMOD_Channel_GetDSPClock FMOD_Channel_GetDSPClock;
    da_FMOD_Channel_SetDelay FMOD_Channel_SetDelay;
    da_FMOD_Channel_GetDelay FMOD_Channel_GetDelay;
    da_FMOD_Channel_AddFadePoint FMOD_Channel_AddFadePoint;
    da_FMOD_Channel_SetFadePointRamp FMOD_Channel_SetFadePointRamp;
    da_FMOD_Channel_RemoveFadePoints FMOD_Channel_RemoveFadePoints;
    da_FMOD_Channel_GetFadePoints FMOD_Channel_GetFadePoints;
    da_FMOD_Channel_GetDSP FMOD_Channel_GetDSP;
    da_FMOD_Channel_AddDSP FMOD_Channel_AddDSP;
    da_FMOD_Channel_RemoveDSP FMOD_Channel_RemoveDSP;
    da_FMOD_Channel_GetNumDSPs FMOD_Channel_GetNumDSPs;
    da_FMOD_Channel_SetDSPIndex FMOD_Channel_SetDSPIndex;
    da_FMOD_Channel_GetDSPIndex FMOD_Channel_GetDSPIndex;
    da_FMOD_Channel_OverridePanDSP FMOD_Channel_OverridePanDSP;
    da_FMOD_Channel_Set3DAttributes FMOD_Channel_Set3DAttributes;
    da_FMOD_Channel_Get3DAttributes FMOD_Channel_Get3DAttributes;
    da_FMOD_Channel_Set3DMinMaxDistance FMOD_Channel_Set3DMinMaxDistance;
    da_FMOD_Channel_Get3DMinMaxDistance FMOD_Channel_Get3DMinMaxDistance;
    da_FMOD_Channel_Set3DConeSettings FMOD_Channel_Set3DConeSettings;
    da_FMOD_Channel_Get3DConeSettings FMOD_Channel_Get3DConeSettings;
    da_FMOD_Channel_Set3DConeOrientation FMOD_Channel_Set3DConeOrientation;
    da_FMOD_Channel_Get3DConeOrientation FMOD_Channel_Get3DConeOrientation;
    da_FMOD_Channel_Set3DCustomRolloff FMOD_Channel_Set3DCustomRolloff;
    da_FMOD_Channel_Get3DCustomRolloff FMOD_Channel_Get3DCustomRolloff;
    da_FMOD_Channel_Set3DOcclusion FMOD_Channel_Set3DOcclusion;
    da_FMOD_Channel_Get3DOcclusion FMOD_Channel_Get3DOcclusion;
    da_FMOD_Channel_Set3DSpread FMOD_Channel_Set3DSpread;
    da_FMOD_Channel_Get3DSpread FMOD_Channel_Get3DSpread;
    da_FMOD_Channel_Set3DLevel FMOD_Channel_Set3DLevel;
    da_FMOD_Channel_Get3DLevel FMOD_Channel_Get3DLevel;
    da_FMOD_Channel_Set3DDopplerLevel FMOD_Channel_Set3DDopplerLevel;
    da_FMOD_Channel_Get3DDopplerLevel FMOD_Channel_Get3DDopplerLevel;
    da_FMOD_Channel_Set3DDistanceFilter FMOD_Channel_Set3DDistanceFilter;
    da_FMOD_Channel_Get3DDistanceFilter FMOD_Channel_Get3DDistanceFilter;
    da_FMOD_Channel_SetUserData FMOD_Channel_SetUserData;
    da_FMOD_Channel_GetUserData FMOD_Channel_GetUserData;
    da_FMOD_Channel_SetFrequency FMOD_Channel_SetFrequency;
    da_FMOD_Channel_GetFrequency FMOD_Channel_GetFrequency;
    da_FMOD_Channel_SetPriority FMOD_Channel_SetPriority;
    da_FMOD_Channel_GetPriority FMOD_Channel_GetPriority;
    da_FMOD_Channel_SetPosition FMOD_Channel_SetPosition;
    da_FMOD_Channel_GetPosition FMOD_Channel_GetPosition;
    da_FMOD_Channel_SetChannelGroup FMOD_Channel_SetChannelGroup;
    da_FMOD_Channel_GetChannelGroup FMOD_Channel_GetChannelGroup;
    da_FMOD_Channel_SetLoopCount FMOD_Channel_SetLoopCount;
    da_FMOD_Channel_GetLoopCount FMOD_Channel_GetLoopCount;
    da_FMOD_Channel_SetLoopPoints FMOD_Channel_SetLoopPoints;
    da_FMOD_Channel_GetLoopPoints FMOD_Channel_GetLoopPoints;
    da_FMOD_Channel_IsVirtual FMOD_Channel_IsVirtual;
    da_FMOD_Channel_GetCurrentSound FMOD_Channel_GetCurrentSound;
    da_FMOD_Channel_GetIndex FMOD_Channel_GetIndex;
    da_FMOD_ChannelGroup_GetSystemObject FMOD_ChannelGroup_GetSystemObject;
    da_FMOD_ChannelGroup_Stop FMOD_ChannelGroup_Stop;
    da_FMOD_ChannelGroup_SetPaused FMOD_ChannelGroup_SetPaused;
    da_FMOD_ChannelGroup_GetPaused FMOD_ChannelGroup_GetPaused;
    da_FMOD_ChannelGroup_SetVolume FMOD_ChannelGroup_SetVolume;
    da_FMOD_ChannelGroup_GetVolume FMOD_ChannelGroup_GetVolume;
    da_FMOD_ChannelGroup_SetVolumeRamp FMOD_ChannelGroup_SetVolumeRamp;
    da_FMOD_ChannelGroup_GetVolumeRamp FMOD_ChannelGroup_GetVolumeRamp;
    da_FMOD_ChannelGroup_GetAudibility FMOD_ChannelGroup_GetAudibility;
    da_FMOD_ChannelGroup_SetPitch FMOD_ChannelGroup_SetPitch;
    da_FMOD_ChannelGroup_GetPitch FMOD_ChannelGroup_GetPitch;
    da_FMOD_ChannelGroup_SetMute FMOD_ChannelGroup_SetMute;
    da_FMOD_ChannelGroup_GetMute FMOD_ChannelGroup_GetMute;
    da_FMOD_ChannelGroup_SetReverbProperties FMOD_ChannelGroup_SetReverbProperties;
    da_FMOD_ChannelGroup_GetReverbProperties FMOD_ChannelGroup_GetReverbProperties;
    da_FMOD_ChannelGroup_SetLowPassGain FMOD_ChannelGroup_SetLowPassGain;
    da_FMOD_ChannelGroup_GetLowPassGain FMOD_ChannelGroup_GetLowPassGain;
    da_FMOD_ChannelGroup_SetMode FMOD_ChannelGroup_SetMode;
    da_FMOD_ChannelGroup_GetMode FMOD_ChannelGroup_GetMode;
    da_FMOD_ChannelGroup_SetCallback FMOD_ChannelGroup_SetCallback;
    da_FMOD_ChannelGroup_IsPlaying FMOD_ChannelGroup_IsPlaying;
    da_FMOD_ChannelGroup_SetPan FMOD_ChannelGroup_SetPan;
    da_FMOD_ChannelGroup_SetMixLevelsOutput FMOD_ChannelGroup_SetMixLevelsOutput;
    da_FMOD_ChannelGroup_SetMixLevelsInput FMOD_ChannelGroup_SetMixLevelsInput;
    da_FMOD_ChannelGroup_SetMixMatrix FMOD_ChannelGroup_SetMixMatrix;
    da_FMOD_ChannelGroup_GetMixMatrix FMOD_ChannelGroup_GetMixMatrix;
    da_FMOD_ChannelGroup_GetDSPClock FMOD_ChannelGroup_GetDSPClock;
    da_FMOD_ChannelGroup_SetDelay FMOD_ChannelGroup_SetDelay;
    da_FMOD_ChannelGroup_GetDelay FMOD_ChannelGroup_GetDelay;
    da_FMOD_ChannelGroup_AddFadePoint FMOD_ChannelGroup_AddFadePoint;
    da_FMOD_ChannelGroup_SetFadePointRamp FMOD_ChannelGroup_SetFadePointRamp;
    da_FMOD_ChannelGroup_RemoveFadePoints FMOD_ChannelGroup_RemoveFadePoints;
    da_FMOD_ChannelGroup_GetFadePoints FMOD_ChannelGroup_GetFadePoints;
    da_FMOD_ChannelGroup_GetDSP FMOD_ChannelGroup_GetDSP;
    da_FMOD_ChannelGroup_AddDSP FMOD_ChannelGroup_AddDSP;
    da_FMOD_ChannelGroup_RemoveDSP FMOD_ChannelGroup_RemoveDSP;
    da_FMOD_ChannelGroup_GetNumDSPs FMOD_ChannelGroup_GetNumDSPs;
    da_FMOD_ChannelGroup_SetDSPIndex FMOD_ChannelGroup_SetDSPIndex;
    da_FMOD_ChannelGroup_GetDSPIndex FMOD_ChannelGroup_GetDSPIndex;
    da_FMOD_ChannelGroup_OverridePanDSP FMOD_ChannelGroup_OverridePanDSP;
    da_FMOD_ChannelGroup_Set3DAttributes FMOD_ChannelGroup_Set3DAttributes;
    da_FMOD_ChannelGroup_Get3DAttributes FMOD_ChannelGroup_Get3DAttributes;
    da_FMOD_ChannelGroup_Set3DMinMaxDistance FMOD_ChannelGroup_Set3DMinMaxDistance;
    da_FMOD_ChannelGroup_Get3DMinMaxDistance FMOD_ChannelGroup_Get3DMinMaxDistance;
    da_FMOD_ChannelGroup_Set3DConeSettings FMOD_ChannelGroup_Set3DConeSettings;
    da_FMOD_ChannelGroup_Get3DConeSettings FMOD_ChannelGroup_Get3DConeSettings;
    da_FMOD_ChannelGroup_Set3DConeOrientation FMOD_ChannelGroup_Set3DConeOrientation;
    da_FMOD_ChannelGroup_Get3DConeOrientation FMOD_ChannelGroup_Get3DConeOrientation;
    da_FMOD_ChannelGroup_Set3DCustomRolloff FMOD_ChannelGroup_Set3DCustomRolloff;
    da_FMOD_ChannelGroup_Get3DCustomRolloff FMOD_ChannelGroup_Get3DCustomRolloff;
    da_FMOD_ChannelGroup_Set3DOcclusion FMOD_ChannelGroup_Set3DOcclusion;
    da_FMOD_ChannelGroup_Get3DOcclusion FMOD_ChannelGroup_Get3DOcclusion;
    da_FMOD_ChannelGroup_Set3DSpread FMOD_ChannelGroup_Set3DSpread;
    da_FMOD_ChannelGroup_Get3DSpread FMOD_ChannelGroup_Get3DSpread;
    da_FMOD_ChannelGroup_Set3DLevel FMOD_ChannelGroup_Set3DLevel;
    da_FMOD_ChannelGroup_Get3DLevel FMOD_ChannelGroup_Get3DLevel;
    da_FMOD_ChannelGroup_Set3DDopplerLevel FMOD_ChannelGroup_Set3DDopplerLevel;
    da_FMOD_ChannelGroup_Get3DDopplerLevel FMOD_ChannelGroup_Get3DDopplerLevel;
    da_FMOD_ChannelGroup_Set3DDistanceFilter FMOD_ChannelGroup_Set3DDistanceFilter;
    da_FMOD_ChannelGroup_Get3DDistanceFilter FMOD_ChannelGroup_Get3DDistanceFilter;
    da_FMOD_ChannelGroup_SetUserData FMOD_ChannelGroup_SetUserData;
    da_FMOD_ChannelGroup_GetUserData FMOD_ChannelGroup_GetUserData;
    da_FMOD_ChannelGroup_Release FMOD_ChannelGroup_Release;
    da_FMOD_ChannelGroup_AddGroup FMOD_ChannelGroup_AddGroup;
    da_FMOD_ChannelGroup_GetNumGroups FMOD_ChannelGroup_GetNumGroups;
    da_FMOD_ChannelGroup_GetGroup FMOD_ChannelGroup_GetGroup;
    da_FMOD_ChannelGroup_GetParentGroup FMOD_ChannelGroup_GetParentGroup;
    da_FMOD_ChannelGroup_GetName FMOD_ChannelGroup_GetName;
    da_FMOD_ChannelGroup_GetNumChannels FMOD_ChannelGroup_GetNumChannels;
    da_FMOD_ChannelGroup_GetChannel FMOD_ChannelGroup_GetChannel;
    da_FMOD_SoundGroup_Release FMOD_SoundGroup_Release;
    da_FMOD_SoundGroup_GetSystemObject FMOD_SoundGroup_GetSystemObject;
    da_FMOD_SoundGroup_SetMaxAudible FMOD_SoundGroup_SetMaxAudible;
    da_FMOD_SoundGroup_GetMaxAudible FMOD_SoundGroup_GetMaxAudible;
    da_FMOD_SoundGroup_SetMaxAudibleBehavior FMOD_SoundGroup_SetMaxAudibleBehavior;
    da_FMOD_SoundGroup_GetMaxAudibleBehavior FMOD_SoundGroup_GetMaxAudibleBehavior;
    da_FMOD_SoundGroup_SetMuteFadeSpeed FMOD_SoundGroup_SetMuteFadeSpeed;
    da_FMOD_SoundGroup_GetMuteFadeSpeed FMOD_SoundGroup_GetMuteFadeSpeed;
    da_FMOD_SoundGroup_SetVolume FMOD_SoundGroup_SetVolume;
    da_FMOD_SoundGroup_GetVolume FMOD_SoundGroup_GetVolume;
    da_FMOD_SoundGroup_Stop FMOD_SoundGroup_Stop;
    da_FMOD_SoundGroup_GetName FMOD_SoundGroup_GetName;
    da_FMOD_SoundGroup_GetNumSounds FMOD_SoundGroup_GetNumSounds;
    da_FMOD_SoundGroup_GetSound FMOD_SoundGroup_GetSound;
    da_FMOD_SoundGroup_GetNumPlaying FMOD_SoundGroup_GetNumPlaying;
    da_FMOD_SoundGroup_SetUserData FMOD_SoundGroup_SetUserData;
    da_FMOD_SoundGroup_GetUserData FMOD_SoundGroup_GetUserData;
    da_FMOD_DSP_Release FMOD_DSP_Release;
    da_FMOD_DSP_GetSystemObject FMOD_DSP_GetSystemObject;
    da_FMOD_DSP_AddInput FMOD_DSP_AddInput;
    da_FMOD_DSP_DisconnectFrom FMOD_DSP_DisconnectFrom;
    da_FMOD_DSP_DisconnectAll FMOD_DSP_DisconnectAll;
    da_FMOD_DSP_GetNumInputs FMOD_DSP_GetNumInputs;
    da_FMOD_DSP_GetNumOutputs FMOD_DSP_GetNumOutputs;
    da_FMOD_DSP_GetInput FMOD_DSP_GetInput;
    da_FMOD_DSP_GetOutput FMOD_DSP_GetOutput;
    da_FMOD_DSP_SetActive FMOD_DSP_SetActive;
    da_FMOD_DSP_GetActive FMOD_DSP_GetActive;
    da_FMOD_DSP_SetBypass FMOD_DSP_SetBypass;
    da_FMOD_DSP_GetBypass FMOD_DSP_GetBypass;
    da_FMOD_DSP_SetWetDryMix FMOD_DSP_SetWetDryMix;
    da_FMOD_DSP_GetWetDryMix FMOD_DSP_GetWetDryMix;
    da_FMOD_DSP_SetChannelFormat FMOD_DSP_SetChannelFormat;
    da_FMOD_DSP_GetChannelFormat FMOD_DSP_GetChannelFormat;
    da_FMOD_DSP_GetOutputChannelFormat FMOD_DSP_GetOutputChannelFormat;
    da_FMOD_DSP_Reset FMOD_DSP_Reset;
    da_FMOD_DSP_SetParameterFloat FMOD_DSP_SetParameterFloat;
    da_FMOD_DSP_SetParameterInt FMOD_DSP_SetParameterInt;
    da_FMOD_DSP_SetParameterBool FMOD_DSP_SetParameterBool;
    da_FMOD_DSP_SetParameterData FMOD_DSP_SetParameterData;
    da_FMOD_DSP_GetParameterFloat FMOD_DSP_GetParameterFloat;
    da_FMOD_DSP_GetParameterInt FMOD_DSP_GetParameterInt;
    da_FMOD_DSP_GetParameterBool FMOD_DSP_GetParameterBool;
    da_FMOD_DSP_GetParameterData FMOD_DSP_GetParameterData;
    da_FMOD_DSP_GetNumParameters FMOD_DSP_GetNumParameters;
    da_FMOD_DSP_GetParameterInfo FMOD_DSP_GetParameterInfo;
    da_FMOD_DSP_GetDataParameterIndex FMOD_DSP_GetDataParameterIndex;
    da_FMOD_DSP_ShowConfigDialog FMOD_DSP_ShowConfigDialog;
    da_FMOD_DSP_GetInfo FMOD_DSP_GetInfo;
    da_FMOD_DSP_GetType FMOD_DSP_GetType;
    da_FMOD_DSP_GetIdle FMOD_DSP_GetIdle;
    da_FMOD_DSP_SetUserData FMOD_DSP_SetUserData;
    da_FMOD_DSP_GetUserData FMOD_DSP_GetUserData;
    da_FMOD_DSP_SetMeteringEnabled FMOD_DSP_SetMeteringEnabled;
    da_FMOD_DSP_GetMeteringEnabled FMOD_DSP_GetMeteringEnabled;
    da_FMOD_DSP_GetMeteringInfo FMOD_DSP_GetMeteringInfo;
    da_FMOD_DSPConnection_GetInput FMOD_DSPConnection_GetInput;
    da_FMOD_DSPConnection_GetOutput FMOD_DSPConnection_GetOutput;
    da_FMOD_DSPConnection_SetMix FMOD_DSPConnection_SetMix;
    da_FMOD_DSPConnection_GetMix FMOD_DSPConnection_GetMix;
    da_FMOD_DSPConnection_SetMixMatrix FMOD_DSPConnection_SetMixMatrix;
    da_FMOD_DSPConnection_GetMixMatrix FMOD_DSPConnection_GetMixMatrix;
    da_FMOD_DSPConnection_GetType FMOD_DSPConnection_GetType;
    da_FMOD_DSPConnection_SetUserData FMOD_DSPConnection_SetUserData;
    da_FMOD_DSPConnection_GetUserData FMOD_DSPConnection_GetUserData;
    da_FMOD_Geometry_Release FMOD_Geometry_Release;
    da_FMOD_Geometry_AddPolygon FMOD_Geometry_AddPolygon;
    da_FMOD_Geometry_GetNumPolygons FMOD_Geometry_GetNumPolygons;
    da_FMOD_Geometry_GetMaxPolygons FMOD_Geometry_GetMaxPolygons;
    da_FMOD_Geometry_GetPolygonNumVertices FMOD_Geometry_GetPolygonNumVertices;
    da_FMOD_Geometry_SetPolygonVertex FMOD_Geometry_SetPolygonVertex;
    da_FMOD_Geometry_GetPolygonVertex FMOD_Geometry_GetPolygonVertex;
    da_FMOD_Geometry_SetPolygonAttributes FMOD_Geometry_SetPolygonAttributes;
    da_FMOD_Geometry_GetPolygonAttributes FMOD_Geometry_GetPolygonAttributes;
    da_FMOD_Geometry_SetActive FMOD_Geometry_SetActive;
    da_FMOD_Geometry_GetActive FMOD_Geometry_GetActive;
    da_FMOD_Geometry_SetRotation FMOD_Geometry_SetRotation;
    da_FMOD_Geometry_GetRotation FMOD_Geometry_GetRotation;
    da_FMOD_Geometry_SetPosition FMOD_Geometry_SetPosition;
    da_FMOD_Geometry_GetPosition FMOD_Geometry_GetPosition;
    da_FMOD_Geometry_SetScale FMOD_Geometry_SetScale;
    da_FMOD_Geometry_GetScale FMOD_Geometry_GetScale;
    da_FMOD_Geometry_Save FMOD_Geometry_Save;
    da_FMOD_Geometry_SetUserData FMOD_Geometry_SetUserData;
    da_FMOD_Geometry_GetUserData FMOD_Geometry_GetUserData;
    da_FMOD_Reverb3D_Release FMOD_Reverb3D_Release;
    da_FMOD_Reverb3D_Set3DAttributes FMOD_Reverb3D_Set3DAttributes;
    da_FMOD_Reverb3D_Get3DAttributes FMOD_Reverb3D_Get3DAttributes;
    da_FMOD_Reverb3D_SetProperties FMOD_Reverb3D_SetProperties;
    da_FMOD_Reverb3D_GetProperties FMOD_Reverb3D_GetProperties;
    da_FMOD_Reverb3D_SetActive FMOD_Reverb3D_SetActive;
    da_FMOD_Reverb3D_GetActive FMOD_Reverb3D_GetActive;
    da_FMOD_Reverb3D_SetUserData FMOD_Reverb3D_SetUserData;
    da_FMOD_Reverb3D_GetUserData FMOD_Reverb3D_GetUserData;
}


  

