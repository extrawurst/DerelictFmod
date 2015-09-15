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
module derelict.fmodstudio.fmodstudio;

public
{
    import derelict.fmodstudio.common;
    import derelict.fmodstudio.funcs;
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
        enum libNames = "fmodstudio.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "libfmodstudio.dylib";
    else static if (Derelict_OS_Linux)
        enum libNames = "libfmodstudio.so";
    else
        static assert(0, "Need to implement FMOD libNames for this operating system.");
}

class DerelictFmodStudioLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
            bindFunc(cast(void**)&FMOD_Studio_ParseID, "FMOD_Studio_ParseID");
            bindFunc(cast(void**)&FMOD_Studio_System_Create, "FMOD_Studio_System_Create");

            /*$ preserve end $*/

            /*
            System
            */
            bindFunc(cast(void**)&FMOD_Studio_System_IsValid, "FMOD_Studio_System_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_System_SetAdvancedSettings, "FMOD_Studio_System_SetAdvancedSettings");
            bindFunc(cast(void**)&FMOD_Studio_System_GetAdvancedSettings, "FMOD_Studio_System_GetAdvancedSettings");
            bindFunc(cast(void**)&FMOD_Studio_System_Initialize, "FMOD_Studio_System_Initialize");
            bindFunc(cast(void**)&FMOD_Studio_System_Release, "FMOD_Studio_System_Release");
            bindFunc(cast(void**)&FMOD_Studio_System_Update, "FMOD_Studio_System_Update");
            bindFunc(cast(void**)&FMOD_Studio_System_GetLowLevelSystem, "FMOD_Studio_System_GetLowLevelSystem");
            bindFunc(cast(void**)&FMOD_Studio_System_GetEvent, "FMOD_Studio_System_GetEvent");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBus, "FMOD_Studio_System_GetBus");
            bindFunc(cast(void**)&FMOD_Studio_System_GetVCA, "FMOD_Studio_System_GetVCA");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBank, "FMOD_Studio_System_GetBank");
            bindFunc(cast(void**)&FMOD_Studio_System_GetEventByID, "FMOD_Studio_System_GetEventByID");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBusByID, "FMOD_Studio_System_GetBusByID");
            bindFunc(cast(void**)&FMOD_Studio_System_GetVCAByID, "FMOD_Studio_System_GetVCAByID");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBankByID, "FMOD_Studio_System_GetBankByID");
            bindFunc(cast(void**)&FMOD_Studio_System_GetSoundInfo, "FMOD_Studio_System_GetSoundInfo");
            bindFunc(cast(void**)&FMOD_Studio_System_LookupID, "FMOD_Studio_System_LookupID");
            bindFunc(cast(void**)&FMOD_Studio_System_LookupPath, "FMOD_Studio_System_LookupPath");
            bindFunc(cast(void**)&FMOD_Studio_System_GetNumListeners, "FMOD_Studio_System_GetNumListeners");
            bindFunc(cast(void**)&FMOD_Studio_System_SetNumListeners, "FMOD_Studio_System_SetNumListeners");
            bindFunc(cast(void**)&FMOD_Studio_System_GetListenerAttributes, "FMOD_Studio_System_GetListenerAttributes");
            bindFunc(cast(void**)&FMOD_Studio_System_SetListenerAttributes, "FMOD_Studio_System_SetListenerAttributes");
            bindFunc(cast(void**)&FMOD_Studio_System_LoadBankFile, "FMOD_Studio_System_LoadBankFile");
            bindFunc(cast(void**)&FMOD_Studio_System_LoadBankMemory, "FMOD_Studio_System_LoadBankMemory");
            bindFunc(cast(void**)&FMOD_Studio_System_LoadBankCustom, "FMOD_Studio_System_LoadBankCustom");
            bindFunc(cast(void**)&FMOD_Studio_System_RegisterPlugin, "FMOD_Studio_System_RegisterPlugin");
            bindFunc(cast(void**)&FMOD_Studio_System_UnregisterPlugin, "FMOD_Studio_System_UnregisterPlugin");
            bindFunc(cast(void**)&FMOD_Studio_System_UnloadAll, "FMOD_Studio_System_UnloadAll");
            bindFunc(cast(void**)&FMOD_Studio_System_FlushCommands, "FMOD_Studio_System_FlushCommands");
            bindFunc(cast(void**)&FMOD_Studio_System_StartCommandCapture, "FMOD_Studio_System_StartCommandCapture");
            bindFunc(cast(void**)&FMOD_Studio_System_StopCommandCapture, "FMOD_Studio_System_StopCommandCapture");
            bindFunc(cast(void**)&FMOD_Studio_System_LoadCommandReplay, "FMOD_Studio_System_LoadCommandReplay");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBankCount, "FMOD_Studio_System_GetBankCount");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBankList, "FMOD_Studio_System_GetBankList");
            bindFunc(cast(void**)&FMOD_Studio_System_GetCPUUsage, "FMOD_Studio_System_GetCPUUsage");
            bindFunc(cast(void**)&FMOD_Studio_System_GetBufferUsage, "FMOD_Studio_System_GetBufferUsage");
            bindFunc(cast(void**)&FMOD_Studio_System_ResetBufferUsage, "FMOD_Studio_System_ResetBufferUsage");
            bindFunc(cast(void**)&FMOD_Studio_System_SetCallback, "FMOD_Studio_System_SetCallback");
            bindFunc(cast(void**)&FMOD_Studio_System_SetUserData, "FMOD_Studio_System_SetUserData");
            bindFunc(cast(void**)&FMOD_Studio_System_GetUserData, "FMOD_Studio_System_GetUserData");

            /*
            EventDescription
            */
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_IsValid, "FMOD_Studio_EventDescription_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetID, "FMOD_Studio_EventDescription_GetID");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetPath, "FMOD_Studio_EventDescription_GetPath");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetParameterCount, "FMOD_Studio_EventDescription_GetParameterCount");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetParameterByIndex, "FMOD_Studio_EventDescription_GetParameterByIndex");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetParameter, "FMOD_Studio_EventDescription_GetParameter");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetUserPropertyCount, "FMOD_Studio_EventDescription_GetUserPropertyCount");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetUserPropertyByIndex, "FMOD_Studio_EventDescription_GetUserPropertyByIndex");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetUserProperty, "FMOD_Studio_EventDescription_GetUserProperty");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetLength, "FMOD_Studio_EventDescription_GetLength");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetMinimumDistance, "FMOD_Studio_EventDescription_GetMinimumDistance");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetMaximumDistance, "FMOD_Studio_EventDescription_GetMaximumDistance");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_IsOneshot, "FMOD_Studio_EventDescription_IsOneshot");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_IsStream, "FMOD_Studio_EventDescription_IsStream");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_Is3D, "FMOD_Studio_EventDescription_Is3D");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_CreateInstance, "FMOD_Studio_EventDescription_CreateInstance");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetInstanceCount, "FMOD_Studio_EventDescription_GetInstanceCount");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetInstanceList, "FMOD_Studio_EventDescription_GetInstanceList");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_LoadSampleData, "FMOD_Studio_EventDescription_LoadSampleData");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_UnloadSampleData, "FMOD_Studio_EventDescription_UnloadSampleData");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetSampleLoadingState, "FMOD_Studio_EventDescription_GetSampleLoadingState");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_ReleaseAllInstances, "FMOD_Studio_EventDescription_ReleaseAllInstances");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_SetCallback, "FMOD_Studio_EventDescription_SetCallback");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_GetUserData, "FMOD_Studio_EventDescription_GetUserData");
            bindFunc(cast(void**)&FMOD_Studio_EventDescription_SetUserData, "FMOD_Studio_EventDescription_SetUserData");

            /*
            EventInstance
            */
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_IsValid, "FMOD_Studio_EventInstance_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetDescription, "FMOD_Studio_EventInstance_GetDescription");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetVolume, "FMOD_Studio_EventInstance_GetVolume");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetVolume, "FMOD_Studio_EventInstance_SetVolume");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetPitch, "FMOD_Studio_EventInstance_GetPitch");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetPitch, "FMOD_Studio_EventInstance_SetPitch");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_Get3DAttributes, "FMOD_Studio_EventInstance_Get3DAttributes");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_Set3DAttributes, "FMOD_Studio_EventInstance_Set3DAttributes");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetProperty, "FMOD_Studio_EventInstance_GetProperty");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetProperty, "FMOD_Studio_EventInstance_SetProperty");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetPaused, "FMOD_Studio_EventInstance_GetPaused");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetPaused, "FMOD_Studio_EventInstance_SetPaused");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_Start, "FMOD_Studio_EventInstance_Start");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_Stop, "FMOD_Studio_EventInstance_Stop");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetTimelinePosition, "FMOD_Studio_EventInstance_GetTimelinePosition");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetTimelinePosition, "FMOD_Studio_EventInstance_SetTimelinePosition");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetPlaybackState, "FMOD_Studio_EventInstance_GetPlaybackState");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetChannelGroup, "FMOD_Studio_EventInstance_GetChannelGroup");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_Release, "FMOD_Studio_EventInstance_Release");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_IsVirtual, "FMOD_Studio_EventInstance_IsVirtual");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetParameter, "FMOD_Studio_EventInstance_GetParameter");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetParameterByIndex, "FMOD_Studio_EventInstance_GetParameterByIndex");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetParameterCount, "FMOD_Studio_EventInstance_GetParameterCount");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetParameterValue, "FMOD_Studio_EventInstance_SetParameterValue");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetParameterValueByIndex, "FMOD_Studio_EventInstance_SetParameterValueByIndex");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetCue, "FMOD_Studio_EventInstance_GetCue");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetCueByIndex, "FMOD_Studio_EventInstance_GetCueByIndex");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetCueCount, "FMOD_Studio_EventInstance_GetCueCount");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetCallback, "FMOD_Studio_EventInstance_SetCallback");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_GetUserData, "FMOD_Studio_EventInstance_GetUserData");
            bindFunc(cast(void**)&FMOD_Studio_EventInstance_SetUserData, "FMOD_Studio_EventInstance_SetUserData");

            /*
            CueInstance
            */
            bindFunc(cast(void**)&FMOD_Studio_CueInstance_IsValid, "FMOD_Studio_CueInstance_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_CueInstance_Trigger, "FMOD_Studio_CueInstance_Trigger");

            /*
            ParameterInstance
            */
            bindFunc(cast(void**)&FMOD_Studio_ParameterInstance_IsValid, "FMOD_Studio_ParameterInstance_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_ParameterInstance_GetDescription, "FMOD_Studio_ParameterInstance_GetDescription");
            bindFunc(cast(void**)&FMOD_Studio_ParameterInstance_GetValue, "FMOD_Studio_ParameterInstance_GetValue");
            bindFunc(cast(void**)&FMOD_Studio_ParameterInstance_SetValue, "FMOD_Studio_ParameterInstance_SetValue");

            /*
            Bus
            */
            bindFunc(cast(void**)&FMOD_Studio_Bus_IsValid, "FMOD_Studio_Bus_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetID, "FMOD_Studio_Bus_GetID");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetPath, "FMOD_Studio_Bus_GetPath");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetFaderLevel, "FMOD_Studio_Bus_GetFaderLevel");
            bindFunc(cast(void**)&FMOD_Studio_Bus_SetFaderLevel, "FMOD_Studio_Bus_SetFaderLevel");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetPaused, "FMOD_Studio_Bus_GetPaused");
            bindFunc(cast(void**)&FMOD_Studio_Bus_SetPaused, "FMOD_Studio_Bus_SetPaused");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetMute, "FMOD_Studio_Bus_GetMute");
            bindFunc(cast(void**)&FMOD_Studio_Bus_SetMute, "FMOD_Studio_Bus_SetMute");
            bindFunc(cast(void**)&FMOD_Studio_Bus_StopAllEvents, "FMOD_Studio_Bus_StopAllEvents");
            bindFunc(cast(void**)&FMOD_Studio_Bus_LockChannelGroup, "FMOD_Studio_Bus_LockChannelGroup");
            bindFunc(cast(void**)&FMOD_Studio_Bus_UnlockChannelGroup, "FMOD_Studio_Bus_UnlockChannelGroup");
            bindFunc(cast(void**)&FMOD_Studio_Bus_GetChannelGroup, "FMOD_Studio_Bus_GetChannelGroup");

            /*
            VCA
            */
            bindFunc(cast(void**)&FMOD_Studio_VCA_IsValid, "FMOD_Studio_VCA_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_VCA_GetID, "FMOD_Studio_VCA_GetID");
            bindFunc(cast(void**)&FMOD_Studio_VCA_GetPath, "FMOD_Studio_VCA_GetPath");
            bindFunc(cast(void**)&FMOD_Studio_VCA_GetFaderLevel, "FMOD_Studio_VCA_GetFaderLevel");
            bindFunc(cast(void**)&FMOD_Studio_VCA_SetFaderLevel, "FMOD_Studio_VCA_SetFaderLevel");

            /*
            Bank
            */
            bindFunc(cast(void**)&FMOD_Studio_Bank_IsValid, "FMOD_Studio_Bank_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetID, "FMOD_Studio_Bank_GetID");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetPath, "FMOD_Studio_Bank_GetPath");
            bindFunc(cast(void**)&FMOD_Studio_Bank_Unload, "FMOD_Studio_Bank_Unload");
            bindFunc(cast(void**)&FMOD_Studio_Bank_LoadSampleData, "FMOD_Studio_Bank_LoadSampleData");
            bindFunc(cast(void**)&FMOD_Studio_Bank_UnloadSampleData, "FMOD_Studio_Bank_UnloadSampleData");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetLoadingState, "FMOD_Studio_Bank_GetLoadingState");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetSampleLoadingState, "FMOD_Studio_Bank_GetSampleLoadingState");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetStringCount, "FMOD_Studio_Bank_GetStringCount");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetStringInfo, "FMOD_Studio_Bank_GetStringInfo");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetEventCount, "FMOD_Studio_Bank_GetEventCount");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetEventList, "FMOD_Studio_Bank_GetEventList");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetBusCount, "FMOD_Studio_Bank_GetBusCount");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetBusList, "FMOD_Studio_Bank_GetBusList");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetVCACount, "FMOD_Studio_Bank_GetVCACount");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetVCAList, "FMOD_Studio_Bank_GetVCAList");
            bindFunc(cast(void**)&FMOD_Studio_Bank_GetUserData, "FMOD_Studio_Bank_GetUserData");
            bindFunc(cast(void**)&FMOD_Studio_Bank_SetUserData, "FMOD_Studio_Bank_SetUserData");

            /*
            Command playback information
            */
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_IsValid, "FMOD_Studio_CommandReplay_IsValid");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetSystem, "FMOD_Studio_CommandReplay_GetSystem");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetLength, "FMOD_Studio_CommandReplay_GetLength");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetCommandCount, "FMOD_Studio_CommandReplay_GetCommandCount");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetCommandInfo, "FMOD_Studio_CommandReplay_GetCommandInfo");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetCommandString, "FMOD_Studio_CommandReplay_GetCommandString");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetCommandAtTime, "FMOD_Studio_CommandReplay_GetCommandAtTime");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetBankPath, "FMOD_Studio_CommandReplay_SetBankPath");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_Start, "FMOD_Studio_CommandReplay_Start");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_Stop, "FMOD_Studio_CommandReplay_Stop");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SeekToTime, "FMOD_Studio_CommandReplay_SeekToTime");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SeekToCommand, "FMOD_Studio_CommandReplay_SeekToCommand");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetPaused, "FMOD_Studio_CommandReplay_GetPaused");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetPaused, "FMOD_Studio_CommandReplay_SetPaused");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetPlaybackState, "FMOD_Studio_CommandReplay_GetPlaybackState");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetCurrentCommand, "FMOD_Studio_CommandReplay_GetCurrentCommand");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_Release, "FMOD_Studio_CommandReplay_Release");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetFrameCallback, "FMOD_Studio_CommandReplay_SetFrameCallback");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetLoadBankCallback, "FMOD_Studio_CommandReplay_SetLoadBankCallback");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetCreateInstanceCallback, "FMOD_Studio_CommandReplay_SetCreateInstanceCallback");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_GetUserData, "FMOD_Studio_CommandReplay_GetUserData");
            bindFunc(cast(void**)&FMOD_Studio_CommandReplay_SetUserData, "FMOD_Studio_CommandReplay_SetUserData");
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

__gshared DerelictFmodStudioLoader DerelictFmodStudio;

shared static this()
{
    DerelictFmodStudio = new DerelictFmodStudioLoader();
}
