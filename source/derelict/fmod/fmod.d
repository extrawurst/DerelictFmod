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
module derelict.fmod.fmod;

public
{
    import derelict.fmod.dsp;
    import derelict.fmod.codec;
    import derelict.fmod.common;
    import derelict.fmod.funcs;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "fmod.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "libfmod.dylib";
    else static if (Derelict_OS_Linux)
        enum libNames = "libfmod.so";
    else
        static assert(0, "Need to implement FMOD libNames for this operating system.");
}

class DerelictFmodLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {          
            bindFunc(cast(void**)&FMOD_Memory_Initialize, "FMOD_Memory_Initialize");
            bindFunc(cast(void**)&FMOD_Memory_GetStats, "FMOD_Memory_GetStats");
            bindFunc(cast(void**)&FMOD_Debug_Initialize, "FMOD_Debug_Initialize");
            bindFunc(cast(void**)&FMOD_File_SetDiskBusy, "FMOD_File_SetDiskBusy");
            bindFunc(cast(void**)&FMOD_File_GetDiskBusy, "FMOD_File_GetDiskBusy");
            bindFunc(cast(void**)&FMOD_System_Create, "FMOD_System_Create");
            bindFunc(cast(void**)&FMOD_System_Release, "FMOD_System_Release");
            bindFunc(cast(void**)&FMOD_System_SetOutput, "FMOD_System_SetOutput");
            bindFunc(cast(void**)&FMOD_System_GetOutput, "FMOD_System_GetOutput");
            bindFunc(cast(void**)&FMOD_System_GetNumDrivers, "FMOD_System_GetNumDrivers");
            bindFunc(cast(void**)&FMOD_System_GetDriverInfo, "FMOD_System_GetDriverInfo");
            bindFunc(cast(void**)&FMOD_System_SetDriver, "FMOD_System_SetDriver");
            bindFunc(cast(void**)&FMOD_System_GetDriver, "FMOD_System_GetDriver");
            bindFunc(cast(void**)&FMOD_System_SetSoftwareChannels, "FMOD_System_SetSoftwareChannels");
            bindFunc(cast(void**)&FMOD_System_GetSoftwareChannels, "FMOD_System_GetSoftwareChannels");
            bindFunc(cast(void**)&FMOD_System_SetSoftwareFormat, "FMOD_System_SetSoftwareFormat");
            bindFunc(cast(void**)&FMOD_System_GetSoftwareFormat, "FMOD_System_GetSoftwareFormat");
            bindFunc(cast(void**)&FMOD_System_SetDSPBufferSize, "FMOD_System_SetDSPBufferSize");
            bindFunc(cast(void**)&FMOD_System_GetDSPBufferSize, "FMOD_System_GetDSPBufferSize");
            bindFunc(cast(void**)&FMOD_System_SetFileSystem, "FMOD_System_SetFileSystem");
            bindFunc(cast(void**)&FMOD_System_AttachFileSystem, "FMOD_System_AttachFileSystem");
            bindFunc(cast(void**)&FMOD_System_SetAdvancedSettings, "FMOD_System_SetAdvancedSettings");
            bindFunc(cast(void**)&FMOD_System_GetAdvancedSettings, "FMOD_System_GetAdvancedSettings");
            bindFunc(cast(void**)&FMOD_System_SetCallback, "FMOD_System_SetCallback");
            bindFunc(cast(void**)&FMOD_System_SetPluginPath, "FMOD_System_SetPluginPath");
            bindFunc(cast(void**)&FMOD_System_LoadPlugin, "FMOD_System_LoadPlugin");
            bindFunc(cast(void**)&FMOD_System_UnloadPlugin, "FMOD_System_UnloadPlugin");
            bindFunc(cast(void**)&FMOD_System_GetNumPlugins, "FMOD_System_GetNumPlugins");
            bindFunc(cast(void**)&FMOD_System_GetPluginHandle, "FMOD_System_GetPluginHandle");
            bindFunc(cast(void**)&FMOD_System_GetPluginInfo, "FMOD_System_GetPluginInfo");
            bindFunc(cast(void**)&FMOD_System_SetOutputByPlugin, "FMOD_System_SetOutputByPlugin");
            bindFunc(cast(void**)&FMOD_System_GetOutputByPlugin, "FMOD_System_GetOutputByPlugin");
            bindFunc(cast(void**)&FMOD_System_CreateDSPByPlugin, "FMOD_System_CreateDSPByPlugin");
            bindFunc(cast(void**)&FMOD_System_GetDSPInfoByPlugin, "FMOD_System_GetDSPInfoByPlugin");
            bindFunc(cast(void**)&FMOD_System_RegisterCodec, "FMOD_System_RegisterCodec");
            bindFunc(cast(void**)&FMOD_System_RegisterDSP, "FMOD_System_RegisterDSP");
            bindFunc(cast(void**)&FMOD_System_RegisterOutput, "FMOD_System_RegisterOutput");
            bindFunc(cast(void**)&FMOD_System_Init, "FMOD_System_Init");
            bindFunc(cast(void**)&FMOD_System_Close, "FMOD_System_Close");
            bindFunc(cast(void**)&FMOD_System_Update, "FMOD_System_Update");
            bindFunc(cast(void**)&FMOD_System_SetSpeakerPosition, "FMOD_System_SetSpeakerPosition");
            bindFunc(cast(void**)&FMOD_System_GetSpeakerPosition, "FMOD_System_GetSpeakerPosition");
            bindFunc(cast(void**)&FMOD_System_SetStreamBufferSize, "FMOD_System_SetStreamBufferSize");
            bindFunc(cast(void**)&FMOD_System_GetStreamBufferSize, "FMOD_System_GetStreamBufferSize");
            bindFunc(cast(void**)&FMOD_System_Set3DSettings, "FMOD_System_Set3DSettings");
            bindFunc(cast(void**)&FMOD_System_Get3DSettings, "FMOD_System_Get3DSettings");
            bindFunc(cast(void**)&FMOD_System_Set3DNumListeners, "FMOD_System_Set3DNumListeners");
            bindFunc(cast(void**)&FMOD_System_Get3DNumListeners, "FMOD_System_Get3DNumListeners");
            bindFunc(cast(void**)&FMOD_System_Set3DListenerAttributes, "FMOD_System_Set3DListenerAttributes");
            bindFunc(cast(void**)&FMOD_System_Get3DListenerAttributes, "FMOD_System_Get3DListenerAttributes");
            bindFunc(cast(void**)&FMOD_System_Set3DRolloffCallback, "FMOD_System_Set3DRolloffCallback");
            bindFunc(cast(void**)&FMOD_System_MixerSuspend, "FMOD_System_MixerSuspend");
            bindFunc(cast(void**)&FMOD_System_MixerResume, "FMOD_System_MixerResume");
            bindFunc(cast(void**)&FMOD_System_GetDefaultMixMatrix, "FMOD_System_GetDefaultMixMatrix");
            bindFunc(cast(void**)&FMOD_System_GetSpeakerModeChannels, "FMOD_System_GetSpeakerModeChannels");
            bindFunc(cast(void**)&FMOD_System_GetVersion, "FMOD_System_GetVersion");
            bindFunc(cast(void**)&FMOD_System_GetOutputHandle, "FMOD_System_GetOutputHandle");
            bindFunc(cast(void**)&FMOD_System_GetChannelsPlaying, "FMOD_System_GetChannelsPlaying");
            bindFunc(cast(void**)&FMOD_System_GetCPUUsage, "FMOD_System_GetCPUUsage");
            bindFunc(cast(void**)&FMOD_System_GetSoundRAM, "FMOD_System_GetSoundRAM");
            bindFunc(cast(void**)&FMOD_System_CreateSound, "FMOD_System_CreateSound");
            bindFunc(cast(void**)&FMOD_System_CreateStream, "FMOD_System_CreateStream");
            bindFunc(cast(void**)&FMOD_System_CreateDSP, "FMOD_System_CreateDSP");
            bindFunc(cast(void**)&FMOD_System_CreateDSPByType, "FMOD_System_CreateDSPByType");
            bindFunc(cast(void**)&FMOD_System_CreateChannelGroup, "FMOD_System_CreateChannelGroup");
            bindFunc(cast(void**)&FMOD_System_CreateSoundGroup, "FMOD_System_CreateSoundGroup");
            bindFunc(cast(void**)&FMOD_System_CreateReverb3D, "FMOD_System_CreateReverb3D");
            bindFunc(cast(void**)&FMOD_System_PlaySound, "FMOD_System_PlaySound");
            bindFunc(cast(void**)&FMOD_System_PlayDSP, "FMOD_System_PlayDSP");
            bindFunc(cast(void**)&FMOD_System_GetChannel, "FMOD_System_GetChannel");
            bindFunc(cast(void**)&FMOD_System_GetMasterChannelGroup, "FMOD_System_GetMasterChannelGroup");
            bindFunc(cast(void**)&FMOD_System_GetMasterSoundGroup, "FMOD_System_GetMasterSoundGroup");
            bindFunc(cast(void**)&FMOD_System_AttachChannelGroupToPort, "FMOD_System_AttachChannelGroupToPort");
            bindFunc(cast(void**)&FMOD_System_DetachChannelGroupFromPort, "FMOD_System_DetachChannelGroupFromPort");
            bindFunc(cast(void**)&FMOD_System_SetReverbProperties, "FMOD_System_SetReverbProperties");
            bindFunc(cast(void**)&FMOD_System_GetReverbProperties, "FMOD_System_GetReverbProperties");
            bindFunc(cast(void**)&FMOD_System_LockDSP, "FMOD_System_LockDSP");
            bindFunc(cast(void**)&FMOD_System_UnlockDSP, "FMOD_System_UnlockDSP");
            bindFunc(cast(void**)&FMOD_System_GetRecordNumDrivers, "FMOD_System_GetRecordNumDrivers");
            bindFunc(cast(void**)&FMOD_System_GetRecordDriverInfo, "FMOD_System_GetRecordDriverInfo");
            bindFunc(cast(void**)&FMOD_System_GetRecordPosition, "FMOD_System_GetRecordPosition");
            bindFunc(cast(void**)&FMOD_System_RecordStart, "FMOD_System_RecordStart");
            bindFunc(cast(void**)&FMOD_System_RecordStop, "FMOD_System_RecordStop");
            bindFunc(cast(void**)&FMOD_System_IsRecording, "FMOD_System_IsRecording");
            bindFunc(cast(void**)&FMOD_System_CreateGeometry, "FMOD_System_CreateGeometry");
            bindFunc(cast(void**)&FMOD_System_SetGeometrySettings, "FMOD_System_SetGeometrySettings");
            bindFunc(cast(void**)&FMOD_System_GetGeometrySettings, "FMOD_System_GetGeometrySettings");
            bindFunc(cast(void**)&FMOD_System_LoadGeometry, "FMOD_System_LoadGeometry");
            bindFunc(cast(void**)&FMOD_System_GetGeometryOcclusion, "FMOD_System_GetGeometryOcclusion");
            bindFunc(cast(void**)&FMOD_System_SetNetworkProxy, "FMOD_System_SetNetworkProxy");
            bindFunc(cast(void**)&FMOD_System_GetNetworkProxy, "FMOD_System_GetNetworkProxy");
            bindFunc(cast(void**)&FMOD_System_SetNetworkTimeout, "FMOD_System_SetNetworkTimeout");
            bindFunc(cast(void**)&FMOD_System_GetNetworkTimeout, "FMOD_System_GetNetworkTimeout");
            bindFunc(cast(void**)&FMOD_System_SetUserData, "FMOD_System_SetUserData");
            bindFunc(cast(void**)&FMOD_System_GetUserData, "FMOD_System_GetUserData");
            bindFunc(cast(void**)&FMOD_Sound_Release, "FMOD_Sound_Release");
            bindFunc(cast(void**)&FMOD_Sound_GetSystemObject, "FMOD_Sound_GetSystemObject");
            bindFunc(cast(void**)&FMOD_Sound_Lock, "FMOD_Sound_Lock");
            bindFunc(cast(void**)&FMOD_Sound_Unlock, "FMOD_Sound_Unlock");
            bindFunc(cast(void**)&FMOD_Sound_SetDefaults, "FMOD_Sound_SetDefaults");
            bindFunc(cast(void**)&FMOD_Sound_GetDefaults, "FMOD_Sound_GetDefaults");
            bindFunc(cast(void**)&FMOD_Sound_Set3DMinMaxDistance, "FMOD_Sound_Set3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_Sound_Get3DMinMaxDistance, "FMOD_Sound_Get3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_Sound_Set3DConeSettings, "FMOD_Sound_Set3DConeSettings");
            bindFunc(cast(void**)&FMOD_Sound_Get3DConeSettings, "FMOD_Sound_Get3DConeSettings");
            bindFunc(cast(void**)&FMOD_Sound_Set3DCustomRolloff, "FMOD_Sound_Set3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_Sound_Get3DCustomRolloff, "FMOD_Sound_Get3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_Sound_GetSubSound, "FMOD_Sound_GetSubSound");
            bindFunc(cast(void**)&FMOD_Sound_GetSubSoundParent, "FMOD_Sound_GetSubSoundParent");
            bindFunc(cast(void**)&FMOD_Sound_GetName, "FMOD_Sound_GetName");
            bindFunc(cast(void**)&FMOD_Sound_GetLength, "FMOD_Sound_GetLength");
            bindFunc(cast(void**)&FMOD_Sound_GetFormat, "FMOD_Sound_GetFormat");
            bindFunc(cast(void**)&FMOD_Sound_GetNumSubSounds, "FMOD_Sound_GetNumSubSounds");
            bindFunc(cast(void**)&FMOD_Sound_GetNumTags, "FMOD_Sound_GetNumTags");
            bindFunc(cast(void**)&FMOD_Sound_GetTag, "FMOD_Sound_GetTag");
            bindFunc(cast(void**)&FMOD_Sound_GetOpenState, "FMOD_Sound_GetOpenState");
            bindFunc(cast(void**)&FMOD_Sound_ReadData, "FMOD_Sound_ReadData");
            bindFunc(cast(void**)&FMOD_Sound_SeekData, "FMOD_Sound_SeekData");
            bindFunc(cast(void**)&FMOD_Sound_SetSoundGroup, "FMOD_Sound_SetSoundGroup");
            bindFunc(cast(void**)&FMOD_Sound_GetSoundGroup, "FMOD_Sound_GetSoundGroup");
            bindFunc(cast(void**)&FMOD_Sound_GetNumSyncPoints, "FMOD_Sound_GetNumSyncPoints");
            bindFunc(cast(void**)&FMOD_Sound_GetSyncPoint, "FMOD_Sound_GetSyncPoint");
            bindFunc(cast(void**)&FMOD_Sound_GetSyncPointInfo, "FMOD_Sound_GetSyncPointInfo");
            bindFunc(cast(void**)&FMOD_Sound_AddSyncPoint, "FMOD_Sound_AddSyncPoint");
            bindFunc(cast(void**)&FMOD_Sound_DeleteSyncPoint, "FMOD_Sound_DeleteSyncPoint");
            bindFunc(cast(void**)&FMOD_Sound_SetMode, "FMOD_Sound_SetMode");
            bindFunc(cast(void**)&FMOD_Sound_GetMode, "FMOD_Sound_GetMode");
            bindFunc(cast(void**)&FMOD_Sound_SetLoopCount, "FMOD_Sound_SetLoopCount");
            bindFunc(cast(void**)&FMOD_Sound_GetLoopCount, "FMOD_Sound_GetLoopCount");
            bindFunc(cast(void**)&FMOD_Sound_SetLoopPoints, "FMOD_Sound_SetLoopPoints");
            bindFunc(cast(void**)&FMOD_Sound_GetLoopPoints, "FMOD_Sound_GetLoopPoints");
            bindFunc(cast(void**)&FMOD_Sound_GetMusicNumChannels, "FMOD_Sound_GetMusicNumChannels");
            bindFunc(cast(void**)&FMOD_Sound_SetMusicChannelVolume, "FMOD_Sound_SetMusicChannelVolume");
            bindFunc(cast(void**)&FMOD_Sound_GetMusicChannelVolume, "FMOD_Sound_GetMusicChannelVolume");
            bindFunc(cast(void**)&FMOD_Sound_SetMusicSpeed, "FMOD_Sound_SetMusicSpeed");
            bindFunc(cast(void**)&FMOD_Sound_GetMusicSpeed, "FMOD_Sound_GetMusicSpeed");
            bindFunc(cast(void**)&FMOD_Sound_SetUserData, "FMOD_Sound_SetUserData");
            bindFunc(cast(void**)&FMOD_Sound_GetUserData, "FMOD_Sound_GetUserData");
            bindFunc(cast(void**)&FMOD_Channel_GetSystemObject, "FMOD_Channel_GetSystemObject");
            bindFunc(cast(void**)&FMOD_Channel_Stop, "FMOD_Channel_Stop");
            bindFunc(cast(void**)&FMOD_Channel_SetPaused, "FMOD_Channel_SetPaused");
            bindFunc(cast(void**)&FMOD_Channel_GetPaused, "FMOD_Channel_GetPaused");
            bindFunc(cast(void**)&FMOD_Channel_SetVolume, "FMOD_Channel_SetVolume");
            bindFunc(cast(void**)&FMOD_Channel_GetVolume, "FMOD_Channel_GetVolume");
            bindFunc(cast(void**)&FMOD_Channel_SetVolumeRamp, "FMOD_Channel_SetVolumeRamp");
            bindFunc(cast(void**)&FMOD_Channel_GetVolumeRamp, "FMOD_Channel_GetVolumeRamp");
            bindFunc(cast(void**)&FMOD_Channel_GetAudibility, "FMOD_Channel_GetAudibility");
            bindFunc(cast(void**)&FMOD_Channel_SetPitch, "FMOD_Channel_SetPitch");
            bindFunc(cast(void**)&FMOD_Channel_GetPitch, "FMOD_Channel_GetPitch");
            bindFunc(cast(void**)&FMOD_Channel_SetMute, "FMOD_Channel_SetMute");
            bindFunc(cast(void**)&FMOD_Channel_GetMute, "FMOD_Channel_GetMute");
            bindFunc(cast(void**)&FMOD_Channel_SetReverbProperties, "FMOD_Channel_SetReverbProperties");
            bindFunc(cast(void**)&FMOD_Channel_GetReverbProperties, "FMOD_Channel_GetReverbProperties");
            bindFunc(cast(void**)&FMOD_Channel_SetLowPassGain, "FMOD_Channel_SetLowPassGain");
            bindFunc(cast(void**)&FMOD_Channel_GetLowPassGain, "FMOD_Channel_GetLowPassGain");
            bindFunc(cast(void**)&FMOD_Channel_SetMode, "FMOD_Channel_SetMode");
            bindFunc(cast(void**)&FMOD_Channel_GetMode, "FMOD_Channel_GetMode");
            bindFunc(cast(void**)&FMOD_Channel_SetCallback, "FMOD_Channel_SetCallback");
            bindFunc(cast(void**)&FMOD_Channel_IsPlaying, "FMOD_Channel_IsPlaying");
            bindFunc(cast(void**)&FMOD_Channel_SetPan, "FMOD_Channel_SetPan");
            bindFunc(cast(void**)&FMOD_Channel_SetMixLevelsOutput, "FMOD_Channel_SetMixLevelsOutput");
            bindFunc(cast(void**)&FMOD_Channel_SetMixLevelsInput, "FMOD_Channel_SetMixLevelsInput");
            bindFunc(cast(void**)&FMOD_Channel_SetMixMatrix, "FMOD_Channel_SetMixMatrix");
            bindFunc(cast(void**)&FMOD_Channel_GetMixMatrix, "FMOD_Channel_GetMixMatrix");
            bindFunc(cast(void**)&FMOD_Channel_GetDSPClock, "FMOD_Channel_GetDSPClock");
            bindFunc(cast(void**)&FMOD_Channel_SetDelay, "FMOD_Channel_SetDelay");
            bindFunc(cast(void**)&FMOD_Channel_GetDelay, "FMOD_Channel_GetDelay");
            bindFunc(cast(void**)&FMOD_Channel_AddFadePoint, "FMOD_Channel_AddFadePoint");
            bindFunc(cast(void**)&FMOD_Channel_SetFadePointRamp, "FMOD_Channel_SetFadePointRamp");
            bindFunc(cast(void**)&FMOD_Channel_RemoveFadePoints, "FMOD_Channel_RemoveFadePoints");
            bindFunc(cast(void**)&FMOD_Channel_GetFadePoints, "FMOD_Channel_GetFadePoints");
            bindFunc(cast(void**)&FMOD_Channel_GetDSP, "FMOD_Channel_GetDSP");
            bindFunc(cast(void**)&FMOD_Channel_AddDSP, "FMOD_Channel_AddDSP");
            bindFunc(cast(void**)&FMOD_Channel_RemoveDSP, "FMOD_Channel_RemoveDSP");
            bindFunc(cast(void**)&FMOD_Channel_GetNumDSPs, "FMOD_Channel_GetNumDSPs");
            bindFunc(cast(void**)&FMOD_Channel_SetDSPIndex, "FMOD_Channel_SetDSPIndex");
            bindFunc(cast(void**)&FMOD_Channel_GetDSPIndex, "FMOD_Channel_GetDSPIndex");
            bindFunc(cast(void**)&FMOD_Channel_OverridePanDSP, "FMOD_Channel_OverridePanDSP");
            bindFunc(cast(void**)&FMOD_Channel_Set3DAttributes, "FMOD_Channel_Set3DAttributes");
            bindFunc(cast(void**)&FMOD_Channel_Get3DAttributes, "FMOD_Channel_Get3DAttributes");
            bindFunc(cast(void**)&FMOD_Channel_Set3DMinMaxDistance, "FMOD_Channel_Set3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_Channel_Get3DMinMaxDistance, "FMOD_Channel_Get3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_Channel_Set3DConeSettings, "FMOD_Channel_Set3DConeSettings");
            bindFunc(cast(void**)&FMOD_Channel_Get3DConeSettings, "FMOD_Channel_Get3DConeSettings");
            bindFunc(cast(void**)&FMOD_Channel_Set3DConeOrientation, "FMOD_Channel_Set3DConeOrientation");
            bindFunc(cast(void**)&FMOD_Channel_Get3DConeOrientation, "FMOD_Channel_Get3DConeOrientation");
            bindFunc(cast(void**)&FMOD_Channel_Set3DCustomRolloff, "FMOD_Channel_Set3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_Channel_Get3DCustomRolloff, "FMOD_Channel_Get3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_Channel_Set3DOcclusion, "FMOD_Channel_Set3DOcclusion");
            bindFunc(cast(void**)&FMOD_Channel_Get3DOcclusion, "FMOD_Channel_Get3DOcclusion");
            bindFunc(cast(void**)&FMOD_Channel_Set3DSpread, "FMOD_Channel_Set3DSpread");
            bindFunc(cast(void**)&FMOD_Channel_Get3DSpread, "FMOD_Channel_Get3DSpread");
            bindFunc(cast(void**)&FMOD_Channel_Set3DLevel, "FMOD_Channel_Set3DLevel");
            bindFunc(cast(void**)&FMOD_Channel_Get3DLevel, "FMOD_Channel_Get3DLevel");
            bindFunc(cast(void**)&FMOD_Channel_Set3DDopplerLevel, "FMOD_Channel_Set3DDopplerLevel");
            bindFunc(cast(void**)&FMOD_Channel_Get3DDopplerLevel, "FMOD_Channel_Get3DDopplerLevel");
            bindFunc(cast(void**)&FMOD_Channel_Set3DDistanceFilter, "FMOD_Channel_Set3DDistanceFilter");
            bindFunc(cast(void**)&FMOD_Channel_Get3DDistanceFilter, "FMOD_Channel_Get3DDistanceFilter");
            bindFunc(cast(void**)&FMOD_Channel_SetUserData, "FMOD_Channel_SetUserData");
            bindFunc(cast(void**)&FMOD_Channel_GetUserData, "FMOD_Channel_GetUserData");
            bindFunc(cast(void**)&FMOD_Channel_SetFrequency, "FMOD_Channel_SetFrequency");
            bindFunc(cast(void**)&FMOD_Channel_GetFrequency, "FMOD_Channel_GetFrequency");
            bindFunc(cast(void**)&FMOD_Channel_SetPriority, "FMOD_Channel_SetPriority");
            bindFunc(cast(void**)&FMOD_Channel_GetPriority, "FMOD_Channel_GetPriority");
            bindFunc(cast(void**)&FMOD_Channel_SetPosition, "FMOD_Channel_SetPosition");
            bindFunc(cast(void**)&FMOD_Channel_GetPosition, "FMOD_Channel_GetPosition");
            bindFunc(cast(void**)&FMOD_Channel_SetChannelGroup, "FMOD_Channel_SetChannelGroup");
            bindFunc(cast(void**)&FMOD_Channel_GetChannelGroup, "FMOD_Channel_GetChannelGroup");
            bindFunc(cast(void**)&FMOD_Channel_SetLoopCount, "FMOD_Channel_SetLoopCount");
            bindFunc(cast(void**)&FMOD_Channel_GetLoopCount, "FMOD_Channel_GetLoopCount");
            bindFunc(cast(void**)&FMOD_Channel_SetLoopPoints, "FMOD_Channel_SetLoopPoints");
            bindFunc(cast(void**)&FMOD_Channel_GetLoopPoints, "FMOD_Channel_GetLoopPoints");
            bindFunc(cast(void**)&FMOD_Channel_IsVirtual, "FMOD_Channel_IsVirtual");
            bindFunc(cast(void**)&FMOD_Channel_GetCurrentSound, "FMOD_Channel_GetCurrentSound");
            bindFunc(cast(void**)&FMOD_Channel_GetIndex, "FMOD_Channel_GetIndex");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetSystemObject, "FMOD_ChannelGroup_GetSystemObject");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Stop, "FMOD_ChannelGroup_Stop");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetPaused, "FMOD_ChannelGroup_SetPaused");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetPaused, "FMOD_ChannelGroup_GetPaused");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetVolume, "FMOD_ChannelGroup_SetVolume");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetVolume, "FMOD_ChannelGroup_GetVolume");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetVolumeRamp, "FMOD_ChannelGroup_SetVolumeRamp");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetVolumeRamp, "FMOD_ChannelGroup_GetVolumeRamp");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetAudibility, "FMOD_ChannelGroup_GetAudibility");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetPitch, "FMOD_ChannelGroup_SetPitch");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetPitch, "FMOD_ChannelGroup_GetPitch");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetMute, "FMOD_ChannelGroup_SetMute");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetMute, "FMOD_ChannelGroup_GetMute");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetReverbProperties, "FMOD_ChannelGroup_SetReverbProperties");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetReverbProperties, "FMOD_ChannelGroup_GetReverbProperties");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetLowPassGain, "FMOD_ChannelGroup_SetLowPassGain");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetLowPassGain, "FMOD_ChannelGroup_GetLowPassGain");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetMode, "FMOD_ChannelGroup_SetMode");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetMode, "FMOD_ChannelGroup_GetMode");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetCallback, "FMOD_ChannelGroup_SetCallback");
            bindFunc(cast(void**)&FMOD_ChannelGroup_IsPlaying, "FMOD_ChannelGroup_IsPlaying");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetPan, "FMOD_ChannelGroup_SetPan");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetMixLevelsOutput, "FMOD_ChannelGroup_SetMixLevelsOutput");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetMixLevelsInput, "FMOD_ChannelGroup_SetMixLevelsInput");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetMixMatrix, "FMOD_ChannelGroup_SetMixMatrix");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetMixMatrix, "FMOD_ChannelGroup_GetMixMatrix");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetDSPClock, "FMOD_ChannelGroup_GetDSPClock");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetDelay, "FMOD_ChannelGroup_SetDelay");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetDelay, "FMOD_ChannelGroup_GetDelay");
            bindFunc(cast(void**)&FMOD_ChannelGroup_AddFadePoint, "FMOD_ChannelGroup_AddFadePoint");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetFadePointRamp, "FMOD_ChannelGroup_SetFadePointRamp");
            bindFunc(cast(void**)&FMOD_ChannelGroup_RemoveFadePoints, "FMOD_ChannelGroup_RemoveFadePoints");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetFadePoints, "FMOD_ChannelGroup_GetFadePoints");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetDSP, "FMOD_ChannelGroup_GetDSP");
            bindFunc(cast(void**)&FMOD_ChannelGroup_AddDSP, "FMOD_ChannelGroup_AddDSP");
            bindFunc(cast(void**)&FMOD_ChannelGroup_RemoveDSP, "FMOD_ChannelGroup_RemoveDSP");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetNumDSPs, "FMOD_ChannelGroup_GetNumDSPs");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetDSPIndex, "FMOD_ChannelGroup_SetDSPIndex");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetDSPIndex, "FMOD_ChannelGroup_GetDSPIndex");
            bindFunc(cast(void**)&FMOD_ChannelGroup_OverridePanDSP, "FMOD_ChannelGroup_OverridePanDSP");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DAttributes, "FMOD_ChannelGroup_Set3DAttributes");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DAttributes, "FMOD_ChannelGroup_Get3DAttributes");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DMinMaxDistance, "FMOD_ChannelGroup_Set3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DMinMaxDistance, "FMOD_ChannelGroup_Get3DMinMaxDistance");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DConeSettings, "FMOD_ChannelGroup_Set3DConeSettings");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DConeSettings, "FMOD_ChannelGroup_Get3DConeSettings");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DConeOrientation, "FMOD_ChannelGroup_Set3DConeOrientation");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DConeOrientation, "FMOD_ChannelGroup_Get3DConeOrientation");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DCustomRolloff, "FMOD_ChannelGroup_Set3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DCustomRolloff, "FMOD_ChannelGroup_Get3DCustomRolloff");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DOcclusion, "FMOD_ChannelGroup_Set3DOcclusion");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DOcclusion, "FMOD_ChannelGroup_Get3DOcclusion");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DSpread, "FMOD_ChannelGroup_Set3DSpread");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DSpread, "FMOD_ChannelGroup_Get3DSpread");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DLevel, "FMOD_ChannelGroup_Set3DLevel");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DLevel, "FMOD_ChannelGroup_Get3DLevel");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DDopplerLevel, "FMOD_ChannelGroup_Set3DDopplerLevel");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DDopplerLevel, "FMOD_ChannelGroup_Get3DDopplerLevel");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DDistanceFilter, "FMOD_ChannelGroup_Set3DDistanceFilter");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DDistanceFilter, "FMOD_ChannelGroup_Get3DDistanceFilter");
            bindFunc(cast(void**)&FMOD_ChannelGroup_SetUserData, "FMOD_ChannelGroup_SetUserData");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetUserData, "FMOD_ChannelGroup_GetUserData");
            bindFunc(cast(void**)&FMOD_ChannelGroup_Release, "FMOD_ChannelGroup_Release");
            bindFunc(cast(void**)&FMOD_ChannelGroup_AddGroup, "FMOD_ChannelGroup_AddGroup");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetNumGroups, "FMOD_ChannelGroup_GetNumGroups");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetGroup, "FMOD_ChannelGroup_GetGroup");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetParentGroup, "FMOD_ChannelGroup_GetParentGroup");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetName, "FMOD_ChannelGroup_GetName");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetNumChannels, "FMOD_ChannelGroup_GetNumChannels");
            bindFunc(cast(void**)&FMOD_ChannelGroup_GetChannel, "FMOD_ChannelGroup_GetChannel");
            bindFunc(cast(void**)&FMOD_SoundGroup_Release, "FMOD_SoundGroup_Release");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetSystemObject, "FMOD_SoundGroup_GetSystemObject");
            bindFunc(cast(void**)&FMOD_SoundGroup_SetMaxAudible, "FMOD_SoundGroup_SetMaxAudible");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetMaxAudible, "FMOD_SoundGroup_GetMaxAudible");
            bindFunc(cast(void**)&FMOD_SoundGroup_SetMaxAudibleBehavior, "FMOD_SoundGroup_SetMaxAudibleBehavior");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetMaxAudibleBehavior, "FMOD_SoundGroup_GetMaxAudibleBehavior");
            bindFunc(cast(void**)&FMOD_SoundGroup_SetMuteFadeSpeed, "FMOD_SoundGroup_SetMuteFadeSpeed");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetMuteFadeSpeed, "FMOD_SoundGroup_GetMuteFadeSpeed");
            bindFunc(cast(void**)&FMOD_SoundGroup_SetVolume, "FMOD_SoundGroup_SetVolume");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetVolume, "FMOD_SoundGroup_GetVolume");
            bindFunc(cast(void**)&FMOD_SoundGroup_Stop, "FMOD_SoundGroup_Stop");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetName, "FMOD_SoundGroup_GetName");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetNumSounds, "FMOD_SoundGroup_GetNumSounds");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetSound, "FMOD_SoundGroup_GetSound");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetNumPlaying, "FMOD_SoundGroup_GetNumPlaying");
            bindFunc(cast(void**)&FMOD_SoundGroup_SetUserData, "FMOD_SoundGroup_SetUserData");
            bindFunc(cast(void**)&FMOD_SoundGroup_GetUserData, "FMOD_SoundGroup_GetUserData");
            bindFunc(cast(void**)&FMOD_DSP_Release, "FMOD_DSP_Release");
            bindFunc(cast(void**)&FMOD_DSP_GetSystemObject, "FMOD_DSP_GetSystemObject");
            bindFunc(cast(void**)&FMOD_DSP_AddInput, "FMOD_DSP_AddInput");
            bindFunc(cast(void**)&FMOD_DSP_DisconnectFrom, "FMOD_DSP_DisconnectFrom");
            bindFunc(cast(void**)&FMOD_DSP_DisconnectAll, "FMOD_DSP_DisconnectAll");
            bindFunc(cast(void**)&FMOD_DSP_GetNumInputs, "FMOD_DSP_GetNumInputs");
            bindFunc(cast(void**)&FMOD_DSP_GetNumOutputs, "FMOD_DSP_GetNumOutputs");
            bindFunc(cast(void**)&FMOD_DSP_GetInput, "FMOD_DSP_GetInput");
            bindFunc(cast(void**)&FMOD_DSP_GetOutput, "FMOD_DSP_GetOutput");
            bindFunc(cast(void**)&FMOD_DSP_SetActive, "FMOD_DSP_SetActive");
            bindFunc(cast(void**)&FMOD_DSP_GetActive, "FMOD_DSP_GetActive");
            bindFunc(cast(void**)&FMOD_DSP_SetBypass, "FMOD_DSP_SetBypass");
            bindFunc(cast(void**)&FMOD_DSP_GetBypass, "FMOD_DSP_GetBypass");
            bindFunc(cast(void**)&FMOD_DSP_SetWetDryMix, "FMOD_DSP_SetWetDryMix");
            bindFunc(cast(void**)&FMOD_DSP_GetWetDryMix, "FMOD_DSP_GetWetDryMix");
            bindFunc(cast(void**)&FMOD_DSP_SetChannelFormat, "FMOD_DSP_SetChannelFormat");
            bindFunc(cast(void**)&FMOD_DSP_GetChannelFormat, "FMOD_DSP_GetChannelFormat");
            bindFunc(cast(void**)&FMOD_DSP_GetOutputChannelFormat, "FMOD_DSP_GetOutputChannelFormat");
            bindFunc(cast(void**)&FMOD_DSP_Reset, "FMOD_DSP_Reset");
            bindFunc(cast(void**)&FMOD_DSP_SetParameterFloat, "FMOD_DSP_SetParameterFloat");
            bindFunc(cast(void**)&FMOD_DSP_SetParameterInt, "FMOD_DSP_SetParameterInt");
            bindFunc(cast(void**)&FMOD_DSP_SetParameterBool, "FMOD_DSP_SetParameterBool");
            bindFunc(cast(void**)&FMOD_DSP_SetParameterData, "FMOD_DSP_SetParameterData");
            bindFunc(cast(void**)&FMOD_DSP_GetParameterFloat, "FMOD_DSP_GetParameterFloat");
            bindFunc(cast(void**)&FMOD_DSP_GetParameterInt, "FMOD_DSP_GetParameterInt");
            bindFunc(cast(void**)&FMOD_DSP_GetParameterBool, "FMOD_DSP_GetParameterBool");
            bindFunc(cast(void**)&FMOD_DSP_GetParameterData, "FMOD_DSP_GetParameterData");
            bindFunc(cast(void**)&FMOD_DSP_GetNumParameters, "FMOD_DSP_GetNumParameters");
            bindFunc(cast(void**)&FMOD_DSP_GetParameterInfo, "FMOD_DSP_GetParameterInfo");
            bindFunc(cast(void**)&FMOD_DSP_GetDataParameterIndex, "FMOD_DSP_GetDataParameterIndex");
            bindFunc(cast(void**)&FMOD_DSP_ShowConfigDialog, "FMOD_DSP_ShowConfigDialog");
            bindFunc(cast(void**)&FMOD_DSP_GetInfo, "FMOD_DSP_GetInfo");
            bindFunc(cast(void**)&FMOD_DSP_GetType, "FMOD_DSP_GetType");
            bindFunc(cast(void**)&FMOD_DSP_GetIdle, "FMOD_DSP_GetIdle");
            bindFunc(cast(void**)&FMOD_DSP_SetUserData, "FMOD_DSP_SetUserData");
            bindFunc(cast(void**)&FMOD_DSP_GetUserData, "FMOD_DSP_GetUserData");
            bindFunc(cast(void**)&FMOD_DSP_SetMeteringEnabled, "FMOD_DSP_SetMeteringEnabled");
            bindFunc(cast(void**)&FMOD_DSP_GetMeteringEnabled, "FMOD_DSP_GetMeteringEnabled");
            bindFunc(cast(void**)&FMOD_DSP_GetMeteringInfo, "FMOD_DSP_GetMeteringInfo");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetInput, "FMOD_DSPConnection_GetInput");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetOutput, "FMOD_DSPConnection_GetOutput");
            bindFunc(cast(void**)&FMOD_DSPConnection_SetMix, "FMOD_DSPConnection_SetMix");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetMix, "FMOD_DSPConnection_GetMix");
            bindFunc(cast(void**)&FMOD_DSPConnection_SetMixMatrix, "FMOD_DSPConnection_SetMixMatrix");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetMixMatrix, "FMOD_DSPConnection_GetMixMatrix");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetType, "FMOD_DSPConnection_GetType");
            bindFunc(cast(void**)&FMOD_DSPConnection_SetUserData, "FMOD_DSPConnection_SetUserData");
            bindFunc(cast(void**)&FMOD_DSPConnection_GetUserData, "FMOD_DSPConnection_GetUserData");
            bindFunc(cast(void**)&FMOD_Geometry_Release, "FMOD_Geometry_Release");
            bindFunc(cast(void**)&FMOD_Geometry_AddPolygon, "FMOD_Geometry_AddPolygon");
            bindFunc(cast(void**)&FMOD_Geometry_GetNumPolygons, "FMOD_Geometry_GetNumPolygons");
            bindFunc(cast(void**)&FMOD_Geometry_GetMaxPolygons, "FMOD_Geometry_GetMaxPolygons");
            bindFunc(cast(void**)&FMOD_Geometry_GetPolygonNumVertices, "FMOD_Geometry_GetPolygonNumVertices");
            bindFunc(cast(void**)&FMOD_Geometry_SetPolygonVertex, "FMOD_Geometry_SetPolygonVertex");
            bindFunc(cast(void**)&FMOD_Geometry_GetPolygonVertex, "FMOD_Geometry_GetPolygonVertex");
            bindFunc(cast(void**)&FMOD_Geometry_SetPolygonAttributes, "FMOD_Geometry_SetPolygonAttributes");
            bindFunc(cast(void**)&FMOD_Geometry_GetPolygonAttributes, "FMOD_Geometry_GetPolygonAttributes");
            bindFunc(cast(void**)&FMOD_Geometry_SetActive, "FMOD_Geometry_SetActive");
            bindFunc(cast(void**)&FMOD_Geometry_GetActive, "FMOD_Geometry_GetActive");
            bindFunc(cast(void**)&FMOD_Geometry_SetRotation, "FMOD_Geometry_SetRotation");
            bindFunc(cast(void**)&FMOD_Geometry_GetRotation, "FMOD_Geometry_GetRotation");
            bindFunc(cast(void**)&FMOD_Geometry_SetPosition, "FMOD_Geometry_SetPosition");
            bindFunc(cast(void**)&FMOD_Geometry_GetPosition, "FMOD_Geometry_GetPosition");
            bindFunc(cast(void**)&FMOD_Geometry_SetScale, "FMOD_Geometry_SetScale");
            bindFunc(cast(void**)&FMOD_Geometry_GetScale, "FMOD_Geometry_GetScale");
            bindFunc(cast(void**)&FMOD_Geometry_Save, "FMOD_Geometry_Save");
            bindFunc(cast(void**)&FMOD_Geometry_SetUserData, "FMOD_Geometry_SetUserData");
            bindFunc(cast(void**)&FMOD_Geometry_GetUserData, "FMOD_Geometry_GetUserData");
            bindFunc(cast(void**)&FMOD_Reverb3D_Release, "FMOD_Reverb3D_Release");
            bindFunc(cast(void**)&FMOD_Reverb3D_Set3DAttributes, "FMOD_Reverb3D_Set3DAttributes");
            bindFunc(cast(void**)&FMOD_Reverb3D_Get3DAttributes, "FMOD_Reverb3D_Get3DAttributes");
            bindFunc(cast(void**)&FMOD_Reverb3D_SetProperties, "FMOD_Reverb3D_SetProperties");
            bindFunc(cast(void**)&FMOD_Reverb3D_GetProperties, "FMOD_Reverb3D_GetProperties");
            bindFunc(cast(void**)&FMOD_Reverb3D_SetActive, "FMOD_Reverb3D_SetActive");
            bindFunc(cast(void**)&FMOD_Reverb3D_GetActive, "FMOD_Reverb3D_GetActive");
            bindFunc(cast(void**)&FMOD_Reverb3D_SetUserData, "FMOD_Reverb3D_SetUserData");
            bindFunc(cast(void**)&FMOD_Reverb3D_GetUserData, "FMOD_Reverb3D_GetUserData");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictFmodLoader DerelictFmod;

shared static this()
{
    DerelictFmod = new DerelictFmodLoader();
}
