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
module derelict.fmod.dsp;

import derelict.util.system;

import derelict.fmod.common;
import derelict.fmod.dsp_effects;

align(1):

struct FMOD_DSP_BUFFER_ARRAY
{
    int                numbuffers;              /* [r/w] number of buffers */
    int               *buffernumchannels;       /* [r/w] array of number of channels for each buffer */
    FMOD_CHANNELMASK  *bufferchannelmask;       /* [r/w] array of channel masks for each buffer */
    float            **buffers;                 /* [r/w] array of buffers */
    FMOD_SPEAKERMODE   speakermode;             /* [r/w] speaker mode for all buffers in the array */
}

alias FMOD_DSP_PROCESS_OPERATION = int;
enum
{
    FMOD_DSP_PROCESS_PERFORM,                   /* Process the incoming audio in 'inbufferarray' and output to 'outbufferarray'. */
    FMOD_DSP_PROCESS_QUERY                      /* The DSP is being queried for the expected output format and whether it needs to process audio or should be bypassed.  The function should return FMOD_OK, or FMOD_ERR_DSP_DONTPROCESS or FMOD_ERR_DSP_SILENCE if audio can pass through unprocessed. See remarks for more.  If audio is to be processed, 'outbufferarray' must be filled with the expected output format, channel count and mask. */
}

struct FMOD_COMPLEX
{
    float real_; /* Real component */
    float imag; /* Imaginary component */
}

alias FMOD_DSP_PAN_SURROUND_FLAGS = int;
enum
{
    FMOD_DSP_PAN_SURROUND_DEFAULT = 0,
    FMOD_DSP_PAN_SURROUND_ROTATION_NOT_BIASED = 1,
    
    FMOD_DSP_PAN_SURROUND_FLAGS_FORCEINT = 65536     /* Makes sure this enum is signed 32bit. */
} 

alias FMOD_DSP_CREATE_CALLBACK = FMOD_RESULT               function(FMOD_DSP_STATE *dsp_state);
alias FMOD_DSP_RELEASE_CALLBACK = FMOD_RESULT              function(FMOD_DSP_STATE *dsp_state);
alias FMOD_DSP_RESET_CALLBACK = FMOD_RESULT                function(FMOD_DSP_STATE *dsp_state);
alias FMOD_DSP_SETPOSITION_CALLBACK = FMOD_RESULT          function(FMOD_DSP_STATE *dsp_state, uint pos);
alias FMOD_DSP_READ_CALLBACK = FMOD_RESULT                 function(FMOD_DSP_STATE *dsp_state, float *inbuffer, float *outbuffer, uint length, int inchannels, int *outchannels);
alias FMOD_DSP_SHOULDIPROCESS_CALLBACK = FMOD_RESULT       function(FMOD_DSP_STATE *dsp_state, FMOD_BOOL inputsidle, uint length, FMOD_CHANNELMASK inmask, int inchannels, FMOD_SPEAKERMODE speakermode);
alias FMOD_DSP_PROCESS_CALLBACK = FMOD_RESULT              function(FMOD_DSP_STATE *dsp_state, uint length, const FMOD_DSP_BUFFER_ARRAY *inbufferarray, FMOD_DSP_BUFFER_ARRAY *outbufferarray, FMOD_BOOL inputsidle, FMOD_DSP_PROCESS_OPERATION op);
alias FMOD_DSP_SETPARAM_FLOAT_CALLBACK = FMOD_RESULT       function(FMOD_DSP_STATE *dsp_state, int index, float value);
alias FMOD_DSP_SETPARAM_INT_CALLBACK = FMOD_RESULT         function(FMOD_DSP_STATE *dsp_state, int index, int value);
alias FMOD_DSP_SETPARAM_BOOL_CALLBACK = FMOD_RESULT        function(FMOD_DSP_STATE *dsp_state, int index, FMOD_BOOL value);
alias FMOD_DSP_SETPARAM_DATA_CALLBACK = FMOD_RESULT        function(FMOD_DSP_STATE *dsp_state, int index, void *data, uint length);
alias FMOD_DSP_GETPARAM_FLOAT_CALLBACK = FMOD_RESULT       function(FMOD_DSP_STATE *dsp_state, int index, float *value, char *valuestr);
alias FMOD_DSP_GETPARAM_INT_CALLBACK = FMOD_RESULT         function(FMOD_DSP_STATE *dsp_state, int index, int *value, char *valuestr);
alias FMOD_DSP_GETPARAM_BOOL_CALLBACK = FMOD_RESULT        function(FMOD_DSP_STATE *dsp_state, int index, FMOD_BOOL *value, char *valuestr);
alias FMOD_DSP_GETPARAM_DATA_CALLBACK = FMOD_RESULT        function(FMOD_DSP_STATE *dsp_state, int index, void **data, uint *length, char *valuestr);

alias FMOD_DSP_SYSTEM_REGISTER_CALLBACK = FMOD_RESULT		function (FMOD_DSP_STATE *dsp_state);
alias FMOD_DSP_SYSTEM_DEREGISTER_CALLBACK = FMOD_RESULT		function (FMOD_DSP_STATE *dsp_state);
alias FMOD_DSP_SYSTEM_MIX_CALLBACK = FMOD_RESULT			function (FMOD_DSP_STATE *dsp_state, int stage);

alias FMOD_DSP_SYSTEM_GETSAMPLERATE = FMOD_RESULT          function(FMOD_DSP_STATE *dsp_state, int *rate);
alias FMOD_DSP_SYSTEM_GETBLOCKSIZE = FMOD_RESULT           function(FMOD_DSP_STATE *dsp_state, uint *blocksize);
alias FMOD_DSP_SYSTEM_GETSPEAKERMODE = FMOD_RESULT         function(FMOD_DSP_STATE *dsp_state, FMOD_SPEAKERMODE* speakermode_mixer, FMOD_SPEAKERMODE* speakermode_output);

alias FMOD_DSP_DFT_FFTREAL = FMOD_RESULT                   function(FMOD_DSP_STATE* thisdsp, int size, const float *signal, FMOD_COMPLEX* dft, const float *window, int signalhop);
alias FMOD_DSP_DFT_IFFTREAL = FMOD_RESULT                  function(FMOD_DSP_STATE* thisdsp, int size, const FMOD_COMPLEX *dft, float* signal, const float *window, int signalhop);
alias FMOD_DSP_PAN_SUM_MONO_MATRIX = FMOD_RESULT               function(FMOD_DSP_STATE *dsp_state, int sourceSpeakerMode, float lowFrequencyGain, float overallGain, float *matrix);
alias FMOD_DSP_PAN_SUM_STEREO_MATRIX = FMOD_RESULT             function(FMOD_DSP_STATE *dsp_state, int sourceSpeakerMode, float pan, float lowFrequencyGain, float overallGain, int matrixHop, float *matrix);
alias FMOD_DSP_PAN_SUM_SURROUND_MATRIX = FMOD_RESULT           function(FMOD_DSP_STATE *dsp_state, int sourceSpeakerMode, int targetSpeakerMode, float direction, float extent, float rotation, float lowFrequencyGain, float overallGain, int matrixHop, float *matrix, FMOD_DSP_PAN_SURROUND_FLAGS flags);
alias FMOD_DSP_PAN_SUM_MONO_TO_SURROUND_MATRIX = FMOD_RESULT   function(FMOD_DSP_STATE *dsp_state, int targetSpeakerMode, float direction, float extent, float lowFrequencyGain, float overallGain, int matrixHop, float *matrix);
alias FMOD_DSP_PAN_SUM_STEREO_TO_SURROUND_MATRIX = FMOD_RESULT  function(FMOD_DSP_STATE *dsp_state, int targetSpeakerMode, float direction, float extent, float rotation, float lowFrequencyGain, float overallGain, int matrixHop, float *matrix);
alias FMOD_DSP_PAN_3D_GET_ROLLOFF_GAIN = FMOD_RESULT           function(FMOD_DSP_STATE *dsp_state, FMOD_DSP_PAN_3D_ROLLOFF_TYPE rolloff, float distance, float mindistance, float maxdistance, float *gain);
alias FMOD_DSP_STATE_GETCLOCK = FMOD_RESULT                    function(FMOD_DSP_STATE *dsp_state, ulong *clock, uint *offset, uint *length);

static immutable FMOD_DSP_GETPARAM_VALUESTR_LENGTH = 32;

alias FMOD_DSP_PARAMETER_TYPE = int;
enum
{
    FMOD_DSP_PARAMETER_TYPE_FLOAT,
    FMOD_DSP_PARAMETER_TYPE_INT,
    FMOD_DSP_PARAMETER_TYPE_BOOL,
    FMOD_DSP_PARAMETER_TYPE_DATA,
    
    FMOD_DSP_PARAMETER_TYPE_MAX,                /* Maximum number of DSP parameter types. */
    FMOD_DSP_PARAMETER_TYPE_FORCEINT = 65536    /* Makes sure this enum is signed 32bit. */
}

alias FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE = int;
enum
{
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_LINEAR,               /* Values mapped linearly across range. */
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_AUTO,                 /* A mapping is automatically chosen based on range and units.  See remarks. */
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR,     /* Values mapped in a piecewise linear fashion defined by FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR. */
    
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_FORCEINT = 65536      /* Makes sure this enum is signed 32bit. */
}

struct FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR
{
    int numpoints;                              /* [w] The number of <position, value> pairs in the piecewise mapping (at least 2). */
    float *pointparamvalues;                    /* [w] The values in the parameter's units for each point */
    float *pointpositions;                      /* [w] The positions along the control's scale (e.g. dial angle) corresponding to each parameter value.  The range of this scale is arbitrary and all positions will be relative to the minimum and maximum values (e.g. [0,1,3] is equivalent to [1,2,4] and [2,4,8]).  If this array is zero, pointparamvalues will be distributed with equal spacing. */
}

struct FMOD_DSP_PARAMETER_FLOAT_MAPPING
{
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE type;
    FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR piecewiselinearmapping; /* [w] Only required for FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR type mapping. */
}

struct FMOD_DSP_PARAMETER_DESC_FLOAT
{
    float                     min;                      /* [w] Minimum parameter value. */
    float                     max;                      /* [w] Maximum parameter value. */
    float                     defaultval;               /* [w] Default parameter value. */
    FMOD_DSP_PARAMETER_FLOAT_MAPPING mapping;           /* [w] How the values are distributed across dials and automation curves (e.g. linearly, exponentially etc). */
}

struct FMOD_DSP_PARAMETER_DESC_INT
{
    int                       min;                      /* [w] Minimum parameter value. */
    int                       max;                      /* [w] Maximum parameter value. */
    int                       defaultval;               /* [w] Default parameter value. */
    FMOD_BOOL                 goestoinf;                /* [w] Whether the last value represents infiniy. */
    const char**        valuenames;               /* [w] Names for each value.  There should be as many strings as there are possible values (max - min + 1).  Optional. */
}

struct FMOD_DSP_PARAMETER_DESC_BOOL
{
    FMOD_BOOL                 defaultval;               /* [w] Default parameter value. */
    const char**        valuenames;               /* [w] Names for false and true, respectively.  There should be two strings.  Optional. */
}

struct FMOD_DSP_PARAMETER_DESC_DATA
{
    int                       datatype;                 /* [w] The type of data for this parameter.  Use 0 or above for custom types or set to one of the FMOD_DSP_PARAMETER_DATA_TYPE values. */
}

struct FMOD_DSP_PARAMETER_DESC
{
    FMOD_DSP_PARAMETER_TYPE   type;                 /* [w] Type of this parameter. */
    char[16]                      name;             /* [w] Name of the parameter to be displayed (ie "Cutoff frequency"). */
    char[16]                      label;            /* [w] Short string to be put next to value to denote the unit type (ie "hz"). */
    const char               *description;          /* [w] Description of the parameter to be displayed as a help item / tooltip for this parameter. */
    
    union
    {
        FMOD_DSP_PARAMETER_DESC_FLOAT   floatdesc;  /* [w] Struct containing information about the parameter in floating point format.  Use when type is FMOD_DSP_PARAMETER_TYPE_FLOAT. */
        FMOD_DSP_PARAMETER_DESC_INT     intdesc;    /* [w] Struct containing information about the parameter in integer format.  Use when type is FMOD_DSP_PARAMETER_TYPE_INT. */
        FMOD_DSP_PARAMETER_DESC_BOOL    booldesc;   /* [w] Struct containing information about the parameter in boolean format.  Use when type is FMOD_DSP_PARAMETER_TYPE_BOOL. */
        FMOD_DSP_PARAMETER_DESC_DATA    datadesc;   /* [w] Struct containing information about the parameter in data format.  Use when type is FMOD_DSP_PARAMETER_TYPE_DATA. */
    }
}

alias FMOD_DSP_PARAMETER_DATA_TYPE = int;
enum
{
    FMOD_DSP_PARAMETER_DATA_TYPE_USER = 0,                  /* The default data type.  All user data types should be 0 or above. */
    FMOD_DSP_PARAMETER_DATA_TYPE_OVERALLGAIN = -1,          /* The data type for FMOD_DSP_PARAMETER_OVERALLGAIN parameters.  There should a maximum of one per DSP. */
    FMOD_DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES = -2,         /* The data type for FMOD_DSP_PARAMETER_3DATTRIBUTES parameters.  There should a maximum of one per DSP. */
    FMOD_DSP_PARAMETER_DATA_TYPE_SIDECHAIN = -3,            /* The data type for FMOD_DSP_PARAMETER_SIDECHAIN parameters.  There should a maximum of one per DSP. */
    FMOD_DSP_PARAMETER_DATA_TYPE_FFT = -4,                  /* The data type for FMOD_DSP_PARAMETER_FFT parameters.  There should a maximum of one per DSP. */
    FMOD_DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES_MULTI = -5,   /* The data type for FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI parameters.  There should a maximum of one per DSP. */
}

struct FMOD_DSP_PARAMETER_OVERALLGAIN
{
    float linear_gain;                                  /* [r] The overall linear gain of the effect on the direct signal path */
    float linear_gain_additive;                         /* [r] Additive gain, for parallel signal paths */
}

struct FMOD_DSP_PARAMETER_3DATTRIBUTES
{
    FMOD_3D_ATTRIBUTES relative;                        /* [w] The position of the sound relative to the listener. */
    FMOD_3D_ATTRIBUTES absolute;                        /* [w] The position of the sound in world coordinates. */
}

struct FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI
{
    int                numlisteners;                    /* [w] The number of listeners. */
    FMOD_3D_ATTRIBUTES[FMOD_MAX_LISTENERS] relative;    /* [w] The position of the sound relative to the listeners. */
    FMOD_3D_ATTRIBUTES absolute;                        /* [w] The position of the sound in world coordinates. */
}

struct FMOD_DSP_PARAMETER_SIDECHAIN
{
    FMOD_BOOL sidechainenable;                               /* [r/w] Whether sidechains are enabled. */
}

struct FMOD_DSP_PARAMETER_FFT
{
    int     length;                                    /* [r] Number of entries in this spectrum window.   Divide this by the output rate to get the hz per entry. */
    int     numchannels;                               /* [r] Number of channels in spectrum. */
    float[32]  *spectrum;                              /* [r] Per channel spectrum arrays.  See remarks for more. */
}

static immutable FMOD_PLUGIN_SDK_VERSION = 108;

struct FMOD_DSP_DESCRIPTION
{
    uint                     pluginsdkversion;   /* [w] The plugin SDK version this plugin is built for.  set to this to FMOD_PLUGIN_SDK_VERSION defined above. */
    char[32]                             name;           /* [w] The identifier of the DSP. This will also be used as the name of DSP and shouldn't change between versions. */
    uint                     version_;            /* [w] Plugin writer's version number. */
    int                              numinputbuffers;    /* [w] Number of input buffers to process.  Use 0 for DSPs that only generate sound and 1 for effects that process incoming sound. */
    int                              numoutputbuffers;   /* [w] Number of audio output buffers.  Only one output buffer is currently supported. */
    FMOD_DSP_CREATE_CALLBACK         create;             /* [w] Create callback.  This is called when DSP unit is created.  Can be null. */
    FMOD_DSP_RELEASE_CALLBACK        release;            /* [w] Release callback.  This is called just before the unit is freed so the user can do any cleanup needed for the unit.  Can be null. */
    FMOD_DSP_RESET_CALLBACK          reset;              /* [w] Reset callback.  This is called by the user to reset any history buffers that may need resetting for a filter, when it is to be used or re-used for the first time to its initial clean state.  Use to avoid clicks or artifacts. */
    FMOD_DSP_READ_CALLBACK           read;               /* [w] Read callback.  Processing is done here.  Can be null. */
    FMOD_DSP_PROCESS_CALLBACK        process;            /* [w] Process callback.  Can be specified instead of the read callback if any channel format changes occur between input and output.  This also replaces shouldiprocess and should return an error if the effect is to be bypassed.  Can be null. */
    FMOD_DSP_SETPOSITION_CALLBACK    setposition;        /* [w] Set position callback.  This is called if the unit wants to update its position info but not process data, or reset a cursor position internally if it is reading data from a certain source.  Can be null. */
    
    int                              numparameters;      /* [w] Number of parameters used in this filter.  The user finds this with DSP::getNumParameters */
    FMOD_DSP_PARAMETER_DESC        **paramdesc;          /* [w] Variable number of parameter structures. */
    FMOD_DSP_SETPARAM_FLOAT_CALLBACK setparameterfloat;  /* [w] This is called when the user calls DSP::setParameterFloat. Can be null. */
    FMOD_DSP_SETPARAM_INT_CALLBACK   setparameterint;    /* [w] This is called when the user calls DSP::setParameterInt.   Can be null. */
    FMOD_DSP_SETPARAM_BOOL_CALLBACK  setparameterbool;   /* [w] This is called when the user calls DSP::setParameterBool.  Can be null. */
    FMOD_DSP_SETPARAM_DATA_CALLBACK  setparameterdata;   /* [w] This is called when the user calls DSP::setParameterData.  Can be null. */
    FMOD_DSP_GETPARAM_FLOAT_CALLBACK getparameterfloat;  /* [w] This is called when the user calls DSP::getParameterFloat. Can be null. */
    FMOD_DSP_GETPARAM_INT_CALLBACK   getparameterint;    /* [w] This is called when the user calls DSP::getParameterInt.   Can be null. */
    FMOD_DSP_GETPARAM_BOOL_CALLBACK  getparameterbool;   /* [w] This is called when the user calls DSP::getParameterBool.  Can be null. */
    FMOD_DSP_GETPARAM_DATA_CALLBACK  getparameterdata;   /* [w] This is called when the user calls DSP::getParameterData.  Can be null. */
    FMOD_DSP_SHOULDIPROCESS_CALLBACK shouldiprocess;     /* [w] This is called before processing.  You can detect if inputs are idle and return FMOD_OK to process, or any other error code to avoid processing the effect.  Use a count down timer to allow effect tails to process before idling! */
    void                            *userdata;           /* [w] Optional. Specify 0 to ignore. This is user data to be attached to the DSP unit during creation.  Access via DSP::getUserData. */

	FMOD_DSP_SYSTEM_REGISTER_CALLBACK   sys_register;       /* [w] Register callback.  This is called when DSP unit is loaded/registered.  Useful for 'global'/per system object init for plugin.  Can be null. */
    FMOD_DSP_SYSTEM_DEREGISTER_CALLBACK sys_deregister;     /* [w] Deregister callback.  This is called when DSP unit is unloaded/deregistered.  Useful as 'global'/per system object shutdown for plugin.  Can be null. */
    FMOD_DSP_SYSTEM_MIX_CALLBACK        sys_mix;            /* [w] System mix stage callback.  This is called when the mixer starts to execute or is just finishing executing.  Useful for 'global'/per system object once a mix update calls for a plugin.  Can be null. */
}

struct FMOD_DSP_STATE_DFTCALLBACKS
{
    FMOD_DSP_DFT_FFTREAL                            fftreal;        /* [r] Callback for performing an FFT on a real signal. */
    FMOD_DSP_DFT_IFFTREAL                           inversefftreal; /* [r] Callback for performing an inverse FFT to get a real signal. */
}

struct FMOD_DSP_STATE_PAN_CALLBACKS
{
    FMOD_DSP_PAN_SUM_MONO_MATRIX                summonomatrix;
    FMOD_DSP_PAN_SUM_STEREO_MATRIX              sumstereomatrix;
    FMOD_DSP_PAN_SUM_SURROUND_MATRIX            sumsurroundmatrix;
    FMOD_DSP_PAN_SUM_MONO_TO_SURROUND_MATRIX    summonotosurroundmatrix;
    FMOD_DSP_PAN_SUM_STEREO_TO_SURROUND_MATRIX  sumstereotosurroundmatrix;
    FMOD_DSP_PAN_3D_GET_ROLLOFF_GAIN            getrolloffgain;
}

struct FMOD_DSP_STATE_SYSTEMCALLBACKS
{
    FMOD_MEMORY_ALLOC_CALLBACK              alloc;          /* [r] Memory allocation callback. Use this for all dynamic memory allocation within the plugin. */
    FMOD_MEMORY_REALLOC_CALLBACK            realloc;        /* [r] Memory reallocation callback. */
    FMOD_MEMORY_FREE_CALLBACK               free;           /* [r] Memory free callback. */
    FMOD_DSP_SYSTEM_GETSAMPLERATE           getsamplerate;  /* [r] Callback for getting the system samplerate. */
    FMOD_DSP_SYSTEM_GETBLOCKSIZE            getblocksize;   /* [r] Callback for getting the system's block size.  DSPs will be requested to process blocks of varying length up to this size.*/
    FMOD_DSP_STATE_DFTCALLBACKS            *dft;            /* [r] Struct containing callbacks for performing FFTs and inverse FFTs. */
    FMOD_DSP_STATE_PAN_CALLBACKS           *pancallbacks;   /* [r] Pointer to a structure of callbacks for calculating pan, up-mix and down-mix matrices. */
    FMOD_DSP_SYSTEM_GETSPEAKERMODE          getspeakermode; /* [r] Callback for getting the system's speaker modes.  One is the mixer's default speaker mode, the other is the output mode the system is downmixing or upmixing to.*/
    FMOD_DSP_STATE_GETCLOCK                 getclock;       /* [r] Callback for getting the clock of the current DSP, as well as the subset of the input buffer that contains the signal */
}

struct FMOD_DSP_STATE
{
    FMOD_DSP                       *instance;            /* [r] Handle to the FMOD_DSP object the callback is associated with.  Not to be modified.  C++ users cast to FMOD::DSP to use.  */
    void                           *plugindata;          /* [r/w] Plugin writer created data the output author wants to attach to this object. */
    FMOD_CHANNELMASK                channelmask;         /* [r] Specifies which speakers the DSP effect is active on */
    FMOD_SPEAKERMODE                source_speakermode;  /* [r] Specifies which speaker mode the signal originated for information purposes, ie in case panning needs to be done differently. */
    float                          *sidechaindata;       /* [r] The mixed result of all incoming sidechains is stored at this pointer address. */
    int                             sidechainchannels;   /* [r] The number of channels of pcm data stored within the sidechain buffer. */
    FMOD_DSP_STATE_SYSTEMCALLBACKS *callbacks;           /* [r] Struct containing callbacks for system level functionality. */
}

/+
static immutable FMOD_DSP_STATE_MEMALLOC(_state, _size, _type, _str)                        (_state)->callbacks->alloc         (_size, _type, _str);                                     /* Pass in the FMOD_DSP_STATE handle, size in bytes to alloc, FMOD_MEMORY_TYPE type and optional char * string to identify where the alloc came from. */
static immutable FMOD_DSP_STATE_MEMREALLOC(_state, _ptr, _size, _type, _str)                (_state)->callbacks->realloc       (_ptr, _size, _type, _str);                               /* Pass in the FMOD_DSP_STATE handle, optional existing memory pointer, size in bytes to alloc, FMOD_MEMORY_TYPE type and optional char * string to identify where the alloc came from. */
static immutable FMOD_DSP_STATE_MEMFREE(_state, _ptr, _type, _str)                          (_state)->callbacks->free          (_ptr, _type, _str);                                      /* Pass in the FMOD_DSP_STATE handle, existing memory pointer, FMOD_MEMORY_TYPE type and optional char * string to identify where the free came from. */
static immutable FMOD_DSP_STATE_GETSAMPLERATE(_state, _rate)                                (_state)->callbacks->getsamplerate (_state, _rate);                                          /* Pass in the FMOD_DSP_STATE handle, and the address of an int to receive the system DSP sample rate. */
static immutable FMOD_DSP_STATE_GETBLOCKSIZE(_state, _blocksize)                            (_state)->callbacks->getblocksize  (_state, _blocksize);                                     /* Pass in the FMOD_DSP_STATE handle, and the address of an unsigned int to receive the system DSP block size. */
static immutable FMOD_DSP_STATE_FFTREAL(_state, _size, _signal, _dft, _window, _signalhop)  (_state)->callbacks->dft->fftreal  (_state, _size, _signal, _dft, _window, _signalhop);      /* Pass in the FMOD_DSP_STATE handle, size of the signal and its DFT, a float buffer containing the signal and an FMOD_COMPLEX buffer to store the calculated DFT. */
static immutable FMOD_DSP_STATE_IFFTREAL(_state, _size, _dft, _signal, _window, _signalhop) (_state)->callbacks->dft->inversefftreal(_state, _size, _dft, _signal, _window, _signalhop); /* Pass in the FMOD_DSP_STATE handle, size of the DFT and its signal, an FMOD_COMPLEX buffer containing the DFT and a float buffer to store the calculated signal. */
+/

struct FMOD_DSP_METERING_INFO
{
    int   numsamples;       /* [r] The number of samples considered for this metering info. */
    float[32] peaklevel;    /* [r] The peak level per channel. */
    float[32] rmslevel;     /* [r] The rms level per channel. */
    short numchannels;      /* [r] Number of channels. */
}