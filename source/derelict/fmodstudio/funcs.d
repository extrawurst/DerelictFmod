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
module derelict.fmodstudio.funcs;

private
{
    import derelict.util.system;
    import derelict.fmodstudio.common;
    import derelict.fmod.common;
    import derelict.fmod.dsp;
}

extern(C) @nogc nothrow
{
    /*
    Global
*/
    alias da_FMOD_Studio_ParseID = FMOD_RESULT function(const char *idString, FMOD_GUID *id);
    alias da_FMOD_Studio_System_Create = FMOD_RESULT function(FMOD_STUDIO_SYSTEM **system, uint headerVersion);
    
    /*$ preserve end $*/
    
    /*
    System
*/
    alias da_FMOD_Studio_System_IsValid = FMOD_BOOL function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_SetAdvancedSettings = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_ADVANCEDSETTINGS *settings);
    alias da_FMOD_Studio_System_GetAdvancedSettings = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_ADVANCEDSETTINGS *settings);
    alias da_FMOD_Studio_System_Initialize = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int maxchannels, FMOD_STUDIO_INITFLAGS studioflags, FMOD_INITFLAGS flags, void *extradriverdata);
    alias da_FMOD_Studio_System_Release = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_Update = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_GetLowLevelSystem = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_SYSTEM **lowLevelSystem);
    alias da_FMOD_Studio_System_GetEvent = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *pathOrID, FMOD_STUDIO_EVENTDESCRIPTION **event);
    alias da_FMOD_Studio_System_GetBus = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *pathOrID, FMOD_STUDIO_BUS **bus);
    alias da_FMOD_Studio_System_GetVCA = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *pathOrID, FMOD_STUDIO_VCA **vca);
    alias da_FMOD_Studio_System_GetBank = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *pathOrID, FMOD_STUDIO_BANK **bank);
    alias da_FMOD_Studio_System_GetEventByID = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_GUID *id, FMOD_STUDIO_EVENTDESCRIPTION **event);
    alias da_FMOD_Studio_System_GetBusByID = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_GUID *id, FMOD_STUDIO_BUS **bus);
    alias da_FMOD_Studio_System_GetVCAByID = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_GUID *id, FMOD_STUDIO_VCA **vca);
    alias da_FMOD_Studio_System_GetBankByID = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_GUID *id, FMOD_STUDIO_BANK **bank);
    alias da_FMOD_Studio_System_GetSoundInfo = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *key, FMOD_STUDIO_SOUND_INFO *info);
    alias da_FMOD_Studio_System_LookupID = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *path, FMOD_GUID *id);
    alias da_FMOD_Studio_System_LookupPath = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_GUID *id, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_System_GetNumListeners = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int *numlisteners);
    alias da_FMOD_Studio_System_SetNumListeners = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int numlisteners);
    alias da_FMOD_Studio_System_GetListenerAttributes = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int index, FMOD_3D_ATTRIBUTES *attributes);
    alias da_FMOD_Studio_System_SetListenerAttributes = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int index, FMOD_3D_ATTRIBUTES *attributes);
    alias da_FMOD_Studio_System_LoadBankFile = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *filename, FMOD_STUDIO_LOAD_BANK_FLAGS flags, FMOD_STUDIO_BANK **bank);
    alias da_FMOD_Studio_System_LoadBankMemory = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *buffer, int length, FMOD_STUDIO_LOAD_MEMORY_MODE mode, FMOD_STUDIO_LOAD_BANK_FLAGS flags, FMOD_STUDIO_BANK **bank);
    alias da_FMOD_Studio_System_LoadBankCustom = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_STUDIO_BANK_INFO *info, FMOD_STUDIO_LOAD_BANK_FLAGS flags, FMOD_STUDIO_BANK **bank);
    alias da_FMOD_Studio_System_RegisterPlugin = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const FMOD_DSP_DESCRIPTION *description);
    alias da_FMOD_Studio_System_UnregisterPlugin = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *name);
    alias da_FMOD_Studio_System_UnloadAll = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_FlushCommands = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_StartCommandCapture = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *filename, FMOD_STUDIO_COMMANDCAPTURE_FLAGS flags);
    alias da_FMOD_Studio_System_StopCommandCapture = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_LoadCommandReplay = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, const char *filename, FMOD_STUDIO_COMMANDREPLAY_FLAGS flags, FMOD_STUDIO_COMMANDREPLAY **replay);
    alias da_FMOD_Studio_System_GetBankCount = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, int *count);
    alias da_FMOD_Studio_System_GetBankList = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_BANK **array, int capacity, int *count);
    alias da_FMOD_Studio_System_GetCPUUsage = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_CPU_USAGE *usage);
    alias da_FMOD_Studio_System_GetBufferUsage = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_BUFFER_USAGE *usage);
    alias da_FMOD_Studio_System_ResetBufferUsage = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system);
    alias da_FMOD_Studio_System_SetCallback = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, FMOD_STUDIO_SYSTEM_CALLBACK callback, FMOD_STUDIO_SYSTEM_CALLBACK_TYPE callbackmask);
    alias da_FMOD_Studio_System_SetUserData = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, void *userdata);
    alias da_FMOD_Studio_System_GetUserData = FMOD_RESULT function(FMOD_STUDIO_SYSTEM *system, void **userdata);
    
    /*
    EventDescription
*/
    alias da_FMOD_Studio_EventDescription_IsValid = FMOD_BOOL function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription);
    alias da_FMOD_Studio_EventDescription_GetID = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_GUID *id);
    alias da_FMOD_Studio_EventDescription_GetPath = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_EventDescription_GetParameterCount = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int *count);
    alias da_FMOD_Studio_EventDescription_GetParameterByIndex = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int index, FMOD_STUDIO_PARAMETER_DESCRIPTION *parameter);
    alias da_FMOD_Studio_EventDescription_GetParameter = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, const char *name, FMOD_STUDIO_PARAMETER_DESCRIPTION *parameter);
    alias da_FMOD_Studio_EventDescription_GetUserPropertyCount = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int *count);
    alias da_FMOD_Studio_EventDescription_GetUserPropertyByIndex = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int index, FMOD_STUDIO_USER_PROPERTY *property);
    alias da_FMOD_Studio_EventDescription_GetUserProperty = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, const char *name, FMOD_STUDIO_USER_PROPERTY *property);
    alias da_FMOD_Studio_EventDescription_GetLength = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int *length);
    alias da_FMOD_Studio_EventDescription_GetMinimumDistance = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, float *distance);
    alias da_FMOD_Studio_EventDescription_GetMaximumDistance = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, float *distance);
    alias da_FMOD_Studio_EventDescription_GetSoundSize = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, float *size);
    alias da_FMOD_Studio_EventDescription_IsOneshot = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_BOOL *oneshot);
    alias da_FMOD_Studio_EventDescription_IsStream = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_BOOL *isStream);
    alias da_FMOD_Studio_EventDescription_Is3D = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_BOOL *is3D);        
    alias da_FMOD_Studio_EventDescription_CreateInstance = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_STUDIO_EVENTINSTANCE **instance);
    alias da_FMOD_Studio_EventDescription_GetInstanceCount = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, int *count);
    alias da_FMOD_Studio_EventDescription_GetInstanceList = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_STUDIO_EVENTINSTANCE **array, int capacity, int *count);
    alias da_FMOD_Studio_EventDescription_LoadSampleData = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventDesc);
    alias da_FMOD_Studio_EventDescription_UnloadSampleData = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventDesc);
    alias da_FMOD_Studio_EventDescription_GetSampleLoadingState = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventDesc, FMOD_STUDIO_LOADING_STATE *state);
    alias da_FMOD_Studio_EventDescription_ReleaseAllInstances = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription);
    alias da_FMOD_Studio_EventDescription_SetCallback = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, FMOD_STUDIO_EVENT_CALLBACK callback, FMOD_STUDIO_EVENT_CALLBACK_TYPE callbackmask);
    alias da_FMOD_Studio_EventDescription_GetUserData = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, void **userData);
    alias da_FMOD_Studio_EventDescription_SetUserData = FMOD_RESULT function(FMOD_STUDIO_EVENTDESCRIPTION *eventdescription, void *userData);   
    
    /*
    EventInstance
*/
    alias da_FMOD_Studio_EventInstance_IsValid = FMOD_BOOL function(FMOD_STUDIO_EVENTINSTANCE *eventinstance);
    alias da_FMOD_Studio_EventInstance_GetDescription = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_EVENTDESCRIPTION **description);
    alias da_FMOD_Studio_EventInstance_GetVolume = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, float *volume);
    alias da_FMOD_Studio_EventInstance_SetVolume = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, float volume);
    alias da_FMOD_Studio_EventInstance_GetPitch = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, float *pitch);
    alias da_FMOD_Studio_EventInstance_SetPitch = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, float pitch);
    alias da_FMOD_Studio_EventInstance_Get3DAttributes = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_3D_ATTRIBUTES *attributes);
    alias da_FMOD_Studio_EventInstance_Set3DAttributes = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_3D_ATTRIBUTES *attributes);
    alias da_FMOD_Studio_EventInstance_GetProperty = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_EVENT_PROPERTY index, float *value);
    alias da_FMOD_Studio_EventInstance_SetProperty = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_EVENT_PROPERTY index, float value);
    alias da_FMOD_Studio_EventInstance_GetPaused = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_BOOL *paused);
    alias da_FMOD_Studio_EventInstance_SetPaused = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_BOOL paused);
    alias da_FMOD_Studio_EventInstance_Start = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance);
    alias da_FMOD_Studio_EventInstance_Stop = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_STOP_MODE mode);
    alias da_FMOD_Studio_EventInstance_GetTimelinePosition = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int *position);
    alias da_FMOD_Studio_EventInstance_SetTimelinePosition = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int position);
    alias da_FMOD_Studio_EventInstance_GetPlaybackState = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_PLAYBACK_STATE *state);
    alias da_FMOD_Studio_EventInstance_GetChannelGroup = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_CHANNELGROUP **group);
    alias da_FMOD_Studio_EventInstance_Release = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance);
    alias da_FMOD_Studio_EventInstance_IsVirtual = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_BOOL *virtualState);
    alias da_FMOD_Studio_EventInstance_GetParameter = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, const char *name, FMOD_STUDIO_PARAMETERINSTANCE **parameter);
    alias da_FMOD_Studio_EventInstance_GetParameterByIndex = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int index, FMOD_STUDIO_PARAMETERINSTANCE **parameter);
    alias da_FMOD_Studio_EventInstance_GetParameterCount = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int *count);
    alias da_FMOD_Studio_EventInstance_SetParameterValue = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, const char *name, float value);
    alias da_FMOD_Studio_EventInstance_SetParameterValueByIndex = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int index, float value);
    alias da_FMOD_Studio_EventInstance_GetCue = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, const char *name, FMOD_STUDIO_CUEINSTANCE **cue);
    alias da_FMOD_Studio_EventInstance_GetCueByIndex = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int index, FMOD_STUDIO_CUEINSTANCE **cue);
    alias da_FMOD_Studio_EventInstance_GetCueCount = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, int *count);
    alias da_FMOD_Studio_EventInstance_SetCallback = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, FMOD_STUDIO_EVENT_CALLBACK callback, FMOD_STUDIO_EVENT_CALLBACK_TYPE callbackmask);
    alias da_FMOD_Studio_EventInstance_GetUserData = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, void **userData);
    alias da_FMOD_Studio_EventInstance_SetUserData = FMOD_RESULT function(FMOD_STUDIO_EVENTINSTANCE *eventinstance, void *userData);
    
    /*
    CueInstance
*/
    alias da_FMOD_Studio_CueInstance_IsValid = FMOD_BOOL function(FMOD_STUDIO_CUEINSTANCE *cueinstance);
    alias da_FMOD_Studio_CueInstance_Trigger = FMOD_RESULT function(FMOD_STUDIO_CUEINSTANCE *cueinstance);
    
    /*
    ParameterInstance
*/
    alias da_FMOD_Studio_ParameterInstance_IsValid = FMOD_BOOL function(FMOD_STUDIO_PARAMETERINSTANCE *parameterinstance);
    alias da_FMOD_Studio_ParameterInstance_GetDescription = FMOD_RESULT function(FMOD_STUDIO_PARAMETERINSTANCE *parameterinstance, FMOD_STUDIO_PARAMETER_DESCRIPTION *description);
    alias da_FMOD_Studio_ParameterInstance_GetValue = FMOD_RESULT function(FMOD_STUDIO_PARAMETERINSTANCE *parameterinstance, float *value);
    alias da_FMOD_Studio_ParameterInstance_SetValue = FMOD_RESULT function(FMOD_STUDIO_PARAMETERINSTANCE *parameterinstance, float value);
    
    /*
    Bus
*/
    alias da_FMOD_Studio_Bus_IsValid = FMOD_BOOL function(FMOD_STUDIO_BUS *bus);
    alias da_FMOD_Studio_Bus_GetID = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_GUID *id);
    alias da_FMOD_Studio_Bus_GetPath = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_Bus_GetFaderLevel = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, float *level);
    alias da_FMOD_Studio_Bus_SetFaderLevel = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, float level);
    alias da_FMOD_Studio_Bus_GetPaused = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_BOOL *paused);
    alias da_FMOD_Studio_Bus_SetPaused = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_BOOL paused);
    alias da_FMOD_Studio_Bus_GetMute = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_BOOL *mute);
    alias da_FMOD_Studio_Bus_SetMute = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_BOOL mute);
    alias da_FMOD_Studio_Bus_StopAllEvents = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_STUDIO_STOP_MODE mode);
    alias da_FMOD_Studio_Bus_LockChannelGroup = FMOD_RESULT function(FMOD_STUDIO_BUS *bus);
    alias da_FMOD_Studio_Bus_UnlockChannelGroup = FMOD_RESULT function(FMOD_STUDIO_BUS *bus);
    alias da_FMOD_Studio_Bus_GetChannelGroup = FMOD_RESULT function(FMOD_STUDIO_BUS *bus, FMOD_CHANNELGROUP **group);
    
    /*
    VCA
*/
    alias da_FMOD_Studio_VCA_IsValid = FMOD_BOOL function(FMOD_STUDIO_VCA *vca);
    alias da_FMOD_Studio_VCA_GetID = FMOD_RESULT function(FMOD_STUDIO_VCA *vca, FMOD_GUID *id);
    alias da_FMOD_Studio_VCA_GetPath = FMOD_RESULT function(FMOD_STUDIO_VCA *vca, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_VCA_GetFaderLevel = FMOD_RESULT function(FMOD_STUDIO_VCA *vca, float *level);
    alias da_FMOD_Studio_VCA_SetFaderLevel = FMOD_RESULT function(FMOD_STUDIO_VCA *vca, float level);
    
    /*
    Bank
*/
    alias da_FMOD_Studio_Bank_IsValid = FMOD_BOOL function(FMOD_STUDIO_BANK *bank);
    alias da_FMOD_Studio_Bank_GetID = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_GUID *id);
    alias da_FMOD_Studio_Bank_GetPath = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_Bank_Unload = FMOD_RESULT function(FMOD_STUDIO_BANK *bank);
    alias da_FMOD_Studio_Bank_LoadSampleData = FMOD_RESULT function(FMOD_STUDIO_BANK *bank);
    alias da_FMOD_Studio_Bank_UnloadSampleData = FMOD_RESULT function(FMOD_STUDIO_BANK *bank);
    alias da_FMOD_Studio_Bank_GetLoadingState = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_STUDIO_LOADING_STATE *state);
    alias da_FMOD_Studio_Bank_GetSampleLoadingState = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_STUDIO_LOADING_STATE *state);
    alias da_FMOD_Studio_Bank_GetStringCount = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, int *count);
    alias da_FMOD_Studio_Bank_GetStringInfo = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, int index, FMOD_GUID *id, char *path, int size, int *retrieved);
    alias da_FMOD_Studio_Bank_GetEventCount = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, int *count);
    alias da_FMOD_Studio_Bank_GetEventList = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_STUDIO_EVENTDESCRIPTION **array, int capacity, int *count);
    alias da_FMOD_Studio_Bank_GetBusCount = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, int *count);
    alias da_FMOD_Studio_Bank_GetBusList = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_STUDIO_BUS **array, int capacity, int *count);
    alias da_FMOD_Studio_Bank_GetVCACount = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, int *count);
    alias da_FMOD_Studio_Bank_GetVCAList = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, FMOD_STUDIO_VCA **array, int capacity, int *count);
    alias da_FMOD_Studio_Bank_GetUserData = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, void **userData);
    alias da_FMOD_Studio_Bank_SetUserData = FMOD_RESULT function(FMOD_STUDIO_BANK *bank, void *userData);
    
    /*
    Command playback information
*/
    alias da_FMOD_Studio_CommandReplay_IsValid = FMOD_BOOL function(FMOD_STUDIO_COMMANDREPLAY *replay);
    alias da_FMOD_Studio_CommandReplay_GetSystem = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_STUDIO_SYSTEM **system);
    alias da_FMOD_Studio_CommandReplay_GetLength = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, float *length);
    alias da_FMOD_Studio_CommandReplay_GetCommandCount = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int *count);
    alias da_FMOD_Studio_CommandReplay_GetCommandInfo = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex, FMOD_STUDIO_COMMAND_INFO *info);
    alias da_FMOD_Studio_CommandReplay_GetCommandString = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex, char *description, int capacity);
    alias da_FMOD_Studio_CommandReplay_GetCommandAtTime = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, float time, int *commandIndex);
    alias da_FMOD_Studio_CommandReplay_SetBankPath = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, const char *bankPath);
    alias da_FMOD_Studio_CommandReplay_Start = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay);
    alias da_FMOD_Studio_CommandReplay_Stop = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay);
    alias da_FMOD_Studio_CommandReplay_SeekToTime = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, float time);
    alias da_FMOD_Studio_CommandReplay_SeekToCommand = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int commandIndex);
    alias da_FMOD_Studio_CommandReplay_GetPaused = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_BOOL *paused);
    alias da_FMOD_Studio_CommandReplay_SetPaused = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_BOOL paused);
    alias da_FMOD_Studio_CommandReplay_GetPlaybackState = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_STUDIO_PLAYBACK_STATE *state);
    alias da_FMOD_Studio_CommandReplay_GetCurrentCommand = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, int *commandIndex, float *currentTime);
    alias da_FMOD_Studio_CommandReplay_Release = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay);
    alias da_FMOD_Studio_CommandReplay_SetFrameCallback = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK callback);
    alias da_FMOD_Studio_CommandReplay_SetLoadBankCallback = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK callback);
    alias da_FMOD_Studio_CommandReplay_SetCreateInstanceCallback = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK callback);
    alias da_FMOD_Studio_CommandReplay_GetUserData = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, void **userdata);
    alias da_FMOD_Studio_CommandReplay_SetUserData = FMOD_RESULT function(FMOD_STUDIO_COMMANDREPLAY *replay, void *userdata);
}

__gshared
{
    da_FMOD_Studio_ParseID FMOD_Studio_ParseID;
    da_FMOD_Studio_System_Create FMOD_Studio_System_Create;
    
    /*$ preserve end $*/
    
    /*
    System
*/
    da_FMOD_Studio_System_IsValid FMOD_Studio_System_IsValid;
    da_FMOD_Studio_System_SetAdvancedSettings FMOD_Studio_System_SetAdvancedSettings;
    da_FMOD_Studio_System_GetAdvancedSettings FMOD_Studio_System_GetAdvancedSettings;
    da_FMOD_Studio_System_Initialize FMOD_Studio_System_Initialize;
    da_FMOD_Studio_System_Release FMOD_Studio_System_Release;
    da_FMOD_Studio_System_Update FMOD_Studio_System_Update;
    da_FMOD_Studio_System_GetLowLevelSystem FMOD_Studio_System_GetLowLevelSystem;
    da_FMOD_Studio_System_GetEvent FMOD_Studio_System_GetEvent;
    da_FMOD_Studio_System_GetBus FMOD_Studio_System_GetBus;
    da_FMOD_Studio_System_GetVCA FMOD_Studio_System_GetVCA;
    da_FMOD_Studio_System_GetBank FMOD_Studio_System_GetBank;
    da_FMOD_Studio_System_GetEventByID FMOD_Studio_System_GetEventByID;
    da_FMOD_Studio_System_GetBusByID FMOD_Studio_System_GetBusByID;
    da_FMOD_Studio_System_GetVCAByID FMOD_Studio_System_GetVCAByID;
    da_FMOD_Studio_System_GetBankByID FMOD_Studio_System_GetBankByID;
    da_FMOD_Studio_System_GetSoundInfo FMOD_Studio_System_GetSoundInfo;
    da_FMOD_Studio_System_LookupID FMOD_Studio_System_LookupID;
    da_FMOD_Studio_System_LookupPath FMOD_Studio_System_LookupPath;
    da_FMOD_Studio_System_GetNumListeners FMOD_Studio_System_GetNumListeners;
    da_FMOD_Studio_System_SetNumListeners FMOD_Studio_System_SetNumListeners;
    da_FMOD_Studio_System_GetListenerAttributes FMOD_Studio_System_GetListenerAttributes;
    da_FMOD_Studio_System_SetListenerAttributes FMOD_Studio_System_SetListenerAttributes;
    da_FMOD_Studio_System_LoadBankFile FMOD_Studio_System_LoadBankFile;
    da_FMOD_Studio_System_LoadBankMemory FMOD_Studio_System_LoadBankMemory;
    da_FMOD_Studio_System_LoadBankCustom FMOD_Studio_System_LoadBankCustom;
    da_FMOD_Studio_System_RegisterPlugin FMOD_Studio_System_RegisterPlugin;
    da_FMOD_Studio_System_UnregisterPlugin FMOD_Studio_System_UnregisterPlugin;
    da_FMOD_Studio_System_UnloadAll FMOD_Studio_System_UnloadAll;
    da_FMOD_Studio_System_FlushCommands FMOD_Studio_System_FlushCommands;
    da_FMOD_Studio_System_StartCommandCapture FMOD_Studio_System_StartCommandCapture;
    da_FMOD_Studio_System_StopCommandCapture FMOD_Studio_System_StopCommandCapture;
    da_FMOD_Studio_System_LoadCommandReplay FMOD_Studio_System_LoadCommandReplay;
    da_FMOD_Studio_System_GetBankCount FMOD_Studio_System_GetBankCount;
    da_FMOD_Studio_System_GetBankList FMOD_Studio_System_GetBankList;
    da_FMOD_Studio_System_GetCPUUsage FMOD_Studio_System_GetCPUUsage;
    da_FMOD_Studio_System_GetBufferUsage FMOD_Studio_System_GetBufferUsage;
    da_FMOD_Studio_System_ResetBufferUsage FMOD_Studio_System_ResetBufferUsage;
    da_FMOD_Studio_System_SetCallback FMOD_Studio_System_SetCallback;
    da_FMOD_Studio_System_SetUserData FMOD_Studio_System_SetUserData;
    da_FMOD_Studio_System_GetUserData FMOD_Studio_System_GetUserData;
    
    /*
    EventDescription
*/
    da_FMOD_Studio_EventDescription_IsValid FMOD_Studio_EventDescription_IsValid;
    da_FMOD_Studio_EventDescription_GetID FMOD_Studio_EventDescription_GetID;
    da_FMOD_Studio_EventDescription_GetPath FMOD_Studio_EventDescription_GetPath;
    da_FMOD_Studio_EventDescription_GetParameterCount FMOD_Studio_EventDescription_GetParameterCount;
    da_FMOD_Studio_EventDescription_GetParameterByIndex FMOD_Studio_EventDescription_GetParameterByIndex;
    da_FMOD_Studio_EventDescription_GetParameter FMOD_Studio_EventDescription_GetParameter;
    da_FMOD_Studio_EventDescription_GetUserPropertyCount FMOD_Studio_EventDescription_GetUserPropertyCount;
    da_FMOD_Studio_EventDescription_GetUserPropertyByIndex FMOD_Studio_EventDescription_GetUserPropertyByIndex;
    da_FMOD_Studio_EventDescription_GetUserProperty FMOD_Studio_EventDescription_GetUserProperty;
    da_FMOD_Studio_EventDescription_GetLength FMOD_Studio_EventDescription_GetLength;
    da_FMOD_Studio_EventDescription_GetMinimumDistance FMOD_Studio_EventDescription_GetMinimumDistance;
    da_FMOD_Studio_EventDescription_GetMaximumDistance FMOD_Studio_EventDescription_GetMaximumDistance;
    da_FMOD_Studio_EventDescription_GetSoundSize FMOD_Studio_EventDescription_GetSoundSize;
    da_FMOD_Studio_EventDescription_IsOneshot FMOD_Studio_EventDescription_IsOneshot;
    da_FMOD_Studio_EventDescription_IsStream FMOD_Studio_EventDescription_IsStream;
    da_FMOD_Studio_EventDescription_Is3D FMOD_Studio_EventDescription_Is3D;
    da_FMOD_Studio_EventDescription_CreateInstance FMOD_Studio_EventDescription_CreateInstance;
    da_FMOD_Studio_EventDescription_GetInstanceCount FMOD_Studio_EventDescription_GetInstanceCount;
    da_FMOD_Studio_EventDescription_GetInstanceList FMOD_Studio_EventDescription_GetInstanceList;
    da_FMOD_Studio_EventDescription_LoadSampleData FMOD_Studio_EventDescription_LoadSampleData;
    da_FMOD_Studio_EventDescription_UnloadSampleData FMOD_Studio_EventDescription_UnloadSampleData;
    da_FMOD_Studio_EventDescription_GetSampleLoadingState FMOD_Studio_EventDescription_GetSampleLoadingState;
    da_FMOD_Studio_EventDescription_ReleaseAllInstances FMOD_Studio_EventDescription_ReleaseAllInstances;
    da_FMOD_Studio_EventDescription_SetCallback FMOD_Studio_EventDescription_SetCallback;
    da_FMOD_Studio_EventDescription_GetUserData FMOD_Studio_EventDescription_GetUserData;
    da_FMOD_Studio_EventDescription_SetUserData FMOD_Studio_EventDescription_SetUserData;
    
    /*
    EventInstance
*/
    da_FMOD_Studio_EventInstance_IsValid FMOD_Studio_EventInstance_IsValid;
    da_FMOD_Studio_EventInstance_GetDescription FMOD_Studio_EventInstance_GetDescription;
    da_FMOD_Studio_EventInstance_GetVolume FMOD_Studio_EventInstance_GetVolume;
    da_FMOD_Studio_EventInstance_SetVolume FMOD_Studio_EventInstance_SetVolume;
    da_FMOD_Studio_EventInstance_GetPitch FMOD_Studio_EventInstance_GetPitch;
    da_FMOD_Studio_EventInstance_SetPitch FMOD_Studio_EventInstance_SetPitch;
    da_FMOD_Studio_EventInstance_Get3DAttributes FMOD_Studio_EventInstance_Get3DAttributes;
    da_FMOD_Studio_EventInstance_Set3DAttributes FMOD_Studio_EventInstance_Set3DAttributes;
    da_FMOD_Studio_EventInstance_GetProperty FMOD_Studio_EventInstance_GetProperty;
    da_FMOD_Studio_EventInstance_SetProperty FMOD_Studio_EventInstance_SetProperty;
    da_FMOD_Studio_EventInstance_GetPaused FMOD_Studio_EventInstance_GetPaused;
    da_FMOD_Studio_EventInstance_SetPaused FMOD_Studio_EventInstance_SetPaused;
    da_FMOD_Studio_EventInstance_Start FMOD_Studio_EventInstance_Start;
    da_FMOD_Studio_EventInstance_Stop FMOD_Studio_EventInstance_Stop;
    da_FMOD_Studio_EventInstance_GetTimelinePosition FMOD_Studio_EventInstance_GetTimelinePosition;
    da_FMOD_Studio_EventInstance_SetTimelinePosition FMOD_Studio_EventInstance_SetTimelinePosition;
    da_FMOD_Studio_EventInstance_GetPlaybackState FMOD_Studio_EventInstance_GetPlaybackState;
    da_FMOD_Studio_EventInstance_GetChannelGroup FMOD_Studio_EventInstance_GetChannelGroup;
    da_FMOD_Studio_EventInstance_Release FMOD_Studio_EventInstance_Release;
    da_FMOD_Studio_EventInstance_IsVirtual FMOD_Studio_EventInstance_IsVirtual;
    da_FMOD_Studio_EventInstance_GetParameter FMOD_Studio_EventInstance_GetParameter;
    da_FMOD_Studio_EventInstance_GetParameterByIndex FMOD_Studio_EventInstance_GetParameterByIndex;
    da_FMOD_Studio_EventInstance_GetParameterCount FMOD_Studio_EventInstance_GetParameterCount;
    da_FMOD_Studio_EventInstance_SetParameterValue FMOD_Studio_EventInstance_SetParameterValue;
    da_FMOD_Studio_EventInstance_SetParameterValueByIndex FMOD_Studio_EventInstance_SetParameterValueByIndex;
    da_FMOD_Studio_EventInstance_GetCue FMOD_Studio_EventInstance_GetCue;
    da_FMOD_Studio_EventInstance_GetCueByIndex FMOD_Studio_EventInstance_GetCueByIndex;
    da_FMOD_Studio_EventInstance_GetCueCount FMOD_Studio_EventInstance_GetCueCount;
    da_FMOD_Studio_EventInstance_SetCallback FMOD_Studio_EventInstance_SetCallback;
    da_FMOD_Studio_EventInstance_GetUserData FMOD_Studio_EventInstance_GetUserData;
    da_FMOD_Studio_EventInstance_SetUserData FMOD_Studio_EventInstance_SetUserData;
    
    /*
    CueInstance
*/
    da_FMOD_Studio_CueInstance_IsValid FMOD_Studio_CueInstance_IsValid;
    da_FMOD_Studio_CueInstance_Trigger FMOD_Studio_CueInstance_Trigger;
    
    /*
    ParameterInstance
*/
    da_FMOD_Studio_ParameterInstance_IsValid FMOD_Studio_ParameterInstance_IsValid;
    da_FMOD_Studio_ParameterInstance_GetDescription FMOD_Studio_ParameterInstance_GetDescription;
    da_FMOD_Studio_ParameterInstance_GetValue FMOD_Studio_ParameterInstance_GetValue;
    da_FMOD_Studio_ParameterInstance_SetValue FMOD_Studio_ParameterInstance_SetValue;
    
    /*
    Bus
*/
    da_FMOD_Studio_Bus_IsValid FMOD_Studio_Bus_IsValid;
    da_FMOD_Studio_Bus_GetID FMOD_Studio_Bus_GetID;
    da_FMOD_Studio_Bus_GetPath FMOD_Studio_Bus_GetPath;
    da_FMOD_Studio_Bus_GetFaderLevel FMOD_Studio_Bus_GetFaderLevel;
    da_FMOD_Studio_Bus_SetFaderLevel FMOD_Studio_Bus_SetFaderLevel;
    da_FMOD_Studio_Bus_GetPaused FMOD_Studio_Bus_GetPaused;
    da_FMOD_Studio_Bus_SetPaused FMOD_Studio_Bus_SetPaused;
    da_FMOD_Studio_Bus_GetMute FMOD_Studio_Bus_GetMute;
    da_FMOD_Studio_Bus_SetMute FMOD_Studio_Bus_SetMute;
    da_FMOD_Studio_Bus_StopAllEvents FMOD_Studio_Bus_StopAllEvents;
    da_FMOD_Studio_Bus_LockChannelGroup FMOD_Studio_Bus_LockChannelGroup;
    da_FMOD_Studio_Bus_UnlockChannelGroup FMOD_Studio_Bus_UnlockChannelGroup;
    da_FMOD_Studio_Bus_GetChannelGroup FMOD_Studio_Bus_GetChannelGroup;
    
    /*
    VCA
*/
    da_FMOD_Studio_VCA_IsValid FMOD_Studio_VCA_IsValid;
    da_FMOD_Studio_VCA_GetID FMOD_Studio_VCA_GetID;
    da_FMOD_Studio_VCA_GetPath FMOD_Studio_VCA_GetPath;
    da_FMOD_Studio_VCA_GetFaderLevel FMOD_Studio_VCA_GetFaderLevel;
    da_FMOD_Studio_VCA_SetFaderLevel FMOD_Studio_VCA_SetFaderLevel;
    
    /*
    Bank
*/
    da_FMOD_Studio_Bank_IsValid FMOD_Studio_Bank_IsValid;
    da_FMOD_Studio_Bank_GetID FMOD_Studio_Bank_GetID;
    da_FMOD_Studio_Bank_GetPath FMOD_Studio_Bank_GetPath;
    da_FMOD_Studio_Bank_Unload FMOD_Studio_Bank_Unload;
    da_FMOD_Studio_Bank_LoadSampleData FMOD_Studio_Bank_LoadSampleData;
    da_FMOD_Studio_Bank_UnloadSampleData FMOD_Studio_Bank_UnloadSampleData;
    da_FMOD_Studio_Bank_GetLoadingState FMOD_Studio_Bank_GetLoadingState;
    da_FMOD_Studio_Bank_GetSampleLoadingState FMOD_Studio_Bank_GetSampleLoadingState;
    da_FMOD_Studio_Bank_GetStringCount FMOD_Studio_Bank_GetStringCount;
    da_FMOD_Studio_Bank_GetStringInfo FMOD_Studio_Bank_GetStringInfo;
    da_FMOD_Studio_Bank_GetEventCount FMOD_Studio_Bank_GetEventCount;
    da_FMOD_Studio_Bank_GetEventList FMOD_Studio_Bank_GetEventList;
    da_FMOD_Studio_Bank_GetBusCount FMOD_Studio_Bank_GetBusCount;
    da_FMOD_Studio_Bank_GetBusList FMOD_Studio_Bank_GetBusList;
    da_FMOD_Studio_Bank_GetVCACount FMOD_Studio_Bank_GetVCACount;
    da_FMOD_Studio_Bank_GetVCAList FMOD_Studio_Bank_GetVCAList;
    da_FMOD_Studio_Bank_GetUserData FMOD_Studio_Bank_GetUserData;
    da_FMOD_Studio_Bank_SetUserData FMOD_Studio_Bank_SetUserData;
    
    /*
    Command playback information
*/
    da_FMOD_Studio_CommandReplay_IsValid FMOD_Studio_CommandReplay_IsValid;
    da_FMOD_Studio_CommandReplay_GetSystem FMOD_Studio_CommandReplay_GetSystem;
    da_FMOD_Studio_CommandReplay_GetLength FMOD_Studio_CommandReplay_GetLength;
    da_FMOD_Studio_CommandReplay_GetCommandCount FMOD_Studio_CommandReplay_GetCommandCount;
    da_FMOD_Studio_CommandReplay_GetCommandInfo FMOD_Studio_CommandReplay_GetCommandInfo;
    da_FMOD_Studio_CommandReplay_GetCommandString FMOD_Studio_CommandReplay_GetCommandString;
    da_FMOD_Studio_CommandReplay_GetCommandAtTime FMOD_Studio_CommandReplay_GetCommandAtTime;
    da_FMOD_Studio_CommandReplay_SetBankPath FMOD_Studio_CommandReplay_SetBankPath;
    da_FMOD_Studio_CommandReplay_Start FMOD_Studio_CommandReplay_Start;
    da_FMOD_Studio_CommandReplay_Stop FMOD_Studio_CommandReplay_Stop;
    da_FMOD_Studio_CommandReplay_SeekToTime FMOD_Studio_CommandReplay_SeekToTime;
    da_FMOD_Studio_CommandReplay_SeekToCommand FMOD_Studio_CommandReplay_SeekToCommand;
    da_FMOD_Studio_CommandReplay_GetPaused FMOD_Studio_CommandReplay_GetPaused;
    da_FMOD_Studio_CommandReplay_SetPaused FMOD_Studio_CommandReplay_SetPaused;
    da_FMOD_Studio_CommandReplay_GetPlaybackState FMOD_Studio_CommandReplay_GetPlaybackState;
    da_FMOD_Studio_CommandReplay_GetCurrentCommand FMOD_Studio_CommandReplay_GetCurrentCommand;
    da_FMOD_Studio_CommandReplay_Release FMOD_Studio_CommandReplay_Release;
    da_FMOD_Studio_CommandReplay_SetFrameCallback FMOD_Studio_CommandReplay_SetFrameCallback;
    da_FMOD_Studio_CommandReplay_SetLoadBankCallback FMOD_Studio_CommandReplay_SetLoadBankCallback;
    da_FMOD_Studio_CommandReplay_SetCreateInstanceCallback FMOD_Studio_CommandReplay_SetCreateInstanceCallback;
    da_FMOD_Studio_CommandReplay_GetUserData FMOD_Studio_CommandReplay_GetUserData;
    da_FMOD_Studio_CommandReplay_SetUserData FMOD_Studio_CommandReplay_SetUserData;
}


  

